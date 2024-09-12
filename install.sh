#!/bin/sh -e

DOTDIR="$HOME/dot-jeeva"
DWMDIR="$DOTDIR/my-dwm"

gitclone() {
  echo "Cloning dot files into $DOTDIR"
  if [ -d "$DOTDIR" ]; then
    read -p "Found existing $DOTDIR, Remove $DOTDIR [Y/N] [DEFAULT Y]: " confirm
    confirm=${confirm:-Y}
    if [ "$confirm" = "Y" ] || [ "$confirm" = "y" ]; then
      echo "Removing $DOTDIR"
      rm -rf "$DOTDIR"
    else
      exit 1
    fi
  else
    mkdir -p "$DOTDIR"
  fi
  git clone https://github.com/jeevithakannan2/my-dwm.git --depth 1 "$DWMDIR"
  git clone https://github.com/yshui/picom.git --depth 1 "$DOTDIR/picom"
}

copy_configs() {
  # Ensure the .config directory exists
  mkdir -p ~/.config

  # Iterate over all directories in my-dwm/config/*
  for dir in "$DWMDIR/configs/"*/; do
    # Extract the directory name
    dir_name=$(basename "$dir")

    # Clone the directory to ~/.config/
    if [ -d "$dir" ]; then
      cp -r "$dir" ~/.config/
      echo "Cloned $dir_name to ~/.config/"
    else
      echo "Directory $dir_name does not exist, skipping"
    fi
  done
}

install_dep() {
  sudo pacman -Sy base-devel xorg-server libxinerama libxft imlib2 \
    cmake libev xcb-util-image libconfig uthash xorg-xinit meson \
    xcb-util-renderutil unzip feh alacritty rofi --needed --noconfirm
}

xinitrc() {
  if [ -f "$HOME/.xinitrc" ]; then
    mv "$HOME/.xinitrc" "$HOME/.xinitrc.bak"
  fi

  cat <<EOF >"$HOME/.xinitrc"
export XDG_SESSION_TYPE=x11

exec dwm
EOF
}

install() {
  cd "$DWMDIR" || exit
  sudo make clean install

  cd "$DWMDIR/slstatus" || exit
  sudo make clean install

  cd "$DOTDIR/picom" || exit
  meson setup --buildtype=release build
  ninja -C build
  sudo ninja -C build install
}

install_fonts() {
  mkdir -p "$HOME/.local/share/fonts"
  cd "$DWMDIR/fonts"
  for font in "$DWMDIR/fonts/"*; do
    folder="${font%.zip}" # Remove the .zip extension to create the folder name
    rm -rf "$HOME/.local/share/fonts/$folder"
    mkdir -p "$HOME/.local/share/fonts/$folder"
    unzip "$font" -d "$HOME/.local/share/fonts/$folder"
  done
}

main() {
  if command -v pacman &>/dev/null; then
    echo "Arch System detected"
    sudo pacman -Syu --noconfirm

    if command -v git &>/dev/null; then
      echo "Git found in system"
      gitclone
    else
      echo "Git not found in system, installing git"
      sudo pacman -S git --noconfirm
      gitclone
    fi

    echo "Installing dependencies for dwm and slstatus"
    install_dep

    echo "Setting up .xinitrc"
    xinitrc

    echo "Compiling and installing dwm and slstatus"
    install

    echo "Install fonts"
    install_fonts

    echo "Copying configs"
    copy_configs

  else
    echo "Arch system not found"
    exit 1
  fi
}

main
