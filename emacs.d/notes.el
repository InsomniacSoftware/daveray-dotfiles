;;; Notes

(defun notes-find-file ()
  (interactive)
  (ido-find-file-in-dir "~/.notes"))
(defun notes-grep ()
  (interactive)
  (grep-compute-defaults)
  (rgrep (grep-read-regexp) "*.txt" "~/.notes")
  (switch-to-buffer-other-window "*grep*"))
(defun notes-log ()
  (interactive)
  (split-window-below 20)
  (find-file (format-time-string "~/.notes/log/%Y-%m-%d.txt")))

(defun notes-parse-time-from-name (name)
  (when (string-match "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].txt$" name)
    (let* ((time (parse-time-string (file-name-sans-extension name))))
      (setf (nth 0 time) 0)
      (setf (nth 1 time) 0)
      (setf (nth 2 time) 0)
      time)))

(defun notes-next-log-name* (d-days)
  (let* ((name (buffer-name (current-buffer)))
         (next-time (notes-parse-time-from-name name)))
    (when next-time
      (setf (nth 0 next-time) 0)
      (setf (nth 1 next-time) 0)
      (setf (nth 2 next-time) 0)
      (setf (nth 3 next-time) (+ (nth 3 next-time) d-days))
      (format-time-string "~/.notes/log/%Y-%m-%d.txt" (apply 'encode-time next-time)))))

(defun notes-next-log (d-days)
  (let* ((name (notes-next-log-name* d-days)))
    (when name
      (find-file name))))

(defun notes-log-timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %a %I:%M %p\n")))

(define-prefix-command 'notes-map)
(global-set-key (kbd "C-c") 'notes-map)
(define-key notes-map (kbd "n z") 'notes-find-file)
(define-key notes-map (kbd "n f") 'notes-grep)
(define-key notes-map (kbd "n l") 'notes-log)
(define-key notes-map (kbd "n t") 'notes-log-timestamp)
(define-key notes-map (kbd "n =") (lambda () (interactive) (notes-next-log 1)))  ; next day
(define-key notes-map (kbd "n -") (lambda () (interactive) (notes-next-log -1))) ; previous day

