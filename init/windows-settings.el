;;; Setting for windows

(setq exec-path (cons "d:\\cygwin\\bin" exec-path))
(setq exec-path (cons "d:\\cygwin\\usr\\local\\bin" exec-path))

;; Shell-mode
(setq explicit-shell-file-name "zsh.exe")
(setq shell-file-name "sh.exe")
(setq shell-command-switch "-c")
(modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan))



;; Cygwin-mount
;; (load "init_cygwin_mount")
;; (require 'cygwin-mount)
;; (cygwin-mount-activate)

;;; Font
(set-frame-font "VL $B%4%7%C%/(B-14")
(set-face-attribute 'fixed-pitch    nil :family "VL $B%4%7%C%/(B")
(set-face-attribute 'variable-pitch nil :family "VL $B%4%7%C%/(B")

