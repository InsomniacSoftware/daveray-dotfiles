;; Package BS


(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
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
                      ac-nrepl))

(dolist (p my-packages)
  (when (not (package-installed-p p))
        (package-install p)))

(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;######################################################################

;; If something changes outside emacs, reload it
(global-auto-revert-mode 1)

;; Set up theme and appearance
(load-theme 'desert t)

;; Always show line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; Initialize auto-complete
(require 'auto-complete)
(global-auto-complete-mode)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-nrepl-mode-hook 'ac-nrepl-setup)

;; find in project
(require 'find-file-in-project)
(global-set-key (kbd "C-x f") 'find-file-in-project)

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

(setq initial-frame-alist '((top . 0) (left . 0) (width . 100) (height . 50)))

