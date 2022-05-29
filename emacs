;;; .emacs --- config
;;; commentary:

;;; dependencies
(require 'cl-lib)
(require 'package)

;;; code:

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(defvar required-packages
  '(
    desktop
    linum-relative
    magit
    ggtags
    paganini-theme
    projectile
    recentf
    semantic
    smooth-scrolling
    spaceline
    sr-speedbar
    yasnippet
    undo-tree
    ;; evil
    evil
    evil-leader
    evil-collection
    evil-multiedit
    evil-org
    evil-surround
    ;; ivy
    ivy
    counsel
    counsel-projectile
    smex
    ;; org
    org
    org-bullets
    ;; language specific packages
    go-mode
    go-autocomplete
    go-guru
    rust-mode
    tree-sitter
    markdown-mode
    less-css-mode
    php-mode
    yaml-mode
    web-mode
   )
)

;; define package installer
(defun install-packages ()
  (interactive)
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(defun update-packages ()
  (interactive)
  (progn
    (package-refresh-contents)
    (package-menu-mark-upgrades)
    (package-menu-execute)))

(setq evil-want-keybinding nil)
;; load required packages
(cl-loop for p in required-packages
  do (require p))

;; UI
(load-theme 'paganini t)
(set-face-foreground 'font-lock-comment-face "dark grey")
(set-face-foreground 'font-lock-comment-delimiter-face "dark grey")
(set-background-color "#111111")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "black" :foreground "green yellow"))))
 '(mouse ((t (:background "light gray"))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif" :height 2.0 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#F8F8F2" :family "Sans Serif"))))
 '(powerline-active1 ((t (:inherit mode-line :background "#2D2D2D" :foreground "light gray")))))



(setq-default show-trailing-whitespace t)
(set-face-attribute 'default nil :height 90)
(defalias 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode t)
(scroll-bar-mode -1)
(setq linum-relative-backend 'display-line-numbers-mode)
(linum-relative-global-mode)

(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t
      initial-scratch-message nil)
(blink-cursor-mode 0)

(smooth-scrolling-mode 1)
(setq scroll-preserve-screen-position t)

;; CUSTOMISATIONS
;; undo
(global-undo-tree-mode t)
;; use 4 spaces instead of tabs
(setq-default tab-width 4 indent-tabs-mode nil)
;; don't create backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
;; copy/paste
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(setq select-enable-primary t)
(global-set-key [mouse-2] 'mouse-yank-at-click)
;; history
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'regexp-search-ring)
;; disable autosave
(setq auto-save-default nil)
;; remap c-x to c-a too
(keyboard-translate ?\C-a ?\C-x)

;; KEY BINDINGS
(global-set-key [f8] 'linum-relative-toggle)
(global-set-key [f9] 'toggle-menu-bar-mode-from-frame)

;; ELECTRIC-PAIR-MODE

(electric-pair-mode)

;;; PACKAGE SPECIFIC SETTINGS

;; EVIL MODE
(evil-mode 1)
(global-evil-surround-mode 1)
(evil-set-undo-system 'undo-tree)

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "TAB") nil))
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-l") 'evil-window-right)
(cl-loop for (mode . state) in '((dired-mode . normal) ; can be normal, insert, emacs, etc..
                              (org-agenda-mode . normal)
                              (magit-diff-mode . normal)
                              (magit-log-mode . normal))
      do (evil-set-initial-state mode state))

;;; EVIL: NORMAL
(define-key evil-normal-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-normal-state-map (kbd "C-p") 'evil-multiedit-prev)
;;; EVIL: VISUAL
(define-key evil-visual-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-visual-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

(define-key evil-multiedit-mode-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
(evil-ex-define-cmd "W[rite]" 'evil-write)
(evil-ex-define-cmd "Wa[ll]" 'evil-write-all)
(evil-ex-define-cmd "wA[ll]" 'evil-write-all)
(evil-ex-define-cmd "WA[ll]" 'evil-write-all)
(evil-ex-define-cmd "qA[ll]" "quitall")
(evil-ex-define-cmd "Qa[ll]" "quitall")

;; COMPANY
;(add-hook 'after-init-hook 'global-company-mode)
;(global-set-key "\t" 'company-complete-common)
;(defun my/python-mode-hook ()
;  (add-to-list 'company-backends 'company-jedi))
;
;(add-hook 'python-mode-hook 'my/python-mode-hook)

;; FLYCHECK
;(global-flycheck-mode)
;(setq flycheck-check-syntax-automatically '(mode-enabled save))
;(setq flycheck-highlighting-mode 'lines)

;; SPACELINE
(require 'spaceline-config)
(spaceline-spacemacs-theme)

;; SEMANTIC

(global-semantic-idle-summary-mode 1)
(global-semantic-stickyfunc-mode 1)

;; YASNIPPET
(yas-global-mode 1)

;; IVY
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-height 30)
(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order)))
;(setq ivy-re-builders-alist
;      '((ivy-switch-buffer . ivy--regex-plus)
;        (t . ivy--regex-fuzzy)))
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-s") 'counsel-grep-or-swiper)
(global-set-key (kbd "C-x C-f") 'counsel-projectile-find-file)
(global-set-key (kbd "C-x C-o") 'counsel-find-file)
(global-set-key (kbd "C-x C-b") 'counsel-recentf)
(define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line-or-history)
(define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line-or-history)



;; ORG
(global-set-key "\C-xa" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-directory "~/d/org")
(setq org-agenda-files '("~/n/org"))
(setq org-agenda-start-with-follow-mode t)
(setq org-default-notes-file "~/n/org/notes.org")
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/n/org/tasks.org" "Tasks")
                               "* TODO %i%?")
                              ("a" "Agenda" entry
                               (file+headline "~/n/org/agenda.org" "Agenda")
                               "* TODO %i%? \n %U")))

;; RECENTF
(recentf-mode 1)
(setq recentf-max-menu-items 512)
(setq recentf-auto-cleanup 'never)

;; MAGIT
(global-set-key (kbd "C-x C-g") 'magit-status)

;; SPEEDBAR
(global-set-key (kbd "<f3>") 'sr-speedbar-toggle)
(setq speedbar-frame-parameters
      '((minibuffer)
	(width . 40)
	(border-width . 0)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(unsplittable . t)
	(left-fringe . 0)))
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-max-width 70)
(setq sr-speedbar-width-console 40)

;; GO-MODE - GOLANG
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'completion-at-point-functions 'go-complete-at-point)
(add-to-list 'auto-mode-alist (cons "\\.go\\'" 'go-mode))
(add-hook 'go-mode-hook
                    (lambda () (local-set-key (kbd "C-0") #'run-latexmk)))
; jump to definition
;(local-set-key (kbd "C-x j") 'godef-jump)
(defun my-go-electric-brace ()
  "Insert an opening brace may be with the closing one.
If there is a space before the brace also adds new line with
properly indented closing brace and moves cursor to another line
inserted between the braces between the braces."
  (interactive)
  (insert "{")
  (when (looking-back " {")
    (newline)
    (indent-according-to-mode)
    (save-excursion
      (newline)
      (insert "}")
      (indent-according-to-mode))))

(defun my-godoc-package ()
  "Display godoc for given package (with completion)."
  (interactive)
  (godoc (ivy-read "Package: " (go-packages) :require-match t)))

;(use-package go-guru
;  :after go-mode)
;
;(use-package go-mode
;  :init
;  ;(setq go-fontify-function-calls nil)  ; fontifing names of called
;  ;                                      ; functions is too much for me
;  :bind
;  (:map go-mode-map
;        ("C-x C-d" . godoc)
;        ("C-x C-p" . my-godoc-package)
;        ("{" . my-go-electric-brace)))
;
(eval-after-load 'go-mode
  '(progn
     (local-set-key (kbd "C-x j") 'godef-jump)
     (local-set-key (kbd "C-x d") 'my-godoc-package)
     (local-set-key (kbd "{") 'my-go-electric-brace)
   )
)

(eval-after-load 'speedbar
  '(speedbar-add-supported-extension ".go"))

;; PYTHON-MODE
;(define-key global-map (kbd "RET") 'newline-and-indent)

;; WEB-MODE

(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

;; C-MODE

(setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode nil)

;; RUST-MODE
(setq rust-format-on-save t)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; YAML-MODE
(add-hook 'yaml-mode-hook
  '(lambda ()
     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(provide '.emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(go-complete cargo-mode paganini-theme org-bullets poet-theme undo-tree web-mode go-guru auto-yasnippet mmm-mode jedi yasnippet yaml-mode sr-speedbar spaceline smooth-scrolling smex molokai-theme markdown-mode linum-relative less-css-mode go-mode evil-surround evil-org evil-multiedit evil-magit evil-leader counsel-projectile company-php company-jedi)))


