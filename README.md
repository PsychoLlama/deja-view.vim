<div align="center">
  <h1>Deja View</h1>
  <p><em>Buffers, just how you left them.</em></p>
</div>

## Purpose

This plugin remembers where you left off in a file, restoring your cursor and viewport.

Vim can kind of do this already, and if you're looking for something simple, just read `:help last-position-jump`. It'll get you 90% of the way there.

What it *doesn't* do is restore your scroll position, a detail which finally got annoying enough that I wrote my own plugin. It uses `winsaveview()` under the hood.

## Installation

Deja View is compatible with vim & neovim.

**[packer](https://github.com/wbthomason/packer.nvim)**

```vim
use 'PsychoLlama/deja-view.vim'
```

**[vim-plug](https://github.com/junegunn/vim-plug)**

```vim
Plug 'PsychoLlama/teleport.vim'
```

**[pathogen](https://github.com/tpope/vim-pathogen)**

```bash
git clone https://github.com/PsychoLlama/deja-view.vim ~/.vim/bundle/deja-view.vim
```
