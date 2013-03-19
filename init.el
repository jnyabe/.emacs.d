;;  Path setting 
(setq load-path
      (append 
       (list
	(expand-file-name "~/.emacs.d")
	(expand-file-name "~/.emacs.d/lisp/init")
	(expand-file-name "~/.emacs.d/lisp")
	(expand-file-name "~/.emacs.d/init")
	(expand-file-name "~/.emacs.d/auto-install")
	(expand-file-name "~/.emacs.d/plugins")
	(expand-file-name "~/.emacs.d/lisp/skk")
	"/Applications/Emacs.app/Contents/Resources/site-lisp"
	"/Applications/Emacs.app/Contents/Resources/lisp"
        (expand-file-name "/usr/local/share/emacs/site-lisp/mew")
	) load-path ))

;; OS depend settings
(cond ((string= window-system "ns")
       (load "macosx-settings"))
      ((string= window-system "w32")
       (load "windows-settings"))
      ((string= window-system "x")
       (load "linux-settings"))
      ((not window-system)
       (load "console-settings")))

;; Machine depend settings
(cond
 ((string= system-name "CARLISLE")
  (load "office-settings")))
 

(setq Info-additional-directory-list
      (list (expand-file-name "~/lib/info")))

;; Disable startup-message
(setq inhibit-startup-message t)


;; Key Binding
(define-key global-map "\C-h" 'delete-backward-char) 
(define-key global-map "\M-?" 'help-for-help)




;; Color setting 
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(set-foreground-color "white")
(set-background-color "#333333")
(set-cursor-color     "green")
(setq transient-mark-mode t)

;; Disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
;;(menu-bar-mode -1)


(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/init")

;;(load "setup_skk") ;; SKK 
;;(load "setup_fontlock") ;; fontlock
;;(load "setup_ccmode") ;; cc-mode
;;(load "setup_matlab") ;; matlab-mode
;;(load "setup_navi2ch") ;; navi2ch
;;(load "setup_gtags") ;; gtag
;;(load "setup_gauche") ;; Gauche
;;(load "setup_setnu") ;; setnu
;;(load "setup_lookup")
;;(load "setup_mew")
;;(load "setup_anything") ;; anything
;;(load "setup_autocomplete") ;; autocomplete
;;(load "setup_yasnippet.el") ;; yasnisppet
;;(load "setup_moccur") ;; moccur
;;(load "setup_wdired") ;; wdired
;;(load "setup_autoinstall") ;; auto-install
;;(load "setup_auto_async_byte_compile") ;; auto-async-byte-compile

;;(require 'auto-complete-extension)

(load "yasima")
;;(set-language-environment "Japanese")
(add-hook 'set-language-environment-hook 
	  (lambda ()
	    (when (equal "ja_JP.UTF-8" (getenv "LANG"))
	      (setq default-process-coding-system '(utf-8 . utf-8))
	      (setq default-file-name-coding-system 'utf-8))
	    (when (equal "Japanese" current-language-environment)
	      (setq buffer-file-coding-system' 'utf-8))))


(set-language-environment "Japanese")
;; Language Setting (Japanese)

;(set-default-coding-systems 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)

(setq visible-bell t)
;; (cd "~/")

