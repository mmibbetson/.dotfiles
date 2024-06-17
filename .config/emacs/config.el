;; Load colour theme
(load-theme 'modus-vivendi t)

;; Remove unnecessary GUI features
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Add line numbers (TODO: Add relative line numbers mode)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;; Remove startup message and switch bell to visual
(setq inhibit-startup-message t
      visible-bell t)

;; Tangle keybind
(use-package org
  :bind (:map org-mode-map ("C-c C-v t" . org-babel-tangle)))
