return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        yaml = { "prettierd", "prettier" },
        graphql = { "prettierd", "prettier" },
        css = { "stylelint", "prettierd", "prettier" },
        htmlangular = { "eslint" },
        -- json = { "prettierd", "prettier" },
        lua = { "stylua", "prettierd" },
        markdown = { "prettierd", "prettier" },
        scss = { "stylelint", "prettierd", "prettier" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
      },
    },
  },
}
