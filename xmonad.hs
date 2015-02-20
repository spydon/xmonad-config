import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig 
    { terminal = "gnome-terminal"
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
                              { ppOutput = hPutStrLn xmproc
                              , ppTitle = xmobarColor "green" "" . shorten 50
                              }
    }
      `additionalKeys`
           [ ((mod1Mask, xK_p), spawn "dmenu_run -fn 'Droid Sans Mono-10'")
           , ((mod1Mask, xK_n), spawn "mpc next")
           , ((mod1Mask, xK_r), spawn "mpc clear | mpc listall | shuf -n 10 | mpc add; mpc play")
           , ((mod1Mask, xK_Right), spawn "pulseaudio-ctl up")
           , ((mod1Mask, xK_Left), spawn "pulseaudio-ctl down")
           , ((mod1Mask, xK_Up), spawn "xbacklight +10")
           , ((mod1Mask, xK_Down), spawn "xbacklight -10") ]
