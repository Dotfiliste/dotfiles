local mainMod = "SUPER"

hl.unbind(mainMod .. " + CTRL + RETURN")
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/launcher.sh"), { description = "Open application launcher" })
