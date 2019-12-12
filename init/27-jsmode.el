;; (add-hook 'js-mode-hook #'js-auto-format-mode)
;; (add-hook 'js-mode-hook #'add-node-modules-path)
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))
