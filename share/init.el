;; Path setting
(setq load-path 
      (append 
       (list
	(expand-file-name "~/.emacs.d")
	(expand-file-name "~/.emacs.d/init")
	(expand-file-name "~/.emacs.d/lisp")
	(expand-file-name "~/.emacs.d/lisp/skk")
	(expand-file-name "~/.emacs.d/auto-install")
	(expand-file-name "/Applications/Emacs.app/Contents/Resources/site-lisp")
	(expand-file-name "/usr/local/share/emacs/site-lisp/mew")
	) load-path))

;; Disable startup-message
(setq inhibit-startup-message t)

;; Language Setting (Japanese)
(set-language-environment "Japanese")
;(set-default-coding-systems 'euc-jp)
;(set-buffer-file-coding-system 'euc-jp-unix)
;(set-terminal-coding-system 'euc-jp)
;(set-keyboard-coding-system 'euc-jp)

(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; font

;; Color setting 
(set-foreground-color "white")
(set-background-color "#333333")
(set-cursor-color     "green")
(setq transient-mark-mode t)
(set-frame-parameter (selected-frame) 'alpha '(85 50))

;; Disable bars
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(setq scroll-bar-mode-explicit nil)
(setq tool-bar nil)
(setq menu-bar nil)

;; fontlock-mode
;;(load "fontlock_setup.el")
;; gtag-mode
;;(load "setup_gtags.el")
;; cc-mode
;;(load "setup_ccmode.el")
;;(load "ccmodesetup.el")

;; Mailer (mew)
;;(load "setup_mew.el")



;; Dictionary (sdic)
;;(load "sdic_setup.el")

;; Dictionary (lookup)
;;(load "setup_lookup.el")

;; bbs (Navi2ch)
;;(load "navi2ch_setup.el")

;; bsfilter for mew

;; gtags
;;(load "gtags_setup.el")

;; MATLAB mode

;; 
;;(load "matlab_setup.el")

;; Gauche mode
;;(load "setup_gauche.el")

(setq Info-default-directory-list
      (cons "~/lib/info" Info-default-directory-list))



;; wb-line-number
;; (setq truncate-partial-width-windows nil)
;; (set-scroll-bar-mode nil)
;; (setq wb-line-number-scroll-bar t)
;; (require 'wb-line-number)
;; (wb-line-number-toggle)

;; setnu plus
;;(load "setnu+.el")
(load "setup_skk") 
(load "setup_mew") 
(load "setup_fontlock") 
(load "setup_ccmode")
(load "setup_anything") 
(load "setup_autoinstall")
(load "setup_yasnippet")
(load "setup_autocomplete")
(load "setup_wdired")
(load "setup_moccur")
(load "setup_recentf")
(load "setup_twitter")
(load "setup_lookup")

(load "yasima")