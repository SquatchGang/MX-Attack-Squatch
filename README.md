# MX-Attack-Squatch

This Bash script automates the setup of essential tools and configurations for penetration testing, red teaming, and CTF (Capture The Flag) activities on MX Linux.

### Features

- Updates the package list and upgrades existing packages.
- Adds the Kali Linux repository to access additional penetration testing tools.
- Installs a list of essential tools from default repositories.
- Installs specific Kali Linux tools.
- Installs Visual Studio Code for coding convenience.
- Installs the Brave browser for secure browsing.
- Installs Oh My Zsh with plugins for enhanced terminal functionality.
- Sets up Zsh as the default shell.
- Activates Zsh plugins for autosuggestions and syntax highlighting.

### Instructions

1. Clone this repository or download the scripts.
2. Make the scripts executable: `chmod +x install.sh` + `terminal_setup.sh`
3. Run the script with superuser privileges: `sudo ./install.sh`
4. Follow any on-screen prompts, and the script will automate the setup process.
5. Log out and back on
6. Run the script with superuser privileges: `sudo ./terminal_setup.sh`
6. Done!

### Notes

- Manually install additional tools as needed via the `sudo apt install TOOL -y -t kali-rolling` command.
- Script currently does not install burp, zap, or caido. You do you bro.

Feel free to contribute to this repository and improve the scripts!
