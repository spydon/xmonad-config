import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

background = "feh --bg-fill ~/Pictures/`ls ~/Pictures | shuf -n 1`"

main = do
  --xmproc <- spawnPipe "~/.cabal/bin/xmobar2 ~/.xmonad/xmobar.hs"
  xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmonad/xmobar.hs"
  spawn background
  xmonad $ defaultConfig
    { terminal = "urxvt"
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = smartBorders . avoidStruts $ layoutHook defaultConfig
    , normalBorderColor = "#000000"
    , startupHook = setWMName "LG3D"
    , modMask = mod4Mask
    , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
    , logHook = dynamicLogWithPP xmobarPP
                              { ppOutput = hPutStrLn xmproc
                              , ppTitle = xmobarColor "green" "" . shorten 80
                              }
    }
      `additionalKeys`
           [ ((mod4Mask, xK_p), spawn "dmenu_run -fn 'Droid Sans Mono-12'")
           , ((mod4Mask, xK_b), spawn background)
           , ((mod4Mask, xK_c), spawn "urxvt -e tty-clock")
           , ((mod4Mask, xK_v), spawn "urxvt -e sudo wifi-menu")
           , ((mod4Mask, xK_n), spawn "nautilus")
           , ((mod4Mask, xK_f), spawn "firefox")
           , ((mod4Mask, xK_s), spawn "sh ~/scripts/screen.sh")
           , ((mod4Mask, xK_i), spawn "sh /home/spydon/bin/android-studio/bin/studio.sh")
           , ((mod4Mask, xK_o), spawn "sh /home/spydon/bin/idea-IU-172.3317.76/bin/idea.sh")
           , ((mod4Mask, xK_F5), spawn "mpc previous")
           , ((mod4Mask, xK_F6), spawn "mpc next")
           , ((mod4Mask, xK_F7), spawn "mpc toggle")
           , ((mod4Mask, xK_r), spawn "mpc clear | mpc listall | shuf -n 30 | mpc add; mpc play")
           , ((mod4Mask, xK_x), sendMessage ToggleStruts)
           , ((mod4Mask, xK_Up), spawn "xbacklight +10")
           , ((mod4Mask, xK_Down), spawn "xbacklight -10") ]
