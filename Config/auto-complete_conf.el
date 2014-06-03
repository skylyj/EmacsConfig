(require 'auto-complete)
(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/MyEmacs/Extensions/ac-dict/")
(add-to-list 'ac-user-dictionary-files "~/Preferences/Emacs/Config/my_ac_dict")

(ac-config-default)
(global-auto-complete-mode t)
(global-set-key "\363a" (quote ac-start))
(global-set-key [(control shift g)] 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;这样我们的补全就完全在ctrl 的模式下完成了 C-p C-n C-m or C-i M-s-a
					;(global-set-key [f7] 'ac-start)
(setq ac-auto-start 3);;这个是为了和我们的latex 中的CDlatex mode 躲开
					; (define-key ac-complete-mode-map [f7] 'ac-stop)
;;这个是指定在那个地方可以让ac失效
(setq ac-disable-faces nil)
(set-default 'ac-sources
	     '(ac-source-abbrev
	       ac-source-functions
	       ;; ac-source-yasnippet
	       ac-source-variables
	       ac-source-dictionary 
	       ac-source-symbols
	       ac-source-words-in-buffer
	       ac-source-words-in-all-buffer
	       ac-source-imenu
	       ac-source-files-in-current-dir
	       ac-source-filename))
;;指定那些mode中可以使用ac，
(setq ac-modes
      (append ac-modes '(org-mode objc-mode jde-mode sql-mode magit-mode yaml-mode python-mode
                                  magit-log-edit-mode
				  mew-header-mode
				  mew-draft-mode
				  mew-edit-mode
				  latex-mode
				  bibtex-mode
				  ;; 下面的 message-mode 是对于gnus 的Message mode来说的
				  ;; message-mode
				  svn-log-edit-mode
				  change-log-mode text-mode
				  makefile-gmake-mode makefile-bsdmake-mode
				  autoconf-mode makefile-automake-mode)))
