;;; workspace.el --- workspace management

;; Copyright (C) 2014 Dave Ray


(defun ws-make-workspace (i r)
  (let ((w (make-hash-table :test 'equal)))
    (puthash 'index i w)
    (puthash 'reg r w)
    (puthash 'title (number-to-string i) w)
    (puthash i w ws-workspaces)
    w))

(defun ws-workspace? (i)
  (let* ((w (gethash i ws-workspaces))
         (r (and w (gethash 'reg w))))
    (and r (get-register r))))

(defun ws-next-workspace* (init from dir)
  (let* ((next (+ from dir))
         (wrapped (cond ((= 0 next) 9)
                        ((= 10 next) 1)
                        (t next))))
    (if (or (eq init wrapped) (ws-workspace? wrapped))
        wrapped
      (ws-next-workspace* init wrapped dir))))

(defun ws-cycle-workspace (dir)
  "Switch to next workspace in given direction (+1, or -1)"
  (interactive "nDirection(1, or -1): ")
  (let* ((i (gethash 'index ws-current-workspace))
         (next (ws-next-workspace* i i dir)))
    (if (not (eq i next))
        (ws-switch-to-workspace (cond ((= 0 next) 9)
                                      ((= 10 next) 1)
                                      (t next))))))

(defun ws-save-workspace ()
  "Save the state of the current workspace"
  (interactive)
  (window-configuration-to-register (gethash 'reg ws-current-workspace)))

(defun ws-restore-workspace ()
  "Restore the current workspace"
  (interactive)
  (let* ((r (gethash 'reg ws-current-workspace)))
    (if r
        (jump-to-register r))))

(defun ws-switch-to-workspace* (i copy?)
  (let* ((w (gethash i ws-workspaces))
        (r (gethash 'reg w))
        (exists? (get-register r)))
    (window-configuration-to-register (gethash 'reg ws-current-workspace))
    (setq ws-current-workspace w)
    (if (not copy?)
        (jump-to-register (if exists? r ?0)))))

(defun ws-switch-to-workspace (i)
  "Switch to workspace i"
  (interactive "nWorkspace(1-9): ")
  (ws-switch-to-workspace* i nil))

(defun ws-copy-to-workspace (i)
  "Copy the current layout to workspace i and switch to it"
  (interactive "nTarget Workspace(1-9): ")
  (ws-switch-to-workspace* i t))

(defun ws-workspace-desc-entry (w)
  (let* ((title (gethash 'title w)))
    (if (eq ws-current-workspace w)
        (concat "[" title "]")
      title)))

(defun ws-workspaces-desc ()
  (let ((result ""))
    (maphash (lambda (i w)
               (if (or (get-register (gethash 'reg w))
                       (eq ws-current-workspace w))
                   (setq result (concat result (ws-workspace-desc-entry w)))))
             ws-workspaces)
    result))

;;;

(setq ws-workspaces (make-hash-table :test 'equal))

(ws-make-workspace 1 ?1)
(ws-make-workspace 2 ?2)
(ws-make-workspace 3 ?3)
(ws-make-workspace 4 ?4)
(ws-make-workspace 5 ?5)
(ws-make-workspace 6 ?6)
(ws-make-workspace 7 ?7)
(ws-make-workspace 8 ?8)
(ws-make-workspace 9 ?9)

(setq ws-current-workspace (gethash 1 ws-workspaces))

(global-set-key (kbd "M-`") (lambda () (interactive) (ws-cycle-workspace 1)))
(global-set-key (kbd "M-~") (lambda () (interactive) (ws-cycle-workspace -1)))
(global-set-key (kbd "C-`") (lambda () (interactive) (ws-restore-workspace)))
(global-set-key (kbd "C-~") (lambda () (interactive) (ws-save-workspace)))
(global-set-key (kbd "M-1") (lambda () (interactive) (ws-switch-to-workspace 1)))
(global-set-key (kbd "M-2") (lambda () (interactive) (ws-switch-to-workspace 2)))
(global-set-key (kbd "M-3") (lambda () (interactive) (ws-switch-to-workspace 3)))
(global-set-key (kbd "M-4") (lambda () (interactive) (ws-switch-to-workspace 4)))
(global-set-key (kbd "M-5") (lambda () (interactive) (ws-switch-to-workspace 5)))
(global-set-key (kbd "M-6") (lambda () (interactive) (ws-switch-to-workspace 6)))
(global-set-key (kbd "M-7") (lambda () (interactive) (ws-switch-to-workspace 7)))
(global-set-key (kbd "M-8") (lambda () (interactive) (ws-switch-to-workspace 8)))

(add-hook 'after-init-hook
          '(lambda ()
             (setq-default mode-line-format (cons '(:eval (ws-workspaces-desc)) mode-line-format))
             ;; initial window config will be our template. hmmm.
             (window-configuration-to-register ?0)))

