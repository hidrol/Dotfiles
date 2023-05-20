{ config, pkgs,lib, ... }:

# let
#   fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
#     pname = "${lib.strings.sanitizeDerivationName repo}";
#     version = ref;
#     src = builtins.fetchGit {
#       url = "https://github.com/HiPhish/nvim-ts-rainbow2";
#       ref = ref;
#       rev = rev;
#     };
#   };
# in

# let
#
# fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
#     pname = "${lib.strings.sanitizeDerivationName repo}";
#     version = ref;
#     src = builtins.fetchGit {
#       url = "https://github.com/HiPhish/nvim-ts-rainbow2";
#       ref = ref;
#       rev = rev;
#     };
#   };
# in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  #home.username = builtins.getEnv "USER";
  #home.homeDirectory = builtins.getEnv "HOME";
  home.username = "hidrol";
  home.homeDirectory = "/home/hidrol";

	home.packages = with pkgs; [
	  # pkgs is the set of all packages in the default home.nix implementation
    tmux
    neofetch
    fzf # used for formarks
    # glfw
    #kitty
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-vi-mode
    chromium
    gnumake
    lldb
    direnv
    gnome.nautilus
    gdb
  ];
	
	home.file.".config/nvim/init.vim".source = ./init.vim;
  #home.file.".tmux.conf".source = ./tmux.conf;
  #home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
  home.file.".zshrc".source = ./zshrc;
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
  home.file.".config/kitty/current-theme.conf".source = ./current-theme.conf;
  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3status/config".source = ./i3statusconfig;
  #home.file.".config/joplin-desktop/settings.json".source = ./joplin.json;
  home.file.".tmux/post_save.sh".source = ./post_save.sh;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      # AGKOZAK_CMD_EXEC_TIME=5
      # AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
      # AGKOZAK_COLORS_PROMPT_CHAR='magenta'
      # AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
      # AGKOZAK_MULTILINE=0
      # AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
    #     source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    #     source ~/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
    '';
    #enableCompletion = true;
    #	ohMyZsh = {
    #	    enable = true;
    #};
    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ "git" ];
      #theme = "robbyrussell";
    # };
    # zplug = {
    #   enable = true;
    #   plugins = [
    #     { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
    #     { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    #   ];
    # };
    shellAliases = {
      # sl = "exa";
      # ls = "exa";
      # l = "exa -l";
      # la = "exa -la";
      ip = "ip --color=auto";
    };

    # oh-my-zsh = {
    #   enable = true;
    #
    #   plugins = [
        #"command-not-found"
        # "git"
        #"history"
        #"sudo"
    #   ];
    # };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          #sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
          #sha256 = "0000000000000000000000000000000000000000000000000000";
          #sha256 = lib.fakeSha256;
          sha256 = "sha256-hH4qrpSotxNB7zIT3u7qcog51yTQr5j5Lblq9ZsxuH4=";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "formarks";
        src = pkgs.fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "agkozak-zsh-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name ="zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          #sha256 = lib.fakeSha256;
          sha256 = "sha256-Ptxik1r6anlP7QTqsN1S2Tli5lyRibkgGlVlwWZRG3k=";
          #file = "zsh-history-substring-search.plugin.zsh";
        };
      }
      # {
      #   name = "zsh-vi-mode";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jeffreytse";
      #     repo = "zsh-vi-mode";
      #     rev = "0e666689b6b636fee6a80564fd6c4cb02b8b590d";
      #     sha256 = "sha256-lrnC+VyGLlq3oReF0MtHcQRanA8Av6fDyF8VUT8evrM=";
      #   };
      # }
    ];
  };

  programs.neovim = {
    enable = true;
    #defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox 
      tokyonight-nvim
      gruvbox-material
      vim-nix 
      nerdtree 
      fzf-vim
      vim-devicons
      nvim-treesitter.withAllGrammars
      #pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ])
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      indent-blankline-nvim
      tagbar
      nvim-ts-rainbow
      nvim-comment
#            nvim-gdb
#            vim-bufferline
      bufferline-nvim
      #telescope-nvim
      nvim-dap
      nvim-dap-ui
      #nvim-dap-projects
      vim-obsession
      lualine-nvim
      gitsigns-nvim
      friendly-snippets
      luasnip
      #rainbow
      #(fromGitHub "HEAD" "HiPhish/nvim-ts-rainbow2")
    ];
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
        tmuxPlugins.resurrect
        tmuxPlugins.continuum
        #plugin = tmuxPlugins.resurrect;
    ];
    extraConfig = ''
    source /home/hidrol/.config/nixpkgs/tmux.conf
    # for vim
    #set -g @resurrect-strategy-vim 'session'
    # for neovim
    #set -g @resurrect-processes '~nvim'
    #set -g @resurrect-strategy-nvim 'session'
    '';
  };

    # Git config using Home Manager modules
  programs.git = {
    enable = true;
    userName = "hidrol";
    userEmail = "stefan.grambach@googlemail.com";
    aliases = {
      st = "status";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
