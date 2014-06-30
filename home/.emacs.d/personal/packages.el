;;; package --- Installs additional packages
;;; Code:
(prelude-require-package 'rvm)
(require 'rvm)
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; go mode
(setq load-path (cons "/usr/local/go/misc/emacs" load-path))
(require 'go-mode-load)
(setq prelude-whitespace nil)
(setq tab-width 2)
(setq-default tab-width 2)

(defun disable-guru-mode ()
  (guru-mode -1)
)
(add-hook 'prelude-prog-mode-hook 'disable-guru-mode t)

(provide 'packages)
;;; theme.el ends here
