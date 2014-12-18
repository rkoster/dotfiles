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

;; groovy mode
(prelude-require-package 'groovy-mode)


(provide 'packages)
;;; theme.el ends here
