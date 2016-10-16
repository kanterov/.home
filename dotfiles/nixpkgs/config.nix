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
          "haskell-vim"
          "haskellconceal"
          "hasksyn"
          "hoogle"
          "idris-vim"
          "latex-live-preview"
          "neco-ghc"
          "neocomplete"
          "neomake"
          "neosnippet"
          "nerdtree"
          "nerdcommenter"
          "purescript-vim"
          "quickfixstatus"
          "quickrun"
          "rainbow_parentheses"
          "tagbar"
          "taglist"
          "Syntastic"
          "Solarized"
          "Spacegray-vim"
          "stylish-haskell"
          "surround"
          "table-mode"
          "vim-addon-nix"
          "vim-addon-syntax-checker"
          "vim-addon-vim2nix"
          "vim-buffergator"
          "vim-hardtime"
          "vim-nix"
          "vim-orgmode"
          "vim-pandoc"
          "vim-signify"
          "vim-snippets"
          "vimproc"
          "vimshell"
          "youcompleteme"
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
    xmonad
    xmonad-contrib
    xmonad-utils
    xmonad-extras
  ]);

in {
  allowUnfree = true;
  firefox.enableGoogleTalkPlugin = true;
  firefox.enableAdobeFlash = false;

  jre = pkgs.oraclejre8;
  jdk = pkgs.oraclejdk8;

  packageOverrides = pkgs: rec {
    mbbx6sppDesktop = lib.lowPrio (buildEnv {
      name = "desktop-mbbx6spp";
      ignoreCollisions = true;
      paths = with pkgs; [
        arandr
        conky
        dmenu
        dzen2
        pavucontrol
        chromium
        imagemagick
        firefox-wrapper
        #xmonad-with-packages
        mbbx6sppEnv
        spotify
        evince
        slack
        purple-hangouts
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
        gnupg

        # superior editor :)
        vimMbbx6spp
        emacs25

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
        urxvt_theme_switch
        mtr
        pdsh
        xorg.xev
        xorg.xkbcomp
        xorg.xkbevd
        xorg.xkbprint
        xorg.xkbutils
        xorg.xmodmap

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
