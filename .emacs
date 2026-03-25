(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq completion-show-help nil)

(setq default-font-size 20)
(setq menu-bar-mode-is-enabled 0)

(cond
 ((eq system-type 'darwin)
  (setq default-font-size 16)
  (setq menu-bar-mode-is-enabled 1)))

(add-to-list 'default-frame-alist
             `(font . ,(format "JetBrainsMonoNL NF %d" default-font-size)))

(set-face-attribute 'line-number nil :inherit '(shadow default))
(set-face-attribute 'line-number-current-line nil :inherit '(default) :slant 'normal)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(savehist-mode 1)

(global-whitespace-mode)
(setq whitespace-style '(face tabs tab-mark))
(setq-default show-trailing-whitespace t)
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))

(setf completion-styles '(basic flex)
      completion-auto-select t
      completion-auto-help 'visible
      completions-sort 'historical
      completions-max-height 20
      completion-ignore-case t)

(setq dabbrev-case-fold-search t)
(setq dabbrev-case-replace nil) ;; the expansion is always copied verbatim
(setq completion-at-point-functions '(elisp-completion-at-point comint--complete-file-name-data)
      comint-completion-addsuffix nil)

(require 'move-text)
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-p") 'move-text-up)

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)

(global-set-key (kbd "C-,") 'duplicate-line)
(global-set-key (kbd "C-c w") 'whitespace-mode)

(defun my-minibuffer-setup ()
       (set (make-local-variable 'face-remapping-alist)
          '((default :height 1.1))))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup)

(load-file custom-file)
