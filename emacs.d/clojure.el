(defun clojure-clear-ns ()
  "Clear all the symbols from the current namespace

  Useful for cruft that's built up, renamed tests, multi-method dispatch changes.

  Be careful."
  (interactive)
  (let* ((ns (cider-current-ns))
         (n (cider-eval-and-get-value "(clojure.core/let [ns *ns*] (clojure.core/binding [*ns* (clojure.core/find-ns 'clojure.core)] [(str ns) (count (mapv #(ns-unmap ns %) (keys (ns-interns ns))))]))")))
    (message "Cleared %s symbols from %s" n ns)))

(if nil (defun my-clojure-mode-keys ()
   "Add some keymaps in Clojure mode"
   (local-set-key (kbd "C-c q") 'my-clojure-clear-ns)))
