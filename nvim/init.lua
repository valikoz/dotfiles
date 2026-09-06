vim.opt.showbreak = '↪ '
vim.opt.list = true
vim.o.lcs = 'tab:│→,trail:·'

vim.keymap.set('n', '<space>e', '<Cmd>exe (&ft == \'directory\' ? \'sil! e #\' : \'e %:p:h\')<CR>')
