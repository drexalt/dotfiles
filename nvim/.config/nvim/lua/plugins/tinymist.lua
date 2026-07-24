return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  cmd = {
    "TypstPreview",
    "TypstPreviewStop",
    "TypstPreviewToggle",
    "TypstPreviewUpdate",
  },
  version = "1.*",
  opts = {
    dependencies_bin = {
      tinymist = vim.fn.stdpath("data") .. "/mason/bin/tinymist",
      websocat = vim.fn.stdpath("data") .. "/typst-preview/websocat.aarch64-apple-darwin",
    },
  },
}
