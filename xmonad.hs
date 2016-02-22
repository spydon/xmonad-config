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
import XMonad.Util.EZConfig

background = "feh --bg-fill ~/pictures/`ls ~/pictures | shuf -n 1`"
myWorkspaces =    ["1:Browser", "2:Slack", "3:LaTeX", "4:IntelliJ"] 
               ++ ["5:Webstorm", "6:IRC", "7:Notes",  "8", "9",  "0"]

main = do
  --xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  spawn background

  xmonad $ defaultConfig
    { terminal = "urxvt"
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    --, focusedBorderColor = "#000000"
    , workspaces        = myWorkspaces
    , normalBorderColor = "#006400"
    , startupHook       = setWMName "LG3D"
    , modMask           = mod4Mask
    , logHook           = dynamicLogWithPP xmobarPP
                              { ppOutput = hPutStrLn xmproc
                              , ppTitle = xmobarColor "green" "" . shorten 80
                              }
    }
      `additionalKeys`
           [ ((mod4Mask, xK_p), spawn "dmenu_run -fn 'Droid Sans Mono-10'")
           , ((mod4Mask, xK_b), spawn background)
           , ((mod4Mask, xK_c), spawn "urxvt -e sh ~/scripts/latex.sh")
           , ((mod4Mask, xK_t), spawn "sh ~/scripts/pomodoro.sh")
           , ((mod4Mask, xK_x), spawn "urxvt -e ncmpcpp")
           , ((mod4Mask, xK_i), spawn "~/bin/idea-IU-143.1184.17/bin/idea.sh")
           , ((mod4Mask, xK_w), spawn "~/bin/WebStorm-143.381.46/bin/webstorm.sh")
           , ((mod4Mask, xK_m), spawn "/home/spydon/bin/toolbox/toolbox")
           , ((mod4Mask, xK_k), spawn "~/scripts/layout_switch.sh")
           , ((mod4Mask, xK_s), spawn "plaidchat")
           , ((mod4Mask, xK_f), spawn "firefox")
           , ((mod4Mask, xK_F1), spawn "urxvt -e tty-clock")
           , ((mod4Mask, xK_F5), spawn "mpc previous")
           , ((mod4Mask, xK_F6), spawn "mpc next")
           , ((mod4Mask, xK_F7), spawn "mpc toggle")
           , ((mod4Mask, xK_r), spawn "mpc clear | mpc listall | shuf -n 30 | mpc add; mpc play")
           , ((mod4Mask, xK_Right), spawn "pulseaudio-ctl up")
           , ((mod4Mask, xK_Left), spawn "pulseaudio-ctl down") ]
