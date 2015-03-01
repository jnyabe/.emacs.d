(require 'flymake)

(setq flymake-gui-warnings-enabled nil)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.cc$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.hpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(defun flymake-show-and-sit ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (progn
    (let* ((line-no (flymake-current-line-no) )
           (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (full-file
                  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))
  (sit-for 60.0))
(global-set-key "\C-ce" 'flymake-show-and-sit)

(custom-set-faces
 '(flymake-errline ((((class color)) (:background "RoyalBlue4"))))
 '(flymake-warnline ((((class color)) (:background "SlateBlue4")))))

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))
