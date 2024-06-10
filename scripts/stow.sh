#!/usr/bin/env bash

set -xe

stow --target="$HOME" --dir="$HOME/.dotfiles/" .
