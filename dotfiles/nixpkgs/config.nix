{ pkgs }:
let
  # Inherit utilities
  inherit (pkgs) lib stdenv fetchurl buildEnv vim_configurable;

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
          "airline"
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
          "neomake"
          "nerdtree"
          "nerdcommenter"
          "quickfixstatus"
          "quickrun"
          "rainbow_parentheses"
          "tagbar"
          "taglist"
          "Syntastic"
          "Solarized"
          "vim-addon-nix"
          "vim-addon-syntax-checker"
          "vim-addon-vim2nix"
          "vim-buffergator"
          "vim-hardtime"
          "vim-nix"
          "vim-orgmode"
          "vim-pandoc"
          "vim-snippets"
          "vimproc"
          #"youcompleteme"
        ];
      }
    ];
  };

  haskell = pkgs.haskellPackages.ghcWithPackages (p: with p; [
    ghc-mod
    hoogle
    hlint
    pointfree
    cabal-install
    cabal2nix
    idris
  ]);

  mbbx6sppEnv = lib.lowPrio (buildEnv {
      name = "devenv-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
      bash
      bashCompletion
      bashInteractive
      fortune

      # superior editor :)
      vimMbbx6spp

      # languages/compilers/REPLs
      haskell
      jdk
      scala
      clang
      nix-repl
      nix-prefetch-scripts

      # command line utilities
      awscli
      ctags
      gitAndTools.gitFull
      gitAndTools.git-annex
      gitAndTools.git-extras
      gitAndTools.git2cl
      gitAndTools.tig
      gnupg21
      pwgen
      silver-searcher
      haskellPackages.ShellCheck
      keybase
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
      mtr
      pdsh

      # ncurses console "apps"
      calcurse
      canto-curses
      cherrytree
      ctodo
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
      typespeed # for my colemak learnings :)
      weechat
      ];
  });
in {
  allowUnfree = true;
  firefox.enableGoogleTalkPlugin = true;
  firefox.enableAdobeFlash = false;
  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
    enableWideVine = true;
  };

  jre = pkgs.oraclejre8;
  jdk = pkgs.oraclejdk8;

  packageOverrides = pkgs: rec {
    mbbx6sppDesktop = lib.lowPrio (buildEnv {
      name = "desktop-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
        conky
        dmenu
        dzen2
        pavucontrol
        chromium
        imagemagick
        firefox-wrapper
        xmonad-with-packages
        mbbx6sppEnv
        spotify
      ];
    });
    mbbx6sppEnv = buildEnv {
      name = "devenv-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
        bash
        bashCompletion
        bashInteractive
        fortune
        keybase
        mtr

        wget
        curl
        unzip
        zip

        # superior editor :)
        vimMbbx6spp

        # languages/compilers/REPLs
        haskell
        scala
        #clang
        jdk
        nix-repl
        nix-prefetch-scripts

        # command line utilities
        awscli
        ctags
        gitAndTools.gitFull
        gitAndTools.git-annex
        gitAndTools.git-extras
        gitAndTools.git2cl
        gitAndTools.tig
        gnupg21
        pwgen
        silver-searcher
        haskellPackages.ShellCheck
        keybase
        siege
        openssh
        bind
        tmux
        tree
        xsel
        rxvt_unicode-with-plugins
        urxvt_font_size
        urxvt_perl
        urxvt_perls
        urxvt_tabbedex
        mtr
        pdsh

        # ncurses console "apps"
        #cadaver
        calcurse
        canto-curses
        cherrytree
        ctodo
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
        #pianobar
        remind
        rlwrap
        sipcalc
        typespeed # for my colemak learnings :)
        weechat
      ];
    };
  };
}
