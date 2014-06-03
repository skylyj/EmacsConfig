(require 'multi-term)
(setq multi-term-program "/bin/bash")
(setq multi-term-buffer-name "term")
(global-set-key "\C-x." 'multi-term)
(global-set-key "\C-x," 'multi-term-dedicated-open)
(setq multi-term-dedicated-select-after-open-p t)
(add-hook 'term-mode-hook (lambda ()
                            (define-key term-raw-map (kbd "C-y") 'term-paste)))
(setq term-default-fg-color (face-foreground 'default))
(setq term-default-bg-color (face-background 'default))
