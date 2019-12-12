;; jar file configuration
(setq plantuml-jar-path "d:/cygwin/home/yabe/lib/jar/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

;; executable configuration
(setq plantuml-executable-path "d:/cygwin/home/yabe/bin/plantuml.bat")
(setq plantuml-default-exec-mode 'executable)

;; Enable major mode
(add-to-list 'auto-mode-alist '("\.puml$" . plantuml-mode))


(setq plantuml-java-options "")
(setq plantuml-output-type "png")
(setq plantuml-options "-charset UTF-8")
