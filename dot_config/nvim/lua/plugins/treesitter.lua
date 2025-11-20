return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "rust", "java", "qmljs", "go", "hyprlang", "javadoc", "css", "dockerfile"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
  }
}
