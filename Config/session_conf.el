(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;If you want to use both desktop and session, use:
(setq desktop-globals-to-save '(desktop-missing-file-warning))
