vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname then
      print("Hello, my name is", bufname)
    end
  end
})
