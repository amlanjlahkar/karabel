![The XKeyboardCD](https://imgs.xkcd.com/comics/xkeyboarcd.png)

This repository contains my personal rules for [karabiner elements](https://karabiner-elements.pqrs.org/).

## Motivation
I favor a keyboard-centric workflow on my system. Although most GUI software that I use provides basic keybindings for interacting with the interface or for invoking particular events, most of them feel non-ergonomic on my standard ANSI layout keyboard. This is my attempt at fixing the annoying quirks I encounter in such situations while also maintaining a single unified configuration for all my macOS specific custom key mappings.

## Mapping principles
- Using caps lock as control key in applications where frequent access to the control key is required(e.g., vim), otherwise caps lock functions as the hyper key. The hyper key combines all four modifier keys(shift + control + option + command), making it useful in custom mappings to avoid conflicts with system-specific keybindings.

- Utilizing the hyper key for frequently performed tasks and the option key for tasks that are less common but still benefit from a keybinding.

- Minimizing the use of command as a modifier key for custom mappings, as most default keybindings tend to rely on it.

## Generation
The [generators](./generators) directory contains the jsonnet templates used for generating the corresponding complex_modification files in json format.

The makefile can be used to simplify the generation process.
```sh
git clone https://github.com/amlanjlahkar/karabel.git ~/karabel && cd ~/karabel

# Install dependencies, generate the targets(if modified)
# and symlink ~/karabel to ~/.config/karabiner
# NOTE: should only be used the first time
make init

# simply run make to generate the new/outdated targets
make
```
