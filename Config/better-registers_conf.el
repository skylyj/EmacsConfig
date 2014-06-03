;; (make-variable-buffer-local 'register-alist) ; 
(require 'better-registers)
(defface register-marker-face '((t (:background "grey")))
  "Used to mark register positions in a buffer."
  :group 'faces)
(global-set-key (kbd "<f12>") (lambda (char)
				(interactive "cInsert Register:")
				(insert-register char 't)))
(global-set-key  (kbd "<C-f12>") (lambda (char)
				   (interactive "cCopy to Register:")
				   (copy-to-register char (region-beginning) (region-end))
				   (cua-cancel)))
(global-set-key (kbd "<C-S-f12>")  (lambda (char)
				     (interactive "cCut to Register:")
				     (copy-to-register char (region-beginning) (region-end))
				     (cua-delete-region)))
(defun set-register (register value)
  "Set Emacs register named REGISTER to VALUE.  Returns VALUE.
    See the documentation of `register-alist' for possible VALUE."
  (let ((aelt (assq register register-alist))
	(sovl (intern (concat "point-register-overlay-"
			      (single-key-description register))))
	)
    (when (not (boundp sovl))
      (set sovl (make-overlay (point)(point)))
      (overlay-put (symbol-value sovl) 'face 'register-marker-face)
      (overlay-put (symbol-value sovl) 'help-echo
		   (concat "Register: `"
			   (single-key-description register) "'")))
    (delete-overlay (symbol-value sovl))
    (if (markerp value)
	;; I'm trying to avoid putting overlay on newline char
	(if (and (looking-at "$")(not (looking-back "^")))
	    (move-overlay (symbol-value sovl) (1- value) value)
	  (move-overlay (symbol-value sovl) value (1+ value))))
    (if aelt
	(setcdr aelt value)
      (push (cons register value) register-alist))
    value))
