local mainMod = "SUPER"

hl.unbind(mainMod .. " + G")
hl.bind(mainMod .. " + G", function()
    hl.dispatch(hl.dsp.focus({ workspace = "name:gaming" }))
    hl.dispatch(hl.dsp.submap("gaming"))
end)

hl.unbind(mainMod .. " + SHIFT + G")
hl.bind(mainMod .. " + SHIFT + G", function()
    hl.dispatch(hl.dsp.window.move({ workspace = "name:gaming", follow = true }))
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "set" }))
    hl.dispatch(hl.dsp.submap("gaming"))
end)

hl.define_submap("gaming", function()
    hl.bind(mainMod .. " + escape", hl.dsp.submap("reset"))
end)
