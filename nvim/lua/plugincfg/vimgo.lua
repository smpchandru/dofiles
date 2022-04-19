--let g:go_guru_scope = ["github.com/...","golangorg/...","mypractice","..."]
vim.g.go_list_type = "quickfix"
--":au FileType go map <localleader>r <Plug>(go-run)
--":au FileType go map <localleader>b <Plug>(go-build)
--":au FileType go map <localleader>i <Plug>(go-imports)
--":au FileType go map <localleader>d <Plug>(go-describe)
--":au FileType go map <localleader>dv <Plug>(go-def-vertical)
--":au FileType go map <localleader>dh <Plug>(go-def-split)
vim.g.syntastic_go_checkers = {'golint', 'govet', 'errcheck'}
vim.g.go_auto_type_info = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_metalinter_autosave = 0
--vim.g.go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
--vim.g.go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'ineffassign', 'deadcode','gosimple', 'staticcheck']
vim.g.go_metalinter_autosave = 0
vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_list_type = 'quickfix'
vim.g.go_doc_keywordprg_enabled = 0

--, 'varcheck']
--vim.g.go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'ineffassign', 'deadcode','gosimple', 'staticcheck']
vim.g.go_metalinter_enabled = {'vet', 'golint', 'errcheck' }
vim.g.go_metalinter_deadline = '10s'
--vim.g.go_metalinter_command = "--exclude=test"
vim.g.go_highlight_functions = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_types = 1
vim.g.go_term_enabled = 1
vim.g.go_term_mode = "split"
vim.g.go_term_height = 13
vim.g.go_highlight_build_constraints = 1
--vim.g.go_fmt_fail_silently = 1
vim.g.go_highlight_function_calls=1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_variable_assignments=1
vim.g.go_highlight_variable_declarations=1
--vim.g.go_highlight_function_parameters=1
--vim.g.go_def_mode='gopls'
--vim.g.go_def_mapping_enabled = 0
--vim.g.go_rename_command ='gopls'
--vim.g.go_info_mode='gopls'
-- vim.g.go_gopls_enabled = 0
--vim.g.go_gopls_options =['']
vim.g.go_decls_mode = 'fzf'
