augroup filetypedetect
  au! BufRead,BufNewFile *.elm        setfiletype haskell
  au! BufRead,BufNewFile *.lucius     setfiletype css
  au! BufRead,BufNewFile *.hamlet     setfiletype haml
augroup END
