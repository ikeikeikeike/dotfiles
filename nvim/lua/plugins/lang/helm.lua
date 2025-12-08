-- Helm template support (YAML + Go template syntax)

return {
  {
    "towolf/vim-helm",
    ft = "helm",
    init = function()
      -- Detect Helm template files
      vim.filetype.add({
        pattern = {
          [".*/templates/.*%.yaml"] = "helm",
          [".*/templates/.*%.yml"] = "helm",
          [".*/templates/.*%.tpl"] = "helm",
          [".*/helmfile.*%.yaml"] = "helm",
          [".*/helmfile.*%.yml"] = "helm",
        },
      })
    end,
  },
}
