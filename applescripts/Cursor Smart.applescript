#!/usr/bin/osascript
on run argv
  set targetPath to (POSIX path of (do shell script "pwd"))
  if (count of argv) is greater than 0 then
    set targetPath to item 1 of argv
  end if
  set homePOSIX to POSIX path of (path to home folder)
  set smartCLI to homePOSIX & "bin/cursor-smart"
  do shell script "/bin/zsh -lc " & quoted form of (smartCLI & " " & quoted form of targetPath & " >/dev/null 2>&1 &")
end run


