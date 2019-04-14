Config
  { font = "xft:NotoSansDisplay Nerd Font:size=14,IPAmjMincho:size=14,Symbola:size=14,DejaVu Sans Mono:size=14"
  , bgColor = "#2e3440"
  , fgColor = "#d0d0d0"
  , position = Top
  , persistent = True
  , commands =
      [ Run Date "<fc=#91a1c1></fc> %a %b %_d %Y %H:%M" "date" 100
      , Run Cpu ["-t", "<fc=#91a1c1></fc> <total>%", "-H", "50", "--high", "#bf616a", "-x", ""] 50
      , Run Memory ["-t","<fc=#91a1c1></fc> <usedratio>%"] 50
      , Run DiskU [("/","<fc=#91a1c1></fc> <usedp>%")] [] 600
      , Run Alsa "pulse" "Master" ["-t", "<fc=#91a1c1></fc> <volume>%"]
      , Run Mpris2 "spotify" ["-t", "<fc=#91a1c1></fc> <artist> - <title>", "-x", ""] 50
      , Run StdinReader
      ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "<fc=#91a1c1></fc> %StdinReader% }{ %mpris2% %disku% %alsa:pulse:Master% %cpu% %memory% %date% "
  }

