(setq user-full-name "Thong Le"
      user-mail-address "thongle857@gmail.com")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 15 :weight 'semi-bold))
(setq doom-theme 'doom-one)

(setq org-directory "C:/Users/Moderator/Documents/Org/")
(setq display-line-numbers-type nil)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))
(global-subword-mode 1)

;; Enable C++ mode for .cpp and .h files
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-hook! 'org-babel-pre-tangle-hook
  (when (file-directory-p "snippets")
    (require 'async)
    (async-start
     (lambda ()
       (delete-directory "snippets" t (not (null delete-by-moving-to-trash))))
     (lambda (result)
       (print! "Delete snippets dir got: " result)))))

(defun doom/reload-without-sync ()
  (interactive)
  (mapc #'require (cdr doom-incremental-packages))
  (doom-context-with '(reload modules)
    (doom-run-hooks 'doom-before-reload-hook)
    (doom-load (file-name-concat doom-user-dir doom-module-init-file) t)
    (with-demoted-errors "PRIVATE CONFIG ERROR: %s"
      (general-auto-unbind-keys)
      (unwind-protect
          (startup--load-user-init-file nil)
        (general-auto-unbind-keys t)))
    (doom-run-hooks 'doom-after-reload-hook)
    (message "Config successfully reloaded!")))

(define-key! help-map "rc" #'doom/reload-without-sync)

(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings "
  (when (and (eq major-mode 'comint-mode)
             (string-match "finished" string)
             (not
              (with-current-buffer buffer
                (search-forward "warning" nil t))))
    (run-with-timer 1 nil
                    (lambda (buf)
                      (let ((window (get-buffer-window buf)))
                        (when (and (window-live-p window)
                                   (eq buf (window-buffer window)))
                          (delete-window window))))
                    buffer)))

(add-hook 'compilation-finish-functions #'bury-compile-buffer-if-successful)
