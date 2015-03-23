Config {
    font = "xft:Monospace-14",
    bgColor = "#000000",
    fgColor = "#ffffff",
    lowerOnStart = True,
    position = Top,
    commands = [
        Run Weather "KCMI" ["-t","<tempC>C / <tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","Cpu: <total>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 50,
        Run Wireless "wlp2s0" ["-t","<essid>: <qualitybar>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Battery ["-t", "AC: <acstatus> Battery: <leftbar>"] 100,
        --Run Uptime ["-t", "Up: <days>d <hours>h <minutes>m"] 600,
        Run Date "%a %b %_d %H:%M %Z" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%multicpu%  |  %memory%  |  %swap%   [ %eth0% | %wlp2s0wi% ]  <fc=#FFFFCC>%date%</fc>  |  %battery%  -  %KCMI%"
}
