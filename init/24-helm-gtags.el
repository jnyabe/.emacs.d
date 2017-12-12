(require 'helm-config)
(require 'helm-gtags)

(add-hook 'c-mode-common-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode 'helm-gtags-mode)
(add-hook 'csharp-mode-hook 'helm-gtags-mode)

;; switch header/cpp files
;; (defun helm-gtags-find-file-toggle-header-source ()
;;   (interactive)
;;   (defun replace-string-regexp (str from to)
;;     (when (string-match from str)
;;       (replace-match to nil nil str)))
;;   (let* ((file-name
;;    (file-name-nondirectory (buffer-file-name)))
;;   (replaced-file-name
;;    (or (replace-string-regexp file-name "\\.cpp$" ".h")
;;        (replace-string-regexp file-name "\\.h$" ".cpp"))))
;;     (unless replaced-file-name (error "not found..."))
;;     (helm-gtags-find-files replaced-file-name)))

(defun helm-gtags-find-file-toggle-header-source ()
  (interactive)
  (defun replace-string-regexp (str from to)
    (when (string-match from str)
      (replace-match to nil nil str)))
  (let* ((file-name
   (concat "/" (file-name-nondirectory (buffer-file-name))))
  (replaced-file-name
   (or (replace-string-regexp file-name "\\.cpp$" ".h")
       (replace-string-regexp file-name "\\.h$" ".cpp"))))
    (unless replaced-file-name (error "not found..."))
    (helm-gtags-find-files replaced-file-name)))

;; key bindings
(add-hook 'helm-gtags-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
	     (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
	     (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
	     (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
	     (local-set-key (kbd "M-o") 'helm-gtags-find-file-toggle-header-source)
	     ))
	     

