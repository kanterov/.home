Config {
    font = "xft:10x20:pixelsize=36",
    bgColor = "#ff1d8e",
    fgColor = "#ffffff",
    overrideRedirect = False,
    lowerOnStart = True,
    position = Bottom,
    border = FullBM 2,
    borderColor = "#111111",
    commands = [
        Run Weather "KCMI" ["-t","<tempC>C / <tempF>F <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","Cpu:<total>%","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 100,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 100,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 100,
        Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 50,
        Run Wireless "wlp2s0" ["-t","<essid>: <qualitybar>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 50,
        Run Battery ["-t", "AC: <acstatus> / Batt: <left>%"] 100,
        Run Date "%a %b %_d %H:%M %Z" "date" 50
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%multicpu%  |  %memory%  |  %swap%   [ %eth0% | %wlp2s0wi% ]   }{  %battery%  -  %KCMI%  |  <fc=#000099>%date%</fc>"
}
