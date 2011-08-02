;;;  -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init-loader.el ---

;; Author: IMAKADO <ken.imakado@gmail.com>
;; Author's blog: http://d.hatena.ne.jp/IMAKADO (japanese)
;; Prefix: init-loader-

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; »È¤¤Êý
;; load-path¤ÎÄÌ¤Ã¤¿¾ì½ê¤ËÃÖ¤¤¤Æ
;; (require 'init-loader)
;; (init-loader-load "/path/to/init-directory")

;;  ¥Ç¥Õ¥©¥ë¥ÈÀßÄê¤Î¾ì¹ç,°Ê²¼¤Î½ç½ø¤Ç°ú¿ô¤ËÅÏ¤·¤¿¥Ç¥£¥ì¥¯¥È¥ê°Ê²¼¤Î¥Õ¥¡¥¤¥ë¤ò¥í¡¼¥É¤¹¤ë.
;; °ú¿ô¤¬¾ÊÎ¬¤µ¤ì¤¿¾ì¹ç¤Ï,ÊÑ¿ô`init-loader-directory'¤ÎÃÍ¤ò»ÈÍÑ¤¹¤ë.¥Ç¥Õ¥©¥ë¥È¤Ï"~/.emacs.d/inits".

;; 1. ¥½¡¼¥È¤µ¤ì¤¿,Æó·å¤Î¿ô»ú¤«¤é»Ï¤Þ¤ë¥Õ¥¡¥¤¥ë. e.x, "00_utils.el" "01_ik-cmd.el" "21_javascript.el" "99_global-keys.el"
;; 2. meadow¤Î¾ì¹ç, meadow ¤«¤é»Ï¤Þ¤ëÌ¾Á°¤Î¥Õ¥¡¥¤¥ë. e.x, "meadow-cmd.el" "meadow-config.el"
;; 3. carbon-emacs¤Î¾ì¹ç, carbon-emacs ¤«¤é»Ï¤Þ¤ëÌ¾Á°¤Î¥Õ¥¡¥¤¥ë. e.x, "carbon-emacs-config.el" "carbon-emacs-migemo.el"
;; 4. window¥·¥¹¥Æ¥à°Ê³°¤Î¾ì¹ç(terminal), nw ¤«¤é»Ï¤Þ¤ëÌ¾Á°¤Î¥Õ¥¡¥¤¥ë e.x, "nw-config.el"

;; ¥Õ¥¡¥¤¥ë¥í¡¼¥É¸å,ÊÑ¿ô`init-loader-show-log-after-init'¤ÎÃÍ¤¬non-nil¤Ê¤é,¥í¥°¥Ð¥Ã¥Õ¥¡¤òÉ½¼¨¤¹¤ë´Ø¿ô¤ò`after-init-hook'¤ØÄÉ²Ã¤¹¤ë.
;; ¥í¥°¤ÎÉ½¼¨¤Ï, M-x init-loader-show-log ¤Ç¤â²ÄÇ½.

(eval-when-compile (require 'cl))
(require 'benchmark)

;;; customize-variables
(defgroup init-loader nil
  "init loader"
  :group 'init-loader)

(defcustom init-loader-directory (expand-file-name "~/.emacs.d/inits")
  "inits directory"
  :type 'directory
  :group 'init-loader)

(defcustom init-loader-show-log-after-init t
  "non-nil¤À¤Èµ¯Æ°»þ¤Ë¥í¥°¥Ð¥Ã¥Õ¥¡¤òÉ½¼¨¤¹¤ë"
  :type 'boolean
  :group 'init-loader)

(defcustom init-loader-default-regexp "\\(?:^[[:digit:]]\\{2\\}\\)"
  "µ¯Æ°»þ¤ËÆÉ¤ß¹þ¤Þ¤ì¤ëÀßÄê¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½.
¥Ç¥Õ¥©¥ë¥È¤ÏÆó·å¤Î¿ô»ú¤«¤é»Ï¤Þ¤ë¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½.
e.x, 00_hoge.el, 01_huga.el ... 99_keybind.el"
  :type 'regexp
  :group 'init-loader )

(defcustom init-loader-meadow-regexp "^meadow-"
  "meadow »ÈÍÑ»þ¤ËÆÉ¤ß¹þ¤Þ¤ì¤ëÀßÄê¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½"
  :group 'init-loader
  :type 'regexp)

(defcustom init-loader-carbon-emacs-regexp "^carbon-emacs-"
  "carbon-emacs »ÈÍÑ»þ¤ËÆÉ¤ß¹þ¤Þ¤ì¤ëÀßÄê¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½"
  :group 'init-loader
  :type 'regexp)

(defcustom init-loader-cocoa-emacs-regexp "^cocoa-emacs-"
  "cocoa-emacs »ÈÍÑ»þ¤ËÆÉ¤ß¹þ¤Þ¤ì¤ëÀßÄê¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½"
  :group 'init-loader
  :type 'regexp)

(defcustom init-loader-nw-regexp "^nw-"
  "no-window´Ä¶­¤Ç¤Îµ¯Æ°»þ¤ËÆÉ¤ß¹þ¤Þ¤ì¤ëÀßÄê¥Õ¥¡¥¤¥ë¤Ë¥Þ¥Ã¥Á¤¹¤ëÀµµ¬É½¸½"
  :group 'init-loader
  :type 'regexp)

;;; Code
(defun* init-loader-load (&optional (init-dir init-loader-directory))
  (let ((init-dir (init-loader-follow-symlink init-dir)))
    (assert (and (stringp init-dir) (file-directory-p init-dir)))
    (init-loader-re-load init-loader-default-regexp init-dir t)
    ;; meadow
    (and (featurep 'meadow)
         (init-loader-re-load init-loader-meadow-regexp init-dir))
    ;; carbon emacs
    (and (featurep 'carbon-emacs-package)
         (init-loader-re-load init-loader-carbon-emacs-regexp init-dir))
    ;; cocoa emacs
    (and (equal window-system 'ns)
         (init-loader-re-load init-loader-cocoa-emacs-regexp init-dir))
    ;; no window
    (and (null window-system)
         (init-loader-re-load init-loader-nw-regexp init-dir))

    (when init-loader-show-log-after-init
      (add-hook  'after-init-hook 'init-loader-show-log))))

(defun init-loader-follow-symlink (dir)
  (cond ((file-symlink-p dir)
         (expand-file-name (file-symlink-p dir)))
        (t (expand-file-name dir))))

(lexical-let (logs)
  (defun init-loader-log (&optional s)
    (if s (and (stringp s) (push s logs)) (mapconcat 'identity (reverse logs) "\n"))))

(lexical-let (err-logs)
  (defun init-loader-error-log (&optional s)
    (if s (and (stringp s) (push s err-logs)) (mapconcat 'identity (reverse err-logs) "\n"))))

(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         (init-loader-error-log (error-message-string e)))))))

(defun init-loader--re-load-files (re dir &optional sort)
    (loop for el in (directory-files dir t)
          when (string-match re (file-name-nondirectory el))
          collect (file-name-nondirectory el) into ret
          finally return (if sort (sort ret 'string<) ret)))

(defun init-loader-show-log ()
  "return buffer"
  (interactive)
  (let ((b (get-buffer-create "*init log*")))
    (with-current-buffer b
      (erase-buffer)
      (insert "------- error log -------\n\n"
              (init-loader-error-log)
              "\n\n")
      (insert "------- init log -------\n\n"
              (init-loader-log)
              "\n\n")
      ;; load-path
      (insert "------- load path -------\n\n"
              (mapconcat 'identity load-path "\n"))
      (goto-char (point-min)))
    (switch-to-buffer b)))


;;;; Test
(defvar init-loader-test-files
  '("00_utils.el"
    "23_yaml.el"
    "01_ik-cmd.el"
    "96_color.el"
    "20_elisp.el"
    "21_javascript.el"
    "25_perl.el"
    "98_emacs-config.el"
    "99_global-keys.el"
    "carbon-emacs-config.el"
    "carbon-emacs-migemo.el"
    "nw-config.el"
    "emacs-migemo.el"
    "meadow-cmd.el"
    "meadow-config.el"
    "meadow-gnuserv.el"
    "meadow-shell.el"
    "meadow-w32-symlinks.el"))

(dont-compile
  (when (fboundp 'expectations)
    (expectations 
      (desc "init-loader--re-load-files")
      (expect  '("00_utils.el" "01_ik-cmd.el" "20_elisp.el" "21_javascript.el" "23_yaml.el" "25_perl.el" "96_color.el" "98_emacs-config.el" "99_global-keys.el")
        (stub directory-files => init-loader-test-files)
        (init-loader--re-load-files init-loader-default-regexp "" t))
      (expect  '("meadow-cmd.el" "meadow-config.el" "meadow-gnuserv.el" "meadow-shell.el" "meadow-w32-symlinks.el")
        (stub directory-files => init-loader-test-files)
        (init-loader--re-load-files init-loader-meadow-regexp "" t))

      (expect  '("carbon-emacs-config.el" "carbon-emacs-migemo.el")
        (stub directory-files => init-loader-test-files)
        (init-loader--re-load-files init-loader-carbon-emacs-regexp "" t))
      (expect  '("nw-config.el")
        (stub directory-files => init-loader-test-files)
        (init-loader--re-load-files init-loader-nw-regexp "" t))
      ;; ´Ä¶­°ÍÂ¸
      (desc "follow symlink")
      (expect "c/.emacs.d/inits"
        (file-relative-name (file-symlink-p "~/tmp/el-inits"))) ; symlink
      (desc "init-loader-follow-symlink")
      (expect "c/.emacs.d/inits"
        (file-relative-name (init-loader-follow-symlink "~/tmp/el-inits")))
      (expect "c/.emacs.d/inits"
        (file-relative-name (init-loader-follow-symlink "~/tmp/el-inits")))
      )))

(provide 'init-loader)

