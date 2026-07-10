return {
  {
    "nvim-mini/mini.indentscope",
    version = "*",
    opts = function()
      return {
        symbol = "│",
        options = { 
            try_as_border = true
        },
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
      }
    end,
  },
}
