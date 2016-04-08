augroup filetypedetect
  au! BufRead,BufNewFile  *.elm       setfiletype elm
  au BufWritePost         *.elm       ElmMakeCurrentFile
augroup END
