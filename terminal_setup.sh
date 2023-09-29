#!/bin/bash

# ------------------- Terminal Intial Install ------------------- #

# Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Cloning Zsh plugins
echo "Cloning Zsh plugins..."
plugins_directory=~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $plugins_directory/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugins_directory/zsh-syntax-highlighting

# Editing ~/.zshrc to include the plugins
echo "Editing ~/.zshrc to include the plugins..."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Activating the changes
echo "Activating the changes..."
source ~/.zshrc


#Font installs
# Define the URLs of the fonts
font_urls=(
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
  "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

# Define the font directory
font_dir=~/.fonts

# Create the font directory if it doesn't exist
mkdir -p "$font_dir"

# Download each font directly into the font directory
for url in "${font_urls[@]}"; do
  wget -P "$font_dir" "$url"
done

# Update the font cache
fc-cache -fv

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Define the path to the zshrc file
zshrc_file=~/.zshrc

# Define the current theme line and the line to replace it with
current_line='ZSH_THEME="robbyrussell"'
replacement_line='ZSH_THEME="powerlevel10k/powerlevel10k"'

# Check if the current theme line is in the zshrc file
if grep -Fxq "$current_line" "$zshrc_file"
then
    # Use sed to replace the current theme line with the replacement line
    sed -i.bak "s|$current_line|$replacement_line|" "$zshrc_file"
    echo "ZSH_THEME has been set to powerlevel10k/powerlevel10k in $zshrc_file"
else
    echo "The line $current_line was not found in $zshrc_file"
fi

# TODO: TMUX plugins/configurations
echo "Terminal setup completed."
