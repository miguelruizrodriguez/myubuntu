zsh() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e
 
  # oh-my-zsh
  printf "${BLUE}Installing Oh-my-zsh...${NORMAL}\n"
  # echo -n "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed -e "s/env zsh//" > /tmp/install-zsh.sh
  echo -n "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed -e "s/env zsh//" > /tmp/install-zsh.sh
  chmod 700 /tmp/install-zsh.sh
  bash -c /tmp/install-zsh.sh
  sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/" ~/.zshrc  

  # Choice my plugins
  sed -i "s/plugins=([^)]*)/plugins=(git golang docker aws rake)/" ~/.zshrc
}

# Check if reboot is needed
zsh
