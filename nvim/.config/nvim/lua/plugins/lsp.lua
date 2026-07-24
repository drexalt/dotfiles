return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- disable basedpyright
        basedpyright = false,

        -- enable ty
        ty = {
          settings = {
            ty = {
              -- ty language server settings here
            },
          },
        },
      },
    },
  },
}
