return {
  -- PlantUML syntax highlighting and preview
  {
    'aklt/plantuml-syntax',
    ft = { 'plantuml', 'puml' },
  },

  -- PlantUML previewer
  {
    'weirongxu/plantuml-previewer.vim',
    dependencies = {
      'tyru/open-browser.vim',
      'aklt/plantuml-syntax',
    },
    ft = { 'plantuml', 'puml' },
    config = function()
      -- PlantUML jar is already installed via Homebrew
      vim.g.plantuml_executable_script = 'plantuml'
      
      -- Set output format to SVG for better quality
      vim.g.plantuml_previewer_output_format = 'svg'
      
      -- Auto-update preview on save
      vim.g.plantuml_previewer_save_format = 'svg'
      
      -- Key mappings for PlantUML files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'plantuml', 'puml' },
        callback = function()
          -- Preview in browser
          vim.keymap.set('n', '<leader>p', '<Plug>(plantuml-previewer-open)', { buffer = true, desc = 'Preview PlantUML' })
          
          -- Start auto-preview (updates on save)
          vim.keymap.set('n', '<leader>ps', '<Plug>(plantuml-previewer-start)', { buffer = true, desc = 'Start PlantUML auto-preview' })
          
          -- Stop auto-preview
          vim.keymap.set('n', '<leader>px', '<Plug>(plantuml-previewer-stop)', { buffer = true, desc = 'Stop PlantUML auto-preview' })
        end,
      })
    end,
  },
}
