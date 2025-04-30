#!/usr/bin/env bash

set -xeuo pipefail

stow --target="$HOME" --dir="$HOME/.dotfiles/" .
