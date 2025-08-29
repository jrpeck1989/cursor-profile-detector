on alfred_script(q)

	set finderSelection to ""
	set theTargets to {}
	set defaultTarget to (path to home folder as alias)

	set homePOSIX to POSIX path of (path to home folder)
	set smartCLI to homePOSIX & "bin/cursor-smart"

	on runCursorSmart(posixPath)
		do shell script smartCLI & " " & quoted form of posixPath & " >/dev/null 2>&1 &"
	end runCursorSmart

	if (q as string) is "" then
		tell application "Finder"
			set finderSelection to (get selection)
			if (count of finderSelection) is greater than 0 then
				repeat with anItem in finderSelection
					set posixPath to POSIX path of (anItem as alias)
					my runCursorSmart(posixPath)
				end repeat
			else
				try
					set theTarget to (folder of the front window as alias)
				on error
					set theTarget to defaultTarget
				end try
				set posixPath to POSIX path of theTarget
				my runCursorSmart(posixPath)
			end if
		end tell
	else
		try
			set oldDelimiters to text item delimiters
			set text item delimiters to tab
			set qArray to every text item of q
			set text item delimiters to oldDelimiters

			repeat with atarget in qArray
				set atarget to (atarget as string)

				if atarget starts with "~" then
					set userHome to POSIX path of (path to home folder)
					if userHome ends with "/" then
						set userHome to characters 1 thru -2 of userHome as string
					end if
					try
						set atarget to userHome & characters 2 thru -1 of atarget as string
					on error
						set atarget to userHome
					end try
				end if

				set targetAlias to ((POSIX file atarget) as alias)
				set posixPath to POSIX path of targetAlias
				my runCursorSmart(posixPath)
			end repeat
		on error
			return (atarget as string) & " is not a valid file or folder path."
		end try
	end if

end alfred_script


