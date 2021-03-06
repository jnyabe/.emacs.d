;;;
;;; Lookup Setup Example
;;;

(setq load-path
      (append '("/usr/local/share/emacs/site-lisp/")
	      load-path))
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

(define-key ctl-x-map "l" 'lookup)              ; C-x l - lookup
(define-key ctl-x-map "y" 'lookup-region)       ; C-x y - lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern)   ; C-x C-y - lookup-pattern

(setq lookup-search-agents '((ndtp "localhost")))