import XMonad

import qualified XMonad.StackSet as W

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

myModMask = mod4Mask

myTerminal = "urxvtc"

myFocusFollowsMouse = False

myClickJustFocuses = False

myStartupHook = do
  startupHook desktopConfig
  -- checkKeymap myConfig myKeys
  spawnOnce "compton --vsync-use-glfinish -b"
  spawnOnce "urxvtd -f -o -q"
  spawnOnce "~/.fehbg"
  spawnOnOnce "5" "spotify"
  spawnOnOnce "4" "slack"
  setWMName "LG3D"

rename :: String -> l a -> ModifiedLayout Rename l a
rename name = renamed [Replace name]

myLayout =
  tiled ||| (Mirror tiled) ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myKeys =
  [ ("<XF86AudioRaiseVolume>", spawn "amixer -q -D pulse set Master 2%+ unmute")
  , ("<XF86AudioLowerVolume>", spawn "amixer -q -D pulse set Master 2%- unmute")
  , ("<XF86AudioMute>", spawn "amixer -q -D pulse set Master toggle")
  , ("<XF86AudioStop>", spawn "playerctl stop")
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("<XF86AudioNext>", spawn "playerctl next")
  , ("<XF86AudioPrev>", spawn "playerctl previous")
  , ("M-p", spawn "rofi -modi drun,run,ssh -show drun")
  ]

myManageHook =
  composeAll
    [ (isFullscreen --> doFullFloat)
    , manageDocks
    , appName =? "google-chrome" --> doShift "2"
    , className =? "Xmessage" --> doCenterFloat
    , className =? "Slack" --> doShift "4"
    , className =? "Spotify" --> doShift "5"
    ]

myDynamicHook =
  dynamicPropertyChange "WM_NAME" $
  composeAll
    [ className =? "Spotify" --> doShift "5"
--    , className =? "google-chrome" --> doShift "2"
    ]

xmobarActiveColor = "#81a1c1"

myConfig xmproc0 xmproc1 =
  defaultConfig
    { modMask = myModMask
    , terminal = myTerminal
    , startupHook = myStartupHook <+> startupHook desktopConfig
    , handleEventHook =
        myDynamicHook <+> fullscreenEventHook <+> handleEventHook defaultConfig
    , logHook =
        dynamicLogWithPP
          xmobarPP
            { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x
            , ppCurrent = xmobarColor xmobarActiveColor "" . wrap "[*" "]"
            , ppVisible = xmobarColor xmobarActiveColor "" . wrap "[" "]"
            , ppHidden = xmobarColor xmobarActiveColor ""
            , ppHiddenNoWindows = xmobarColor "#d0d0d0" "" -- Hidden workspaces (no windows)
            , ppTitle = xmobarColor "#d0d0d0" "" . shorten 80 -- Title of active window in xmobar
            , ppLayout = id
            , ppSep = "<fc=#9AEDFE> </fc>" -- Separators in xmobar
            , ppUrgent = xmobarColor "#bf616a" "" . wrap "!" "!" -- Urgent workspace
            , ppOrder = \(ws:l:t:ex) -> [ws, l] ++ ex ++ [t]
            }
    , layoutHook = desktopLayoutModifiers $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ smartBorders myLayout
    , manageHook = myManageHook <+> manageHook desktopConfig
    , normalBorderColor = "#3b4252"
    , focusedBorderColor = "#81a1c1"
    , borderWidth = 2
    , focusFollowsMouse = myFocusFollowsMouse
    , clickJustFocuses = myClickJustFocuses
    } `additionalKeysP`
  myKeys

main = do
  spawn "pkill alsactl"
  xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc.hs"
  xmproc1 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/xmobarrc.hs"
  xmonad $ ewmh $ docks $ myConfig xmproc0 xmproc1
