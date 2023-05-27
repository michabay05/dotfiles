;; Set up package.el to work with MELPA
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;; Stop creating backup files
(setq make-backup-files nil)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Relative line numbers
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode) 

;; Block cursor in insert mode
;; (setq evil-insert-state-cursor 'box)

;; Themes
(use-package gruber-darker-theme)
(setq main-theme 'gruber-darker)
(load-theme main-theme t)

(use-package evil
  :config
  (evil-mode 1)
)

(use-package evil-textobj-tree-sitter :ensure t)

(set-frame-font "Iosevka Nerd Font Mono 12" nil t)

;; Disable welcome screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

;; Ido
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)

;; Company
(require 'company)

;; (use-package 'tree-sitter)
;; (use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-langs)

;; (require 'treesit)
(global-tree-sitter-mode)
(setq font-lock-maximum-decoration t)

;; Rust mode
(use-package rust-mode
  :ensure t)
(require 'rust-mode)

;; Smex: smart M-x
(use-package smex
  :ensure t)
(require 'smex)
(global-set-key (kbd "M-x") 'smex)

(use-package multiple-cursors
  :ensure t)
(require 'multiple-cursors)

;; Smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000
      scroll-margin          8)

;; ======================== KEYMAPS ========================
;; Leader key remap
(evil-set-leader nil (kbd "SPC"))
;; Escape key remap
(define-key evil-insert-state-map "jk" 'evil-normal-state)
;; Comments related
(define-key evil-normal-state-map "gc" 'comment-dwim)
(define-key evil-normal-state-map "gb" 'comment-region)
;; Buffer related
(define-key evil-normal-state-map (kbd "<leader>l") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "<leader>h") 'evil-prev-buffer)
(define-key evil-normal-state-map (kbd "<leader>c") 'evil-delete-buffer)
(define-key evil-normal-state-map (kbd "<leader>n") 'evil-buffer-new)

(define-key evil-normal-state-map (kbd "<leader>f") 'find-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(company markdown-mode multiple-cursors rust-mode smex tree-sitter-langs evil cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )