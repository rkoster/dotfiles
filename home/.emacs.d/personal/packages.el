;;; package --- Installs additional packages
;;; Code:
;; rvm
(prelude-require-package 'rvm)
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; go mode
(defun my-go-mode-hook ()
  (setq tab-width 2)
  (setq-default tab-width 2)
  (setq whitespace-line-column 120)
  (load-file "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el"))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; js2-mode hook
(defun my-js2-mode-hook ()
  (setq js2-basic-offset 2))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

;; groovy mode
(prelude-require-package 'groovy-mode)

;; floobits
(prelude-require-package 'floobits)

(provide 'packages)
;;; theme.el ends here
