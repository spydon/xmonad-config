Config {
    font = "xft:Monospace:pixelsize=12",
    allDesktops = True,
    commands = [
        Run MultiCpu       [ "--template" , "Cpu: <total0>% <total1>% <total2>% <total3>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 100,
        Run Memory ["-t","Mem: <usedratio>%"] 100,
        Run Date "%a %b %_d %H:%M" "date" 600,
        Run DynNetwork [] 100,
        Run MPD ["-t",
                  "<artist>: <title> (<album>) <state>", -- <remaining>
                            "--", "-P", ">>", "-Z", "|", "-S", "><"] 30,
        Run StdinReader,
        Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                           ] 100
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader%  Playing: %mpd% }{ %multicpu% | %dynnetwork% | %memory% | %battery% | <fc=#ee9a00>%date%</fc>"
}
