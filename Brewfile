# Create Brewfile
cat > Brewfile << EOL
# Taps
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

# CLI tools
brew "git"
brew "neovim"
brew "tmux"
brew "docker-compose"
brew "temurin@17"

# Apps
cask "alacritty"
EOL

# Create README
cat > README.md << EOL
# Dotfiles

Personal configuration files for development environment.

## Includes configurations for:
- Neovim
- Alacritty
- CSpell
- Tmux

## Installation
\`\`\`bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/bootstrap.sh
\`\`\`
EOL

# Create .gitignore
cat > .gitignore << EOL
.DS_Store
*.log
.cache/
node_modules/
EOL
