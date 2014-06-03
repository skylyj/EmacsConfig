(global-set-key "%" 'match-paren) 
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

(global-set-key "\C-cv" 'wy-go-to-char)
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
  Typing `wy-go-to-char-key' again will move forwad to the next Nth
  occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(defun wy-go-to-char-back (n char)
  "Move forward to Nth occurence of CHAR.
  Typing `wy-go-to-char-key' again will move forwad to the next Nth
  occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(global-set-key "\C-cc" 'wy-go-to-char-back)


;;标记位置来跳转
;; (defun ska-point-to-register()
;;   "Store cursorposition _fast_ in a register. 
;;   Use ska-jump-to-register to jump back to the stored 
;;   position."
;;   (interactive)
;;   (setq zmacs-region-stays t)
;;   (point-to-register 8)
;;   (message "a mark has been made!")
;;   )

;; (defun ska-jump-to-register()
;;   "Switches between current cursorposition and position
;;   that was stored with ska-point-to-register."
;;   (interactive)
;;   (setq zmacs-region-stays t)
;;   (let ((tmp (point-marker)))
;; 	(jump-to-register 8)
;; 	(set-register 8 tmp))
;;   (message "jump to a previous mark!")
;;   )
;; (global-set-key [(control ?\.)] 'ska-point-to-register)
;; (global-set-key [(control ?\,)] 'ska-jump-to-register) 

;;行的操作
;; 复制一行非常常用，可以使用一个简单的 Elisp 函数。这里是这样设定的：如果选定了区域，那么按 M-w 就复制这个区域；如果没有选定区域，那么 M-w 就复制一行。
(defun huangq-kill-ring-save (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if mark-active
      (progn
	(kill-ring-save (region-beginning) (region-end))
	(message "general copy activated!")
	)
    (progn
      (if (> n 0)
	  (kill-ring-save (line-beginning-position) (line-end-position n))
	(kill-ring-save (line-beginning-position n) (line-end-position)))
      (message "copy active for %d lines!" n)
      )
    )
  )
(defun huangq-kill-region (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if mark-active
      (progn
	(kill-region (region-beginning) (region-end))
	(message "general cut activated!")
	)
    (progn
      (if (> n 0)
	  (kill-region (line-beginning-position) (line-end-position n))
	(kill-region (line-beginning-position n) (line-end-position)))
      (message "cut active for %d lines!" n)
      )
    )
  )

(global-set-key (kbd "M-w") 'huangq-kill-ring-save)
(global-set-key (kbd "C-w") 'huangq-kill-region)
					;(global-set-key (kbd "C-c M-w") 'huangq-kill-ring-save)
					;(global-set-key (kbd "C-c C-w") 'huangq-kill-region)

;; 复制一个单词也可以用一个简单 Elisp 函数，只要按一次 C-c w，就可以复制光标附近的单词。
(defun huangq-save-word-at-point()
  (interactive)
  (save-excursion
    (let ((end (progn (unless (looking-back "\\>" 1) (forward-word 1)) (point)))
	  (beg (progn (forward-word -1) (point))))
      (copy-region-as-kill beg end)
      (message (substring-no-properties (current-kill 0))))))
(global-set-key (kbd "C-c w") 'huangq-save-word-at-point)

;;; word count
(defun word-count ()
  "Count words of the slected region while some text is selected;
Otherwise count words of this buffer"
  (interactive)
  (let ((msg "全文")
        (begin (point-min))
        (end (point-max)))
    (if mark-active
        (setq msg "选中"
              begin (region-beginning)
              end (region-end))
      )
    (message "统计%s字数..." msg)
    (shell-command-on-region begin end "wc -w")))

;; (setenv "PATH"
;;   (concat
;;    "/usr/texbin" ":"
;;    "/usr/local/bin" ":"
;;    (getenv "PATH")
;;   )
;; )
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell 
	 (replace-regexp-in-string "[ \t\n]*$" "" 
				   (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

(require 'recentf)
(recentf-mode 1) 
(defun recentf-open-files-compl ()
(interactive)
(let* ((all-files recentf-list)
	  (tocpl (mapcar (function 
					   (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
	  (prompt (append '("File name: ") tocpl))
	  (fname (completing-read (car prompt) (cdr prompt) nil nil)))
 (find-file (cdr (assoc-string fname tocpl))))) 

(global-set-key [(control x)(control r)] 'recentf-open-files-compl)
(defun open-recent-file-other ()
" Open recent file in other window "
(interactive)
(progn (split-window-vertically)
	   (recentf-open-files-compl)
))
(global-set-key "\C-x\C-y" 'recentf-open-files-compl)
(global-set-key "\C-x4\C-y" 'open-recent-file-other)
(global-set-key "\C-x\C-r" 'find-file-read-only)

;;searching for word
(defun isearch-cur-word-qian ()
  "ISearch current word use function FUN."
  (interactive)
  (let ((cur-word (current-word)))
    (if (not cur-word)
        (message "No word under cursor.")
      (call-interactively 'isearch-forward)
      (isearch-yank-string cur-word))))
(defun isearch-cur-word-hou ()
  "ISearch current word use function FUN."
  (interactive)
  (let ((cur-word (current-word)))
    (if (not cur-word)
        (message "No word under cursor.")
      (call-interactively 'isearch-backward)
      (isearch-yank-string cur-word))))
(global-set-key "\M-s\M-f" 'isearch-cur-word-qian)
(global-set-key "\M-s\M-b" 'isearch-cur-word-hou) 

(defun my-isearch-word-at-point ()
  (interactive)
  (call-interactively 'isearch-forward-regexp))

(defun my-isearch-yank-word-hook ()
  (when (equal this-command 'my-isearch-word-at-point)
    (let ((string (concat "\\<"
                          (buffer-substring-no-properties
                           (progn (skip-syntax-backward "w_") (point))
                           (progn (skip-syntax-forward "w_") (point)))
                          "\\>")))
      (if (and isearch-case-fold-search
               (eq 'not-yanks search-upper-case))
          (setq string (downcase string)))
      (setq isearch-string string
            isearch-message
            (concat isearch-message
                    (mapconcat 'isearch-text-char-description
                               string ""))
            isearch-yank-flag t)
      (isearch-search-and-update))))

(add-hook 'isearch-mode-hook 'my-isearch-yank-word-hook)
(global-set-key "\C-xw" 'my-isearch-word-at-point) 
(global-set-key "\M-sf" 'my-isearch-word-at-point) 

(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))

(defun compact-uncompact-block ()
  "Remove or add line ending chars on current paragraph.
This command is similar to a toggle of `fill-paragraph'.
When there is a text selection, act on the region."
  (interactive)

  ;; This command symbol has a property “'stateIsCompact-p”.
  (let (currentStateIsCompact (bigFillColumnVal 4333999) (deactivate-mark nil))

    (save-excursion
      ;; Determine whether the text is currently compact.
      (setq currentStateIsCompact
            (if (eq last-command this-command)
                (get this-command 'stateIsCompact-p)
              (if (> (- (line-end-position) (line-beginning-position)) fill-column) t nil) ) )

      (if (region-active-p)
          (if currentStateIsCompact
              (fill-region (region-beginning) (region-end))
            (let ((fill-column bigFillColumnVal))
              (fill-region (region-beginning) (region-end))) )
        (if currentStateIsCompact
            (fill-paragraph nil)
          (let ((fill-column bigFillColumnVal))
            (fill-paragraph nil)) ) )

      (put this-command 'stateIsCompact-p (if currentStateIsCompact nil t)) ) ) )


(defun run-current-file ()
  (interactive)
  (let (ext-map file-name file-ext prog-name cmd-str)
    (setq ext-map
	  '(
            ("py" . "python")
            ("sh" . "bash")
            ("htm" . "firefox")
            )
          );定义命令－文件类型映身表.
    (setq file-name (buffer-file-name));得到当前的buffer名
    (setq file-ext (file-name-extension file-name));得到后缀
    (setq prog-name (cdr (assoc file-ext ext-map)))；根据后缀得到执行的命令，通过对ext-map的查找
    (setq cmd-str (concat prog-name " " file-name));拼出一个命令
    (shell-command cmd-str)))

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-C-;") 'comment-or-uncomment-region-or-line)
(global-set-key "\M-s\M-;" 'comment-or-uncomment-region-or-line)
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))
(global-set-key [C-backspace] 'backward-kill-line)
(global-set-key "\M-sk" 'backward-kill-line)

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)
