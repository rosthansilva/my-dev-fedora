#!/bin/bash
set -e

# ---- 1. Atualização do sistema ----
echo "🌀 Atualizando sistema..."
sudo dnf update -y

# Criar diretório temporário
mkdir -p ~/Temp
cd ~/Temp

# ---- 2. Pacotes essenciais ----
echo "📦 Instalando pacotes básicos..."
sudo dnf install -y \
  git \
  curl \
  wget \
  unzip \
  tar \
  gnome-tweaks \
  gnome-extensions-app \
  flameshot \
  kdenlive \
  gcc \
  make \
  python3-pip \
  ffmpeg \
  vlc \
  htop || true  # ignora pacotes já instalados

# Instalar neofetch via COPR
sudo dnf install -y dnf-plugins-core
sudo dnf copr enable konimex/neofetch -y
sudo dnf install -y neofetch

# ---- 3. Heroic Games Launcher ----
echo "🎮 Instalando Heroic Games Launcher..."
sudo dnf install -y heroic-games-launcher-bin

# ---- 4. VirtualBox ----
echo "📦 Instalando VirtualBox..."
sudo dnf install -y VirtualBox

# ---- 5. Spicetify + Nord Theme (para Spotify) ----
echo "🎵 Instalando Spicetify com Nord Theme..."
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
~/.spicetify/spicetify backup apply enable-devtool
git clone https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
cp -r * ~/.config/spicetify/Themes
cd ~/.config/spicetify/Themes/Nord
spicetify config current_theme Nord color_scheme nord
spicetify apply
cd ~/Temp

# ---- 6. Tema GTK Adapta Nord ----
echo "🎨 Instalando tema Adapta Nord..."
git clone https://github.com/Adapta-Projects/Adapta-Nord.git
cd Adapta-Nord
chmod +x Install.sh
./Install.sh
cd ~/Temp

# ---- 7. Tela Circle Icons ----
echo "🎨 Instalando Tela Circle Nord Icons..."
git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
./install.sh -a
cd ~/Temp

# ---- 8. Firefox Nordic Theme ----
echo "🌐 Instalando tema Nord no Firefox..."
git clone https://github.com/EliverLara/firefox-nordic-theme.git
cd firefox-nordic-theme
./scripts/install.sh -g
cd ~/Temp

# ---- 9. Nord GNOME Terminal ----
echo "🖥️ Aplicando Nord no GNOME Terminal..."
git clone https://github.com/nordtheme/gnome-terminal.git
cd gnome-terminal/src
./nord.sh
cd ~/Temp

# ---- 10. Pyenv ----
echo "🐍 Instalando pyenv..."
curl https://pyenv.run | bash

# Configurar no bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# ---- 11. Starship Prompt ----
echo "⭐ Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y
mkdir -p ~/.config
wget -O ~/.config/starship.toml https://raw.githubusercontent.com/joshuai96/starship-powerline-nord/main/starship.toml

# Configurar no bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# ---- 12. Nerd Fonts (todas 3.4.0) ----
echo "🔤 Instalando TODAS as Nerd Fonts v3.4.0..."
mkdir -p ~/.local/share/fonts
cd ~/Temp

if [ ! -f "NerdFonts.tar.xz" ]; then
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFonts.tar.xz -O NerdFonts.tar.xz
fi

echo "📦 Extraindo todas as fontes (~4GB, pode demorar)..."
tar -xf NerdFonts.tar.xz -C ~/.local/share/fonts/
fc-cache -fv
cd ~/Temp

# # ---- 13. GNOME Keybinding para Flameshot ----
# echo "📸 Configurando atalho para Flameshot (Ctrl+Shift+X)..."
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Flameshot'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'flameshot gui'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Shift>X'

# ---- 14. Finalização ----
echo "✅ Instalação concluída!"
echo "🔄 Reinicie a sessão (logout/login) para aplicar todas as mudanças."
