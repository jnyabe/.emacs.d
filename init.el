;;  Path setting 
(setq load-path
      (append 
       (list
	(expand-file-name "~/.emacs.d/init")
	(expand-file-name "~/.emacs.d/lisp/init")
	(expand-file-name "~/.emacs.d/lisp")
	"/Applications/Emacs.app/Contents/Resources/site-lisp"
	"/Applications/Emacs.app/Contents/Resources/lisp"
	) load-path ))


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
;;(set-foreground-color "white")
;;(set-background-color "#333333")
;;(set-cursor-color     "green")
;;(setq transient-mark-mode t)

;; Disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)



;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(add-to-list 'package-archives 
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)


;; Packages to install from MELPA
(defvar my/packages
  '(
;;    magit
    ag
;;  anything
    auto-complete
    org
    init-loader
    json-mode
    migemo
;;    psvn
    py-autopep8
    pydoc-info
    sqlite
    scala-mode
    ssh
    yaml-mode
    yasnippet
    recentf-ext
    markdown-mode
    open-junk-file
    tuareg
    powerline
    zenburn-theme
    helm
    helm-ag
    helm-c-moccur
    helm-descbinds
    helm-gtags
    wgrep-helm
    helm-ls-git
    ruby-mode
    go-mode
    csharp-mode
;;    flymake-go
    wdired
    haskell-mode
    mode-icons
;;    cygwin-mount
    markdown-mode
    )
  "A list of package to install from MELPA at launch.")

;; Install Melpa packages
(dolist (package my/packages)
  (when (or (not (package-installed-p package)))
    (package-install package)))

;; el-get
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync '(
;;                 howm
;;                 ddskk
;;                 navi2ch
;;                 ))

;; Init-Loader
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/init")



;; (load "yasima")
;;(set-language-environment "Japanese")
(add-hook 'set-language-environment-hook 
	  (lambda ()
	    (when (equal "ja_JP.UTF-8" (getenv "LANG"))
	      (setq default-process-coding-system '(utf-8 . utf-8))
	      (setq default-file-name-coding-system 'utf-8))
	    (when (equal "Japanese" current-language-environment)
	      (setq buffer-file-coding-system' 'utf-8))))


;; OS depend settings
(cond ((string= window-system "ns")
       (load "macosx-settings"))
      ((string= window-system "w32")
       (load "windows-settings"))
      ((string= window-system "x")
       (load "linux-settings"))
      ((not window-system)
       (load "console-settings")))

;;(set-language-environment "Japanese")
;; Language Setting (Japanese)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)

(setq visible-bell t)
;; (cd "~/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-plantuml plantuml-mode add-node-modules-path js-auto-format-mode zenburn-theme yasnippet yaml-mode wgrep-helm tuareg ssh sqlite scala-mode recentf-ext pydoc-info py-autopep8 psvn powerline open-junk-file mode-icons migemo markdown-mode json-mode init-loader helm-ls-git helm-gtags helm-descbinds helm-c-moccur helm-ag haskell-mode go-mode csharp-mode auto-complete ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-error ((((class color)) (:background "RoyalBlue4"))))
 '(flymake-warning ((((class color)) (:background "SlateBlue4")))))
(server-start)

(put 'set-goal-column 'disabled nil)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

