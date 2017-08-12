Config {
    font = "xft:Monospace:pixelsize=12",
    allDesktops = True,
    pickBroadest = True,   -- choose widest display (multi-monitor) 
    commands = [
        Run MultiCpu       [ "--template" , "Cpu: <total0>% <total1>% <total2>% <total3>% <total4>% <total5>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 100,
        Run Memory ["-t","Mem: <usedratio>%"] 100,
        Run Date "%a %b %_d %H:%M" "date" 600,
        Run DynNetwork [] 50,
        Run MPD ["-t",
                  "<artist>: <title> (<album>) <state>", -- <remaining>
                            "--", "-P", ">>", "-Z", "|", "-S", "><"] 30,
        Run StdinReader],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader%  Playing: %mpd% }{ %multicpu% | %dynnetwork% | %memory% | <fc=#ee9a00>%date%</fc>"
}

