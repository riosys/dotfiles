-- plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        -- Default configuration for Telescope
        prompt_prefix = " ", -- Icon to show in prompt
        selection_caret = " ", -- Icon to show before the selected item
        entry_prefix = "  ", -- Prefix for each entry
        multi_icon = " ", -- Icon to indicate multiple selections
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
        },
        file_ignore_patterns = {"node_modules", "%.git/"}, -- Ignore patterns
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
          },
        },
      },
      pickers = {
        -- Default configuration for pickers
        find_files = {
          theme = "dropdown",
          hidden = true,
        },
        live_grep = {
          theme = "dropdown",
          additional_args = function(opts)
            return {"--hidden"}
          end,
        },
        buffers = {
          theme = "dropdown",
          sort_lastused = true,
        },
        help_tags = {
          theme = "dropdown",
        },
      },
      extensions = {
        -- Extensions configuration here (if needed)
      },
    })

    -- Load any additional Telescope extensions here (if you have any)
    -- Example: telescope.load_extension('fzf')
  end,
}

