;;; package --- Installs additional packages
;;; Code:
;; rvm
(prelude-require-package 'rvm)
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; elm mode
(prelude-require-package 'elm-mode)
(prelude-require-package 'flycheck-elm)
(defun my-elm-mode-hook ()
  (add-to-list 'company-backends 'company-elm)
  (setq elm-tags-on-sav t)
  (flycheck-mode)
  (setq elm-format-on-save t))
(add-hook 'elm-mode-hook 'my-elm-mode-hook)
(add-hook 'flycheck-mode-hook 'flycheck-elm-setup)

;; go mode
(defun my-go-mode-hook ()
  (setq tab-width 2)
  (setq-default tab-width 2)
  (setq whitespace-line-column 120)
  (load-file "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el"))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; lua-mode
(prelude-require-package 'lua-mode)

;; js2-mode hook
(defun my-js2-mode-hook ()
  (setq js2-basic-offset 2))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

;; groovy mode
(prelude-require-package 'groovy-mode)

;; wgrep and iedit
(prelude-require-package 'wgrep)
(prelude-require-package 'iedit)

;; floobits
(prelude-require-package 'floobits)

(provide 'packages)
;;; theme.el ends here
