;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tuareg-mode
(setq auto-mode-alist (cons '("\\.ml[iylp]?$" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(require 'tuareg)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;;(setenv "PATH"
;; (concat '"/Users/tmaeda/.opam/4.00.1+annot/bin:" (getenv "PATH")))
;(setq ocamlspot-command "/usr/local/bin/ocamlspot")

(setenv "PATH" (concat '"/usr/local/bin:" (getenv "PATH")))
(setq ocamlspot-command "/usr/local/bin/ocamlspot")
(setq tuareg-interactive-program "/usr/local/bin/ocaml")
(setq omake-program-path "/usr/local/bin/omake")
;(setq omake-program-arguments "-P -w --verbose")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake
;; cf) http://d.hatena.ne.jp/osiire/20120613
(require 'flymake)
(push '("File \"\\(.*\\)\", line \\([0-9]+\\), characters \\([0-9]+\\)--?\\([0-9]+\\):\\(.*\\)" 1 2 3 5) flymake-err-line-patterns)
(push '("\\.ml\\'" flymake-ocaml-init) flymake-allowed-file-name-masks)
(defun flymake-ocaml-init ()
  (list "/bin/bash" (list "-c" (format "%s -s 2>&1 | tr -d \"\\n\" | sed -Ee 's/[[:space:]]+/ /g'" omake-program-path))))
(custom-set-faces
 '(flymake-errline ((((class color)) (:background "LightYellow" :underline "OrangeRed"))))
 '(flymake-warnline ((((class color)) (:background "LightBlue2" :underline "Yellow")))))

;; cf) http://d.hatena.ne.jp/khiker/20070720/emacs_flymake
(defun credmp/flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))
(defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message activate)
  (credmp/flymake-display-err-minibuf))
(defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message activate)
  (credmp/flymake-display-err-minibuf))


(require 'ocamlspot)

(defun run-ocamlspot-type ()
  (if (eq major-mode 'tuareg-mode)
      (ocamlspot-type)
      )
  )

(defvar ocamlspot-type-timer nil) 
(defun toggle-ocamlspot-type-timer ()
  (interactive)
  (if ocamlspot-type-timer
      (progn
        (anything-new-timer 'ocamlspot-type-timer nil)
        (message "auto ocamlspot-type disabled")
        )
      (anything-new-timer 'ocamlspot-type-timer
                          (run-with-idle-timer 0.5 t 'run-ocamlspot-type)
                          )
      (message "auto ocamlspot-type enabled")

    )

  )

(defun tuareg-mode-init ()
  ;; indentation rules
  (setq tuareg-lazy-= t)
  (setq tuareg-lazy-paren t)
  (setq tuareg-in-indent 0)
  (setq tuareg-electric-indent nil)
  (setq tuareg-leading-star-in-doc t)
  (setq tuareg-with-indent 0)

  ;    (setq tuareg-library-path "/usr/local/lib/ocaml/")
  (setq tuareg-library-path "/Users/tmaeda/.opam/4.00.1+annot/lib")

  ;; turn on auto-fill minor mode
  (auto-fill-mode 1)

  ;; Sym-Lock customization only
  ;; turn off special face under mouse
  (if (featurep 'sym-lock)   
      (setq sym-lock-mouse-face-enabled nil))

  ;; ocamlspot and other keys
  (local-set-key "\C-c;" 'ocamlspot-query)
  (local-set-key "\C-c:" 'ocamlspot-query-interface)
  (local-set-key "\C-c'" 'ocamlspot-query-uses)
;    (local-set-key "\C-c\C-t" 'ocamlspot-type)
  (local-set-key "\C-c\C-i" 'ocamlspot-xtype)
  (local-set-key "\C-c\C-y" 'ocamlspot-type-and-copy)
  (local-set-key "\C-cx" 'ocamlspot-expand)
  (local-set-key "\C-c\C-u" 'ocamlspot-use)
  (local-set-key "\C-ct" 'caml-types-show-type)
  (local-set-key "\C-cp" 'ocamlspot-pop-jump-stack)
  (local-set-key "\C-c\C-t" 'toggle-ocamlspot-type-timer)

  (flymake-mode-on)
  )

(add-hook 'tuareg-mode-hook 'tuareg-mode-init)
(setq which-func-modes (append which-func-modes '(tuareg-mode)))

;; You can also change overlay colors as follows:
; (set-face-background 'ocamlspot-spot-face "#660000")
; (set-face-background 'ocamlspot-tree-face "#006600")