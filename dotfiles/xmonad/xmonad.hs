import XMonad
import XMonad.Util.EZConfig
import XMonad.Actions.SpawnOn (spawnOn, manageSpawn)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import Graphics.X11.ExtraTypes.XF86

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 2 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

myLayoutHook = avoidStruts $ spacingWithEdge 3 $ myLayout

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "Emacs" --> doShift "2"
  ]

myStartupHook :: X ()
myStartupHook = do
    -- Spawns an instantaneous frame window from the Nix background daemon process
    spawnOn "2" "emacsclient -c -a ''"

myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent = xmobarColor "#0db9d7" ""
  , ppHidden = xmobarColor "#a9b1d6" ""
  , ppHiddenNoWindows = xmobarColor "#444b6a" ""
  }

myStatusBar = statusBarProp "xmobar" (pure myXmobarPP)

myKeys = 
  [ ("M-<Return>", spawn "alacritty")
  , ("M-e", spawn "emacsclient -c -a ''")
  , ("M-f", spawn "helium")
  , ("M-d", spawn "dmenu_run")
  , ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart")
  , ("M-q", kill)
  , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 5")
  , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5") 
  , ("<XF86AudioMute>", spawn "pamixer -t")
  , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +5%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
  ]

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ withEasySB myStatusBar defToggleStrutsKey $ myConfig

myConfig = def
  { modMask = mod4Mask
  , terminal = "alacritty"
  , borderWidth = 4
  , normalBorderColor = "#444b6a"
  , focusedBorderColor = "#ad8ee6"
  , layoutHook = myLayoutHook
  , workspaces = myWorkspaces
  , manageHook = myManageHook
  , startupHook = myStartupHook
  }
  `additionalKeysP` myKeys


