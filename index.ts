/**
 * Usage: `bun run index.ts`
 */
import { homedir } from 'os';
import { dirname, resolve } from 'path';
import { $ } from 'zx'

const links: string[] = [
  '.config/nvim/init.vim',
  '.git-excludesfile',
  '.gitconfig',
  '.inputrc',
  '.tmux.conf',
  '.zsh-user.sh',
  '.zshrc',
];

async function homebrewFormulas() {
  console.log("Installing homebrew formulas...");
  await $`brew bundle --file Brewfile`;
  console.log("Done: homebrew formulas installed");
}


async function rustSetup() {
  // rust (rust-lang.org/tools/install)
  await $`rustup-init`;
  await $`rustc --version`;
}

async function createSoftlinks() {
  console.log("Creating softlinks for dotfiles...");

  const home = homedir();

  for (let path of links) {
    const source = resolve(import.meta.dir, path);
    const destination = resolve(home, path);

    const destinationDir = dirname(destination);
    if (destinationDir != home) {
      await $`mkdir -p ${destinationDir}`;
    }

    await $`ln -s ${destination} ${source}`;
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
  const output = `$FZF_DEFAULT_COMMAND="rg --files --follow --hidden"`;
  await $`echo ${output} >> .zshrc`;
  console.log("Done: Neovim setup completed");
}

async function tmuxSetup() {
  // tmux should be installed by homebrew
  await $`tmux -V`;
  await $`which tmux`;
  await $`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
}

await homebrewFormulas();
await createSoftlinks();
await neovimSetup();
await tmuxSetup();
await rustSetup();
