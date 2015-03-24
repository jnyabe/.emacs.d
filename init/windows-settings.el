;;; Setting for windows

(setq exec-path (cons "c:\\cygwin\\bin" exec-path))
(setq exec-path (cons "c:\\cygwin\\usr\\local\\bin" exec-path))

;; Shell-mode
(setq explicit-shell-file-name "zsh.exe")
(setq shell-file-name "sh.exe")
(setq shell-command-switch "-c")
(modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan))



;; Cygwin-mount
;; (load "init_cygwin_mount")

;;; Font
(set-frame-font "VL ゴシック-12")
(set-face-attribute 'fixed-pitch    nil :family "VL ゴシック")
(set-face-attribute 'variable-pitch nil :family "VL ゴシック")
