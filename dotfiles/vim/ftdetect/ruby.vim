augroup filetypedetect
  au! BufRead,BufNewFile Gemfile      setfiletype ruby
  au! BufRead,BufNewFile Procfile     setfiletype ruby
  au! BufRead,BufNewFile Vagrantfile  setfiletype ruby
  au! BufRead,BufNewFile Rakefile     setfiletype ruby
  au! BufRead,BufNewFile Thorfile     setfiletype ruby
  au! BufRead,BufNewFile Appraisals   setfiletype ruby
  au! BufRead,BufNewFile *.god        setfiletype ruby
  au! BufRead,BufNewFile config.ru    setfiletype ruby
augroup END
