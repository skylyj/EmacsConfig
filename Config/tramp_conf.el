(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-default-user "lianyijiang" tramp-default-host "theoden")
(setq password-cache-expiry 36000)
(add-to-list 'tramp-remote-path "/usr/bin/")
