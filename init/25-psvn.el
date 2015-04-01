(require 'psvn)

(setq svn-status-verbose nil)
(setq svn-status-hide-unmodified t)
(setq svn-status-hide-unknown t)

(setq ediff-split-window-function 'split-window-horizontally)
(setq svn-status-ediff-delete-temporary-files t)
;; language setting
(setq process-coding-system-alist '(("svn" . utf-8)))
(setq default-file-name-coding-system 'utf-8)
(setq svn-status-svn-file-coding-system 'utf-8)
(setq svn-status-svn-process-coding-system 'utf-8)

