;; dired-x
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

;; dired+
(require 'dired+)
(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key "\C-o" 'dired-find-file-other-window) 
            ))

;;(require 'openwith)
;;(setq openwith-associations '(("\\.pdf\\'" "open -a /Applications/Preview.app/Contents/MacOS/Preview" (file))))
;;(openwith-mode t)
