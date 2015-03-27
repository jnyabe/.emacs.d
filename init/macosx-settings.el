;;; OSX Setting
;; Switch meta and command      
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; English
 (set-face-attribute 'default nil
             :family "Menlo" ;; font
;;             :height 140)    ;; font size
             :height 180)    ;; font size

;; Japanese
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 
(add-to-list 'face-font-rescale-alist
	     '(".*Hiragino_Mincho_pro.*" . 1.2))


(setq default-input-method "MacOSX")
;;(global-set-key [(control ?+)] (lambda () (interactive) (text-scale-increase 1)))
;;(global-set-key [(control ?-)] (lambda () (interactive) (text-scale-decrease 1)))
;;(global-set-key [(control ?-)] (lambda () (interactive) (text-scale-decrease 0)))

(global-set-key [(control ?+)] (lambda () (interactive) (text-scale-increase 1)))
(global-set-key [(control ?-)] (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key [(control ?-)] (lambda () (interactive) (text-scale-decrease 0)))
