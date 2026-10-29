(add-to-list 'default-frame-alist '(font .  "Meslo LGM-12.5"))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups/")))

(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq visible-bell nil)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(global-hl-line-mode)
(global-auto-revert-mode)

(ido-mode)
(ido-everywhere)

;;; Language modes
(add-to-list 'load-path "~/.emacs.d/personal")

(setq whitespace-style '(face
                         tabs
                         spaces
                         trailing
                         space-before-tab
                         space-after-tab
                         tab-mark
                         space-mark))
(global-whitespace-mode 1)


;;; Package list
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(use-package evil
  :demand t
  :init
  (setq evil-default-state 'normal
        evil-want-C-w-in-emacs-state t
        evil-want-C-w-delete t
        evil-want-Y-yank-to-eol t
        evil-want-C-u-scroll t
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-undo-system 'undo-fu
        evil-symbol-word-search t
	evil-want-minibuffer t
        evil-kill-on-visual-paste nil)
  :config
    (evil-mode 1)
    (evil-define-key '(normal visual insert motion emacs) 'global
      (kbd "C-b") #'compile)
    (with-eval-after-load 'compile
        (evil-define-key '(normal motion) compilation-mode-map
          (kbd "r") #'recompile)))

;;; Colorscheme
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;;; Magit
(use-package magit)

;;; Compilation mode
(require 'compile)
(add-to-list 'compilation-error-regexp-alist
     '("\\([A-Za-z-_/.]+\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3))

(use-package ansi-color
    :hook (compilation-filter . ansi-color-compilation-filter))

(use-package smex
    :ensure t
    :config
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex))

;;; Custom keybinds
(global-set-key (kbd "M-h") #'ido-dired)
(global-set-key (kbd "M-j") #'find-file)
(global-set-key (kbd "M-k") #'ido-switch-buffer)
(global-set-key (kbd "M-m") #'compile)
(global-set-key (kbd "M-n") #'recompile)

;;; Tree-sitter
(use-package treesit
  :ensure nil
  :init
  (setq treesit-language-source-alist
        '((typst "https://github.com/uben0/tree-sitter-typst"))))

;;; Language modes
(use-package markdown-mode)

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode"))

(use-package websocket)

(use-package typst-preview
  :init
  (setq typst-preview-autostart t)
  (setq typst-preview-open-browser-automatically t)

  :custom
  (typst-preview-browser "default")
  (typst-preview-invert-colors "auto")
  (typst-preview-executable "tinymist")
  (typst-preview-partial-rendering t)

  :config
  (define-key typst-preview-mode-map (kbd "C-c C-j") 'typst-preview-send-position))


;; Set custom file
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)
