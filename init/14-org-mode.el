;; setup for org-mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-ca" 'org-agenda)

(setq org-hide-leading-stars t)


;; capture templates
(setq org-capture-templates
      '(("p" "Project Task" entry (file+headline (expand-file-name "~/work/project.org") "Inbox")
	 "** TOD %?¥n    %i¥n    %a¥n     %T")
	("m" "memo" entry (file (expand-file-name "~/memo.org"))
	 "* %?¥n    %i¥n    %a¥n    %T")))
;; agenda
(setq org-agenda-files (list (expand-file-name "~/work/project")))


