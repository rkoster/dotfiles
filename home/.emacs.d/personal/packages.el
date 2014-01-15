;;; package --- Installs additional packages
;;; Code:
(prelude-require-package 'rvm)
(require 'rvm)
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))
(provide 'packages)
;;; theme.el ends here
