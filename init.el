;; emacs configuration
;; source http://www.viget.com/extend/emacs-24-rails-development-environment-from-scratch-to-productive-in-5-minu/

(push "/usr/local/bin" exec-path)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)
(ido-mode t)

;; Use the clipboard, pretty please, so that copy/paste "works"
;; (defun yank-to-x-clipboard ()
;;   (interactive)
;;   (if (region-active-p)
;;         (progn
;;           (shell-command-on-region (region-beginning) (region-end) "xsel -i")
;;           (message "Yanked region to clipboard!")
;;           (deactivate-mark))
;;     (message "No region active; can't yank to clipboard!")))
;;(global-set-key [f8] 'yank-to-x-clipboard)

(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun less-css-mode-hook ()
  (autoload 'less-css-mode "less-css-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

(defun textmate-hook ()
  (global-set-key (kbd "C-x g") 'textmate-goto-file))

(defun solarized-hook ()
  (load-theme 'solarized-dark t))

(require 'cl-lib)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))


(setq el-get-sources
      '((:name ruby-mode 
               :type elpa
               :load "ruby-mode.el"
               :after (progn (ruby-mode-hook)))
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode 
               :type elpa
               :after (progn (css-mode-hook)))
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el"
               :after (progn (textmate-hook)))
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (progn (rvm-use-default)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :after (progn (rhtml-mode-hook)))
        (:name less-css-mode
               :type git
               :url "git://github.com/purcell/less-css-mode.git"
               :features less-css-mode
               :after (progn (less-css-mode-hook)))
        (:name magit
               :after (progn (global-set-key (kbd "C-x C-g") 'magit-status)))
        (:name color-theme :type elpa)
        (:name color-theme-solarized
                :type elpa
                :load "color-theme-solarized.el"
                :after (progn (solarized-hook)))
        (:name yaml-mode 
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :after (progn (yaml-mode-hook)))))

(setq my-packages 
      (append 
       '(org-mode coffee-mode)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

;;(autoload 'js-mode "js-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-hook 'js-mode-hook '(lambda()
                           (setq js-indent-level 2)))

;;enable windmove
(when (fboundp 'windmove-default-keybindings)
  (global-set-key (kbd "C-x a") 'windmove-left)
  (global-set-key (kbd "C-x e") 'windmove-right)
  (global-set-key (kbd "C-x p") 'windmove-up)
  (global-set-key (kbd "C-x n") 'windmove-down))


(defun touch ()
  "Updates mtime of the file for the current buffer"
  (interactive)
  (shell-command (concat "touch " (shell-quote-argument (buffer-file-name))))
  (clear-visited-file-modtime))

(global-set-key (kbd "C-x r") 'touch)
