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
  // await $`brew bundle --file Brewfile`;
  console.log("Done: homebrew formulas installed");
}


async function rustSetup() {
  // rust (rust-lang.org/tools/install)
  // await $`rustup-init`;
  // await $`rustc --version`;
}

async function createSoftlinks() {
  console.log("Creating softlinks for dotfiles...");

  const home = homedir();

  for (let path of links) {
    const source = resolve(import.meta.dir, path);
    const destination = resolve(home, path);

    const destinationDir = dirname(destination);
    if (destinationDir != home) {
      console.log(`mkdir -p ${destinationDir}`)
      // await $`mkdir -p ${destinationDir}`;
    }

    console.log(`ln -s ${destination} ${source}`)
    // await $`ln -s ${destination} ${source}`;
  }

  console.log("Done: Softlinks created.");
}

async function neovimSetup() {
  console.log("Setting up neovim...");
  // Download vim-plugin
  // const vimplug = `https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`;
  // await $`curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs ${vimplug}`;

  // This automated equivalent of:
  // 1. opening Neovim (by running nvim)
  // 2. Running :PlugInstall in Normal Mode

  // Add FZF to .zsh
  // const output = `$FZF_DEFAULT_COMMAND="rg --files --follow --hidden"`
  // await $`echo ${output} >> .zshrc`;
  console.log("Done: Neovim setup completed");
}

await homebrewFormulas();
await createSoftlinks();
await neovimSetup();
await rustSetup();