# skel.vim

A very small and simple tool for loading template files in Vim.

## Features

* Reads templates from the runtimepath, with expected behavior: later entries
  override previous entries.
* Entirely automated, but with the escape hatch of being able to force loading
  if any issues do develop.

## Documentation

A help file is included with this plugin.
Be sure to create tag files if your plugin manager does not do it for you.
(See installation section below for more details.)

## Installation

Install using your favorite package manger, or use Vim's built-in package
support:

```shell
mkdir -p ~/.vim/pack/user/start
cd ~/.vim/pack/user/start
git clone http://github.com/deoxys314/skel.vim
vim -u NONE -c "helptags skel.vim/doc" -c q
```

## Contributing

This plugin is designed primarily for the personal use of the author, so forking
is encouraged for changes.
If you have a truly revolutionary feature you are certain _must_ be present, I
will review pull requests as my time allows.
Before sending one in, please know that complexity is a specific ungoal of this
project.
It is simple, opinionated, and (to the best of my ability), idiot-proof.
I will reject pull requests that do not conform to this.
