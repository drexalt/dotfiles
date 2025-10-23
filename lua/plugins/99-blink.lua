return {
  {
    "saghen/blink.cmp",
    -- ensure we override any earlier plugin spec opts in LazyVim
    priority = 1000,
    event = "VeryLazy",
    opts = function(_, opts)
      ------------------------------------------------------------------
      -- Smart TeX context: on after '\' or inside {...}, off in prose
      ------------------------------------------------------------------
      local function tex_context_enabled()
        local ft = vim.bo.filetype
        if ft ~= "tex" and ft ~= "latex" then
          return true
        end
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local line = vim.api.nvim_get_current_line()
        local before = line:sub(1, col)
        if before:match("%%[^%%]*$") then
          return false
        end -- in comment
        if before:match("\\%a*$") then
          return true
        end -- \alph|
        if before:match("\\%a+{%w*$") then
          return true
        end -- \begin{ali|
        return false
      end

      ------------------------------------------------------------------
      -- Global enabled: always true in TeX for keymap application
      ------------------------------------------------------------------
      local prev_enabled = opts.enabled
      opts.enabled = function()
        local ft = vim.bo.filetype
        if ft ~= "tex" and ft ~= "latex" then
          if type(prev_enabled) == "function" then
            return prev_enabled()
          else
            return prev_enabled ~= false
          end
        end
        return true -- Always enable in TeX to set keymaps on InsertEnter
      end

      ------------------------------------------------------------------
      -- Sources: dynamic enable per context to avoid lag in prose
      ------------------------------------------------------------------
      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}
      -- Apply to built-in sources; adjust list if you have custom ones
      local sources_to_control = { "lsp", "buffer", "path", "snippets" } -- Add any others like 'luasnip' if used
      for _, source_id in ipairs(sources_to_control) do
        opts.sources.providers[source_id] = opts.sources.providers[source_id] or {}
        opts.sources.providers[source_id].enabled = tex_context_enabled
      end

      ------------------------------------------------------------------
      -- Keymaps: deterministic, no preset surprises
      ------------------------------------------------------------------
      opts.keymap = opts.keymap or {}
      opts.keymap.preset = "none"

      -- Accept with Enter when a completion is active; else newline
      opts.keymap["<CR>"] = { "accept", "fallback" }

      -- Cycle suggestions with Tab / Shift-Tab; jump snippets if applicable
      opts.keymap["<Tab>"] = { "select_next", "snippet_forward", "fallback" }
      opts.keymap["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" }

      -- Extra reliable cycling
      opts.keymap["<C-n>"] = { "select_next", "fallback" }
      opts.keymap["<C-p>"] = { "select_prev", "fallback" }

      return opts
    end,
  },
}
