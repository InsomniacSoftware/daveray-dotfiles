(setq current-workspace ?1)
(add-hook 'after-init-hook '(lambda () (window-configuration-to-register ?0)))

(defun workspace (r)
  (interactive)
  (let ((c (get-register r)))
    (if current-workspace
        (window-configuration-to-register current-workspace))
    (setq current-workspace r)
    (jump-to-register (if c r ?0))))

(global-set-key (kbd "M-1") (lambda () (interactive) (workspace ?1)))
(global-set-key (kbd "M-2") (lambda () (interactive) (workspace ?2)))
(global-set-key (kbd "M-3") (lambda () (interactive) (workspace ?3)))
(global-set-key (kbd "M-4") (lambda () (interactive) (workspace ?4)))
(global-set-key (kbd "M-5") (lambda () (interactive) (workspace ?5)))
(global-set-key (kbd "M-6") (lambda () (interactive) (workspace ?6)))
(global-set-key (kbd "M-7") (lambda () (interactive) (workspace ?7)))
(global-set-key (kbd "M-8") (lambda () (interactive) (workspace ?8)))
(global-set-key (kbd "M-9") (lambda () (interactive) (workspace ?9)))

