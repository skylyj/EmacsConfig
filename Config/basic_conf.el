(global-font-lock-mode 1)               ; 开启语法高亮。
(auto-compression-mode 1)               ; 打开压缩文件时自动解压缩。
(column-number-mode 1)                  ; 显示列号。
(blink-cursor-mode -1)                  ; 光标不要闪烁。
(display-time-mode 1)                   ; 显示时间。
(show-paren-mode 1)                     ; 高亮显示匹配的括号。
(icomplete-mode 1)            ; 给出用 M-x foo-bar-COMMAND 输入命令的提示。
(setq x-select-enable-clipboard t)  ;用来和系统共享剪贴板
(setq confirm-kill-emacs 'yes-or-no-p)
(transient-mark-mode t) 
(line-number-mode t) 
(setq-default kill-whole-line t) ;; 在行首 C-k 时，同时删除该行。
(fset 'yes-or-no-p 'y-or-n-p) ;;改变 Emacs 固执的要你回答 yes 的行为。按y或空格键表示yes,n表示no。 
(setq auto-image-file-mode t) 

;; (set-default-font "Menlo Regular-21") 

(cond ((equal system-type 'gnu/linux)
       (set-default-font "Monospace-18"))
      ((equal system-type 'darwin)
       (tool-bar-mode -1) 
       (set-frame-font "Menlo-21")
       (set-fontset-font
        (frame-parameter nil 'font)
        'han
        (font-spec :family "Hiragino Sans GB" ))))

(set-face-attribute 'mode-line nil :box nil :height 195)

(set-foreground-color "Wheat")
(set-background-color "DarkSlateGray")
(set-cursor-color "Orchid")
(set-mouse-color "Orchid")

(setq mouse-yank-at-point t) ;;鼠标中键黏贴的时候使用光标定位
(setq inhibit-startup-message t) ;; 不显示 Emacs 的开始画面。 
(setq default-major-mode 'text-mode) ;; 任意的打开一个新文件时，缺省使用 text-mode。
(setq next-line-add-newlines nil) ;; Emacs 21 中已经是缺省设置。按 C-n 或向下键时不添加新行。 
(setq require-final-newline t) ;; 存盘的时候，要求最后一个字符时换行符。 
(setq suggest-key-bindings 1) ;; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。 
(setq line-number-display-limit 1000000) ;; 当行数超过一定数值，不再显示行号。 
(setq kill-ring-max 200) ;; kill-ring 最多的记录个数。 
(setq ring-bell-function 'ignore) ;; 彻底的消除 ring-bell 的效果。 
(setq track-eol t) ;; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq bookmark-save-flag 1) ;; 每当设置书签的时候都保存书签文件，否则只在你退出 Emacs 时保存。 
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs") ;; 缺省的定义缩写的文件。 
(setq bookmark-default-file "~/.emacs.d/.emacs.bmk") ;; 缺省书签文件的路径及文件名。 
(setq mark-even-if-inactive t)
(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files
(setq max-mini-window-height 0.0001)

(global-set-key "\C-xgf" 'find-file-at-point)
(global-set-key "\C-z" 'set-mark-command)
(global-set-key "\M-sr" 'query-replace-regexp)
(global-set-key "\M-slr" 'revert-buffer)
(global-set-key "\M-slt" 'toggle-truncate-lines)
(global-set-key "\M-slhh" 'hs-hide-all)
(global-set-key "\M-slhs" 'hs-show-all)
(global-set-key [(meta ?/)] 'hippie-expand)
(setq mac-command-modifier 'meta) ;映射苹果键  

;; for balin terminal
;; color theme setting, customize-themes
(if (equal window-system nil)
    (progn (load-theme 'wombat t) 
	   (menu-bar-mode -1))
  nil)
(add-hook 'term-setup-hook
  '(lambda ()
     (define-key function-key-map "\e[1;9A" [M-up])
     (define-key function-key-map "\e[1;9B" [M-down])
     (define-key function-key-map "\e[1;9C" [M-right])
     (define-key function-key-map "\e[1;9D" [M-left])))
;;for ruby script
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setq hippie-expand-try-functions-list 
      '(try-complete-file-name
	try-complete-file-name-partially
	try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 4)))

(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Microsoft Windows") )
  )
 ((string-equal system-type "darwin")   ; Mac OS X
  (progn
    (message "Mac OS X")
    (setq url-using-proxy t)
    (setq url-proxy-services '(("http" . "10.8.0.1:8118")))
    )
  )
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux") )
  )
 )
