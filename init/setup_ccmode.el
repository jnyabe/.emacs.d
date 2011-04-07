(require 'cc-mode)

(setq c-auto-newline t) 

(defun my-c-mode-common-hook()
  (setq c++tab-always-indent t)
  (setq c-basic-offset 4)
  (setq c-indent-level 4)
  (setq tab-width 4)
  (setq indent-tabs-mode t)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;;(add-hook 'c++-mode-hook 'my-c-mode-common-hook)
;;(add-hook 'cc-mode-hook 'my-c-mode-common-hook)

(setq auto-mode-alist
      (append
       '(("\\.hpp$" . c++-mode)
         ("\\.h$"   . c++-mode)
	 ("\\.cpp$" . c++-mode)
	 ("\\.c$"   . c++-mode)
	 ("\\.cc$"  . c++-mode)
         ) auto-mode-alist))
