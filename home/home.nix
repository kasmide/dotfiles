{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = lib.mkDefault "tomhi";
  home.homeDirectory = lib.mkDefault "/home/tomhi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.go
    pkgs.cargo
    #pkgs.git
    pkgs.prettyping
    pkgs.python3
    pkgs.nushell
    # pkgs.fish
    pkgs.neovim
    # pkgs.lm_sensors
    pkgs.unar

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.git = {
    enable = true;
    userEmail = lib.mkDefault "email@ksmd.dev";
    userName = lib.mkDefault "kasmide";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
    };
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-sleuth
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "match_prev_cmd" "completion" ];
    };
    shellAliases = {
      "nix-zsh" = "nix-shell --run zsh";
    };
    shellGlobalAliases = {
      ":g" = "|grep";
      ":l" = "|less";
    };
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    initContent = ''
      bindkey ";5D" backward-word
      bindkey ";5C" forward-word
      bindkey ";3D" backward-word
      bindkey ";3C" forward-word
      # ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
      PROMPT=' %(?.%F{cyan}.%F{red}! )%d%f''${vcs_info_msg_0_}
      %(65534#. $ .%(!.%K{red}%F{white}%B !! You are using the root shell !! # %b.%K{white}%F{black} %n@%m %k%f:))%k%f'
      RPROMPT="%(?..%F{red}%?%f)"
      SPROMPT="zsh: %F{red}%B%R%b%f not found. Run %F{green}%B%r%b%f instead? [y]es [n]o [a]bort [e]dit :"
      setopt prompt_subst
      setopt auto_remove_slash
      setopt auto_cd
      setopt correct
      setopt interactive_comments
      autoload -Uz vcs_info
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr "%F{green}+"
      zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}*"
      zstyle ':vcs_info:*' formats "%F{blue}:%b%c%u%f "
      zstyle ':vcs_info:*' actionformats ':%a (%b)'
      precmd () { vcs_info }
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' list-dirs-first
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:approximate:*' max-errors 3 numeric
      CORRECT_IGNORE="[_|\.]*"
      zstyle ':completion:*' use-cache true
      zstyle ':completion:*' menu select
    '';
  };

  services.ssh-agent.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tomhi/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
