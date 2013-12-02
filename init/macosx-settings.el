;;; OSX Setting
;; Switch meta and command      
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; English
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
             :height 120)    ;; font size

;; Japanese
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

