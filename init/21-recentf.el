(when (require 'recentf nil t)
  (setq recentf-max-saved-itmes 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
	(run-with-idle-timer 30 t 'recent-save-list))
  (recentf-mode 1)
  (require 'recentf-ext))
