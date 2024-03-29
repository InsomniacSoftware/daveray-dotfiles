;; Package BS


(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      cider
                      ac-nrepl
                      flx-ido
                      projectile
                      ;;find-file-in-project
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
        (package-install p)))

(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;######################################################################

;; If something changes outside emacs, reload it
(global-auto-revert-mode 1)

;; Find unbound keys
(require 'unbound)

;; Set up theme and appearance
(load-theme 'desert t)
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-13"))

;; Always show line numbers
(global-linum-mode t)
(setq linum-format "%3d ")
(column-number-mode)

;; Configure auto-fill, i.e. kill it
(setq-default fill-column 80)
(turn-off-auto-fill)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

;; Die flyspell
(remove-hook 'text-mode-hook #'turn-on-flyspell)

;; Initialize auto-complete
(require 'auto-complete)
(global-auto-complete-mode)
(setq ac-auto-start 0.6) ; nrepl is way to slow so delay ac
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

;; flx-ido
;; https://github.com/lewang/flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; projectile
;; https://github.com/bbatsov/projectile
(projectile-global-mode)


;; Rainbow delims
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; Ugh

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:underline "yellow")))))

;;############################################################################

(setq initial-frame-alist '((top . 0) (left . 0) (width . 100) (height . 50)))

;;###########################################################################

(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(global-set-key (kbd "C-,") 'move-cursor-previous-pane)
(global-set-key (kbd "C-.") 'move-cursor-next-pane)

;;###################################################################
(load "~/.emacs.d/workspace.el")
(load "~/.emacs.d/notes.el")
(load "~/.emacs.d/clojure.el")
(load "~/.emacs.d/haskell.el")
