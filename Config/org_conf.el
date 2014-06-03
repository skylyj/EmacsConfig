(require 'org)
(setq org-default-notes-file "~/.notes")
(setq org-remember-templates
      '(("TODO" ?t "* TODO %?\n %x\n %T" "~/Documents/Org/home.org" "Tasks")
	("IDEA" ?i "* IDEA %?\n %i\n %T\n%a" "~/Documents/Org/home.org" "Idea")
	))

(setq org-directory "~/Documents/Org/")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)

(setq org-agenda-files (list "~/Documents/Org/home.org"  "~/Documents/Org/work.org"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-hide-leading-stars t)
(setq org-log-done t)
(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/Org/"
         :publishing-directory "/var/www/"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index t
	 :auto-sitemap t
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
	 :author-info "lianyijiang" 
	 :email-info "sky_yjl@163.com"
       	 :author "连义江" 
	 :email "sky_yjl@163.com"
	 :TeX-macros nil
	 :LaTeX-fragments nil
	 :latex-listings nil
	 :sub-superscript nil
	 :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"/css/core.css\"
    type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/Org/"
         :publishing-directory "/var/www/"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "sky_yjl@163.com")))
