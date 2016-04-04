{ pkgs }:
let
  # Inherit utilities
  inherit (pkgs) lib buildEnv vim_configurable;

  homeDir = builtins.getEnv "HOME";
  vimrcFile = "${homeDir}/.vim/global/global.vim";

  vimMbbx6spp = vim_configurable.customize {
    name = "vim-mbbx6spp";
    vimrcConfig.customRC = builtins.readFile vimrcFile + ''
    let $PATH = $PATH . ':' . '${pkgs.haskellPackages.ghc-mod}/bin'
    '';
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
      { names = [
          #"airline"
          "align"
          "calendar"
          "colors-solarized"
          "ctrlp"
          "fugitive"
          "ghcmod"
          "gitgutter"
          "Gist"
          "haskellconceal"
          "hasksyn"
          "hoogle"
          "idris-vim"
          "latex-live-preview"
          "neco-ghc"
          "neocomplete"
          "nerdtree"
          "nerdcommenter"
          "quickfixstatus"
          "quickrun"
          "rainbow_parentheses"
          "tagbar"
          "taglist"
          "Syntastic"
          "vim-addon-nix"
          "vim-addon-syntax-checker"
          "vim-addon-vim2nix"
          "vim-hardtime"
          "vim-snippets"
          "vimproc"
          "youcompleteme"
        ];
      }
    ];
  };

in {
  allowUnfree = true;
  #firefox.enableGeckoMediaPlayer = true;
  firefox.enableGoogleTalkPlugin = true;
  #firefox.enableAdobeFlash = true;

  jre = pkgs.oraclejre8;
  jdk = pkgs.oraclejdk8;

  packageOverrides = pkgs: {
    mbbx6sppDesktop = lib.lowPrio (buildEnv {
      name = "desktop-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
        conky
        dmenu
        dzen2
        pavucontrol
        chromium
        firefox-wrapper
        spotify
        xmonad-with-packages
      ];
    });
    mbbx6sppEnv = lib.lowPrio (buildEnv {
      name = "devenv-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
        bash
	bashCompletion
	bashInteractive

        # superior editor :)
        vimMbbx6spp

        # languages/compilers/REPLs
        haskellPackages.idris
        haskellPackages.ghc
        haskellPackages.ghc-mod
        haskellPackages.hoogle
        haskellPackages.hlint
        haskellPackages.pointfree
        scala
        clang
        nix-repl
        nix-prefetch-scripts

        # command line utilities
        ctags
        gitAndTools.gitFull
        gitAndTools.git-annex
        gitAndTools.git-extras
        gitAndTools.git2cl
        gitAndTools.tig
        gnupg
        pwgen
        qemu
        silver-searcher
        haskellPackages.ShellCheck
        siege
        openssh
        tmux
        tree
        xsel
        rxvt_unicode-with-plugins
        urxvt_font_size
        urxvt_perl
        urxvt_perls
        urxvt_tabbedex

        # ncurses console "apps"
        cadaver
        calcurse
        canto-curses
        cherrytree
        ctodo
        davfs2
        findbugs
        gitinspector
        hexcurse
        khal
        mailnag
        mairix
        mediainfo
        moc
        mp3gain
        mpg123
        mutt
        newsbeuter
        pianobar
        remind
        rlwrap
        sipcalc
        sup
        typespeed # for my colemak learnings :)
        weechat
      ];
    });
  };
}
