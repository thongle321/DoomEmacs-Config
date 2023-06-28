(setq user-full-name "Thong Le"
      user-mail-address "thongle857@gmail.com")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 15 :weight 'semi-bold))
(setq doom-theme 'doom-one)



(setq org-directory "C:/Users/Moderator/Documents/Org/")
(setq display-line-numbers-type 'relative)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

;; Enable C++ mode for .cpp and .h files
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
