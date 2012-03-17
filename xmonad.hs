-- Import ---
import XMonad
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Actions.CycleWS
import XMonad.ManageHook
import XMonad.Layout.Magnifier
import XMonad.Layout.PerWorkspace
import XMonad.Layout.OneBig
import System.IO
import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
-- End Import ---

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageScratchPad 
        <+> manageHook defaultConfig
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP  xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "gray" "" . shorten 50
            , ppOrder = \(ws:_:t:_) -> [ws, t]
            , ppSort  = fmap (namedScratchpadFilterOutWorkspace.) (ppSort xmobarPP) -- hide NSP from the workspace list
            }
        , terminal    = myTerminal
        , modMask     = myModMask
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , keys = myKeys
        , workspaces = myWorkSpaces
        } 

myTerminal    = "urxvt"
myModMask     = mod1Mask	
myBorderWidth = 1
myNormalBorderColor = "black"
myFocusedBorderColor = "gray"

myLayout = avoidStruts $  
            onWorkspace "web" Full $
            onWorkspace "WM" tiled $ 
            onWorkspace "irc" onebig $ 
            onWorkspace "share" onebig $ 
            standardLayout
    where
        standardLayout =  magnifier' (Tall 1 (3/100) (60/100)) ||| tiled
        tiled = Tall 1 (3/100) (1/2) 
        onebig = OneBig (3/4) (3/4)

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-[1..9], cambia al espacio de trabajo N
    -- mod-shift-[1..9], muev cliente al espacio de trabajo N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- lanza el salvapantallas (i3lock)
    [ ((modm .|. shiftMask, xK_l), spawn "i3lock -c 000000")
    -- espacio de trabajo siguiente
    , ((modm, xK_Right), nextWS)
    -- espacio de trabajo anterior
    , ((modm, xK_Left), prevWS)
    -- subir el volumen de sonido
    , ((modm, xK_Up), spawn "amixer sset Master,0 1+")
    -- bajar el volumen de sonido
    , ((modm, xK_Down), spawn "amixer sset Master,0 1-")
    -- lanzar una terminal
    ,((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- lanzar dmenu
    , ((modm, xK_p), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    -- lanzar gmrun
    , ((modm .|. shiftMask, xK_p), spawn "gmrun")
    -- cierra la ventana actual
    , ((modm .|. shiftMask, xK_c), kill)
    -- va rotando entre los distintos algoritmos de distribución 
    , ((modm, xK_space), sendMessage NextLayout)
    -- reinicia el esquema del espacio de trabajo actual al por defecto
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- cambia las ventanas al tamaño correcto
    , ((modm, xK_n), refresh)
    -- mueve el foco a la ventana siguiente
    , ((modm, xK_Tab), windows W.focusDown)
    -- mueve el foco a la ventana anterior
    , ((modm, xK_j), windows W.focusDown)
    -- mueve el foco a la ventana anterior
    , ((modm, xK_k), windows W.focusUp)
    -- mueve el foco a la ventana maestra
    , ((modm, xK_m), windows W.focusMaster)
    -- convierte la ventana con foo en la ventana maestra
    , ((modm, xK_Return), windows W.swapMaster)
    -- cambia el foco con la ventana siguiente
    , ((modm .|. shiftMask, xK_j), windows W.swapDown)
    -- cambia el foco con la ventana anterior
    , ((modm .|. shiftMask, xK_k), windows W.swapUp)
    -- encoge el área maestra
    , ((modm, xK_h), sendMessage Shrink)
    -- estira el área maestra
    , ((modm, xK_l), sendMessage Expand)
    -- devuelve una venta flotante al esquema en uso 
    , ((modm, xK_t), withFocused $ windows . W.sink)
    -- comandos de búsqueda
    , ((modm, xK_s), SM.submap $ searchEngineMap $ S.promptSearch P.defaultXPConfig)
    , ((modm .|. shiftMask, xK_s), SM.submap $ searchEngineMap $ S.selectSearch)
    -- aumenta el número de ventanas en el área maestra
  , ((modm, xK_comma), sendMessage (IncMasterN 1))
    -- reduce el número de ventanas en el área maestra
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    -- cambia el hueco de la barra de estado
    , ((modm, xK_b), sendMessage ToggleStruts)
    -- salir de xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
    -- reiniciar xmonad
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
    -- scratchpad
    , ((modm, xK_g), scratchPad)
    ]
        where
            scratchPad = scratchpadSpawnActionTerminal myTerminal

searchEngineMap method = M.fromList $
      [ ((0, xK_g), method S.google)
      , ((0, xK_w), method S.wikipedia)
      , ((0, xK_p), method $ S.searchEngine "pirate" "https://thepiratebay.se/search/")
      ]

myWorkSpaces = ["code", "web", "VM", "irc", "share"] ++ map show [6..9]

myManageHook = composeAll . concat $
    [[ title =? t --> doFloat | t <- myTitleFloats]
    ,[ className =? c --> doFloat | c <- myFloats]
    ]
    where
        myTitleFloats = ["Moviendo archivos" 
                        , "Copiando archivos" 
                        , "Oracle VM VirtualBox Administrador"
                        , "Progreso"
                        , "Renombrar archivo"
                        ]
        myFloats = ["smplayer"
                   , "Wine"
                   , "acroread-en"
                   , "libreoffice-calc"
                   ]

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
    where
        h = 0.3
        w = 1
        t = 1 - h
        l = 1 - w
