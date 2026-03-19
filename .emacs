(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(setq default-font-size 24)
(setq menu-bar-mode-is-enabled 0)

(cond
 ((eq system-type 'darwin)
  (default-font-size 16))
  (menu-bar-mode-is-enabled 1))

(add-to-list 'default-frame-alist
	     `(font . ,(format "JetBrainsMonoNL NF %d" default-font-size)))

(load-theme 'wombat t t)
(set-face-attribute 'cursor nil :background "yellow1")
(set-face-attribute 'line-number nil :inherit '(shadow default) :foreground "#99968b")
(set-face-attribute 'line-number-current-line nil :inherit 'default :foreground "yellow1" :slant 'normal)
(enable-theme 'wombat)

(tool-bar-mode 0)

(menu-bar-mode menu-bar-mode-is-enabled)

(scroll-bar-mode 0)
(show-paren-mode 1)
(setq inhibit-startup-message t)

(global-set-key (kbd "C-,") 'duplicate-line)

(defun my-minibuffer-setup ()
       (set (make-local-variable 'face-remapping-alist)
          '((default :height 1.1))))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup)

(load-file custom-file)
