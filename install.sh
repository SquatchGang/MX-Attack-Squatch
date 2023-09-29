#!/bin/bash

# -----------------------------------------------------------------------------
# MX Linux Penetration Testing Setup Script
# This script automates the setup of essential tools and configurations for
# penetration testing, red teaming, and CTF activities on MX Linux.
# -----------------------------------------------------------------------------

# Update the package list and upgrade existing packages
echo "Updating package list and upgrading existing packages..."
sudo apt update
sudo apt full-upgrade -y

# ------------------- Kali Repository Install ------------------- #

# Update the package list to ensure it's current
sudo apt update

# Add Kali Linux repository to sources.list.d
echo "Adding Kali Linux repository..."
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"

# Update the package list again to include the new repository
echo "Updating package list..."
sudo apt update

# Install gnupg package required for key addition
echo "Installing gnupg package..."
sudo apt install -y gnupg

# Download Kali Linux archive key
echo "Downloading Kali Linux archive key..."
wget 'https://archive.kali.org/archive-key.asc'

# Add the Kali Linux archive key to the system
echo "Adding Kali Linux archive key..."
sudo apt-key add archive-key.asc

# Update the package list once more to include Kali Linux packages
echo "Updating package list with Kali Linux packages..."
sudo apt update

# Set package preferences to avoid conflicts
echo "Setting package preferences for Kali Linux..."
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref"

# Update the package list a final time
echo "Final update of the package list..."
sudo apt update

echo "Kali Linux repository and packages are configured."

# ------------------- Tool Installs ------------------- #

# Define a list of tools to install from default repositories
default_tools=(
    glibc-source
    git
    smbclient
    netcat-traditional
    nmap
    python3-pip
    python3-dev
    python3-setuptools
    guake
    tmux
    zsh
    open-vm-tools-desktop
    open-vm-tools
)

# Install tools from default repositories
for tool in "${default_tools[@]}"; do
    sudo apt install -y "$tool"
done

echo "Tools installed from default repositories."

# Define a list of Kali tools to install
kali_tools=(
    nmap-common
    john
    python3-impacket
    impacket-scripts
    wordlists
    seclists
    dirsearch
    metasploit-framework
    bloodhound
    bloodhound.py
    sqlmap
    ffuf
    wfuzz
    dnsrecon
    crackmapexec
    evil-winrm
    hashcat
)

# Install the tools from the Kali Repository
for tool in "${kali_tools[@]}"; do
    sudo apt install -y "$tool" -t kali-rolling
done

echo "Kali tools from the Kali Repository are installed."

# ------------------- VS Code Install ------------------- #

echo "Installing VS Code..."
sudo apt-get install -y wget gpg

# Download Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

# Install the GPG key to the package keyring
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

# Add VS Code repository to sources.list.d
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# Clean up the downloaded GPG key
rm -f packages.microsoft.gpg

# Install apt-transport-https if not already installed
sudo apt-get install -y apt-transport-https

# Update the package list to include the VS Code repository
sudo apt update

# Install VS Code
sudo apt install -y code

echo "VS Code installed."

echo "Adding Extensions"
code --install-extension vscode-icons-team.vscode-icons
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension github.copilot
code --install-extension oderwat.indent-rainbow
code --install-extension rust-lang.rust-analyzer
code --install-extension dustypomerleau.rust-syntax
code --install-extension tamasfe.even-better-toml
code --install-extension serayuzgur.crates
code --install-extension wayou.vscode-todo-highlight
echo "Extensions Done."

# ------------------- Brave Browser Install ------------------- #

# Download and add the Brave browser GPG key to the keyring
echo "Adding Brave browser GPG key..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

# Add Brave browser repository to sources.list.d
echo "Adding Brave browser repository..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Update the package list to include the Brave browser repository
echo "Updating package list..."
sudo apt update

# Install Brave browser
echo "Installing Brave browser..."
sudo apt install -y brave-browser

echo "Brave browser is installed."

# ------------------- Additional Configurations ------------------- #

# Gunzip the rockyou wordlist if necessary
echo "Checking and gunzipping the rockyou wordlist..."
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

# Zsh as the default shell
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Reminders
echo "Don't forget to install the following tools manually:"
echo "Choose your poison: Burp Suite, ZAP, or Caido"

echo "Install any additional tools via the 'sudo apt install TOOL -y -t kali-rolling' command."

echo "Setup completed. Happy hacking!"

echo "Log out and log back in and run terminal_setup.sh to complete the terminal setup."
