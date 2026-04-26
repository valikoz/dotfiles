(setq lisp-dir (expand-file-name "lisp" user-emacs-directory))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" lisp-dir))
(package-initialize)

;; Set up load path
(add-to-list 'load-path lisp-dir)

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq completion-show-help nil)
(setq compilation-scroll-output 1)
(setq use-short-answers t)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(savehist-mode 1)
(menu-bar-mode 0)
(xterm-mouse-mode 1)

(setq default-font-size 20)

(cond
 ((eq system-type 'darwin)
  (setq default-font-size 16)
  (cond ((eq initial-window-system 'ns) (menu-bar-mode 1)))
  ))

(add-to-list 'default-frame-alist
             `(font . ,(format "JetBrainsMonoNL NF %d" default-font-size)))

(set-face-attribute 'line-number nil :inherit '(shadow default))
(set-face-attribute 'line-number-current-line nil :inherit '(default) :slant 'normal)

(setq-default show-trailing-whitespace t)
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))

(setf completion-styles '(basic flex)
      completion-auto-select 'second-tab
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

(global-set-key (kbd "C-,") 'duplicate-line)
(global-set-key (kbd "C-c w") 'whitespace-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)

(defun my-minibuffer-setup ()
       (set (make-local-variable 'face-remapping-alist)
          '((default :height 1.1))))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup)

;; Load emacs Custom-settings
(load-file custom-file)
