(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(set-frame-font "JetBrainsMonoNL NF 16")

(load-theme 'wombat t t)
(set-face-attribute 'cursor nil :background "yellow1")
(set-face-attribute 'line-number nil :inherit '(shadow default) :foreground "#99968b")
(set-face-attribute 'line-number-current-line nil :inherit 'default :foreground "yellow1" :slant 'normal)
(enable-theme 'wombat)

;; (tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(setq inhibit-startup-message t)

(global-set-key (kbd "C-,") 'duplicate-line)

(load-file custom-file)





