hl.config({
    input = {
        kb_layout    = "lafayette_linux_v0.9.xkb_custom",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "ctrl:swap_lalt_lctl,caps:swapescape",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "custom 1.0 0.0 0.8", -- adjust based on scaling, here scaling is 1.25.

        touchpad     = {
            natural_scroll = true,
        },
    },
})
