/**
 * Usage: `bun run index.ts`
 */
import { existsSync } from 'fs';
import { homedir } from 'os';
import { dirname, join } from 'path';
import { $ } from 'zx'

const links: string[] = [
  '.config/nvim/init.vim',
  '.zsh/.zsh-user.sh',
  '.ssh/config',
  '.git-excludesfile',
  '.gitconfig',
  '.inputrc',
  '.tmux.conf',
  '.zshrc',
];

async function homebrewFormulas() {
  console.log("Installing homebrew formulas...");
  await $`brew bundle --file Brewfile`;
  console.log("Done: homebrew formulas installed");
}


async function rustSetup() {
  // rust (rust-lang.org/tools/install)
  await $`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y`;
}

async function createSoftlinks() {
  console.log("Creating softlinks for dotfiles (2)...");

  const home = homedir();

  for (let path of links) {
    const destination = join(import.meta.dir, path);
    const src = join(home, path);

    if (!existsSync(src)) {
      const srcDir = dirname(src);
      if (srcDir != src && !existsSync(srcDir)) {
        await $`mkdir -p ${srcDir}`;
      }

      await $`ln -s ${destination} ${src}`;
    }
  }

  console.log("Done: Softlinks created.");
}

async function neovimSetup() {
  console.log("Setting up neovim...");

  // neovim should be installed by homebrew
  await $`nvim -version`;

  // Download vim-plugin
  const vimplug = `https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`;
  await $`curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs ${vimplug}`;

  // This automated equivalent of:
  // 1. opening Neovim (by running nvim)
  // 2. Running :PlugInstall in Normal Mode
  await $`nvim -c ':PlugInstall' -c 'qa!'`;

  // Add FZF config to .zsh
  // When running either (:Files for Filename fuzzy search, or :Rg for big-grep search), 
  // junegunn/fzf will run the command defined by $FZF_DEFAULT_COMMAND environment variable 
  // and pipe it into fzf which in turn produces a list inside vim. 
  // Add the following to .bash_profile:
  if (!process.env.FZF_DEFAULT_COMMAND) {
    const output = `$FZF_DEFAULT_COMMAND="rg --files --follow --hidden"`;
    await $`echo ${output} >> .zshrc`;
  }
  console.log("Done: Neovim setup completed");
}

async function tmuxSetup() {
  console.log("Setting up tmux...");

  // tmux should be installed by homebrew
  await $`tmux -V`;
  await $`which tmux`;

  // install tmux plugin manager
  const home = homedir();
  const tpmDir = join(home, '.tmux/plugins/tpm');
  if (!existsSync(tpmDir)) {
    await $`git clone https://github.com/tmux-plugins/tpm ${tpmDir}`
  }

  console.log("Done: tmux installed");
}

async function repeatRate() {
  console.log("Updating macOS keyboard repeat rate");

  // Increase the keyboard repeat rate
  // https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x/83923#83923
  await $`defaults write -g InitialKeyRepeat -int 10`;
  await $`defaults write -g KeyRepeat -int 1`;
  // https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode
  await $`defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`;

  console.log("Done: keyboard repeat rate updated.");
  console.log("Note: you will need to logout for changes to take effect");
}

await createSoftlinks();
await homebrewFormulas();
await neovimSetup();
await tmuxSetup();
await rustSetup();
await repeatRate();
