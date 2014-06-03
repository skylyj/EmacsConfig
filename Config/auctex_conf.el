;;auctex
(cond ((equal system-type 'gnu/linux)
       (set-default-font "Monospace-18"))
      ((equal system-type 'darwin)
        (require 'reftex)
        (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

        (setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
        (setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))
        (load "auctex.el" nil t t)
        (load "preview-latex.el" nil t t)))
