;;; (set-language-environment 'UTF-8)
;;; current emacs core is unicode code...

;;; (set-default-font "Segoe Print-14")
(set-default-font "DejaVu Sans Mono-12")

;;; emacs configuration
(set-scroll-bar-mode nil)
(tool-bar-mode nil)
(setq default-frame-alist
      '((vertical-scroll-bars)
 	(top . 25)
 	(left . 45)
  	(width . 160)
  	(height . 45)
  	(tool-bar-lines . 0)
  	(menu-bar-lines . 1)
  	(right-fringe)
  	(left-fringe))
      )


(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)

;;; replace yes/no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; display column number
(column-number-mode t)

;;; disply current edit document in emacs title
(setq frame-title-format "matrix@%b")


;;; color theme
;;; (setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/color-theme-6.6.0") load-path))
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/site-lisp/color-theme-cobalt/color-theme-cobalt.el")
(color-theme-cobalt)


;;; (setq load-path (cons (expand-file-name "/opt/emacs_plugins") load-path))
(load-file "~/.emacs.d/site-lisp/cmake-mode.el")
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

(load-file "~/.emacs.d/site-lisp/cedet-1.1/common/cedet.el")

(global-set-key [(f5)] 'speedbar)

(setq semanticdb-project-roots
      (list
       (expand-file-name "/")))
(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-commandj))
  )

;;; (global-unset-key [(control space)])
(global-set-key [(control tab)] 'my-indent-or-complete)

(autoload 'senator-try-expand-semantic "senator")
;;; hippie auto complete strategys
(setq hippie-expand-try-functions-list
      '(
	senator-try-expand-semantic
	try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-list
	try-expand-list-all-buffers
	try-expand-line
	try-expand-line-all-buffers
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-whold-kill
	)
      )

(global-ede-mode 1)                        ; Enable the Project management system
(semantic-load-enable-code-helpers)        ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)              ; Enable template insertion menu




;;; CC-mode http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;; my c/c++ language edit strategy
(defun my-c-mode-common-hook()
  ;;; (setq tab-width 2 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;; key define
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  
  ;;; pre process settings
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;;; my c++ language edit strategy
(defun my-c++-mode-hook()
  ;;; (setq tab-width 2 indent-tabs-mode nil)
  (c-set-style "stroustrup")
  )

;;; /usr/share/emacs/site-lisp/tcc-nxml-emacs:  Add these lines
;;      to your .emacs to use nxml-mode.  For documentation of
;;      this mode, see http://www.nmt.edu/tcc/help/pubs/nxml/
;;--
;; Add the nxml files to emacs's search path for loading:
;;--
(setq load-path
      (append load-path
              '("~/.emacs.d/site-lisp/nxml-mode-20041004/")))
;;--
;; Make sure nxml-mode can autoload
;;--
(load "~/.emacs.d/site-lisp/nxml-mode-20041004/rng-auto.el")

;;--
;; Load nxml-mode for files ending in .xml, .xsl, .rng, .xhtml
;;--
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))

;;; Define a command to insert a fragment from the i/ subdirectory.
;;
(defun insert-frag (name)
  "Like insert-file but prepends 'i/' to the path given."
  (interactive "MTemplate: ")
  (insert-file (concat "~/.emacs.d/templates/" name)))
(global-set-key "\C-c\C-e" 'insert-frag)


;;; emacs-template
;;; When you create a new file with Emacs, 
;;; package Template supplies an initial buffer content via a template
(setq load-path
      (append load-path
              '("~/.emacs.d/site-lisp/template/")))
(require 'template)
(setq template-default-directories (cons "~/.emacs.d/site-lisp/.templates/" template-default-directories))
(setq template-auto-insert t) 
(template-initialize)


;;
;; org-mode
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-7.9.3d/lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-7.9.3d/contrib/lisp" t)
(load "org-mode")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-raise-tool-bar-buttons t t)
 '(auto-resize-tool-bars t t)
 '(calendar-week-start-day 1)
 '(case-fold-search t)
 '(org-agenda-files (quote ("~/org/birthday.org" "~/org/gtd.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy (quote ((agenda time-up priority-down tag-up) (todo tag-up))))
 '(org-agenda-start-on-weekday nil)
 ;; '(org-agenda-todo-ignore-deadlines t)
 ;; '(org-agenda-todo-ignore-scheduled t)
 ;; '(org-agenda-todo-ignore-with-date t)
 '(org-agenda-window-setup (quote other-window))
 '(org-deadline-warning-days 7)
 ;; '(org-export-html-style "<link rel=\"stylesheet\" type=\"text/css\" href=\"mystyles.css\">")
 '(org-fast-tag-selection-single-key nil)
 '(org-log-done (quote (done)))
 '(org-refile-targets (quote (("gtd.org" :maxlevel . 1) ("someday.org" :level . 1))))
 '(org-reverse-note-order nil)
 '(org-tags-column -78)
 '(org-tags-match-list-sublevels nil)
 '(org-time-stamp-rounding-minutes 5)
 '(org-use-fast-todo-selection t)
 '(org-use-tag-inheritance nil)
 '(unify-8859-on-encoding-mode t nil (ucs-tables)))


;; add org todo keywords
;; you can press 'C-c C-t' followed by the selection key
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELED(c)")))

;; if you would like a TODO entry to automatically change to DONE 
;; when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; this allow you to select and deselect tags with
;; just a single key press.
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;; (setq org-log-done nil)
(setq org-log-done t)
(setq org-agenda-include-diary nil)
(setq org-deadline-warning-days 7)
(setq org-timeline-show-empty-dates t)
(setq org-insert-mode-line-in-empty-file t)

(require 'org-install)

(autoload 'remember "remember" nil t)
(autoload 'remember-region "remember" nil t)

(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/notes.org")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(
	("Todo" ?t "* TODO %^{任务} %^g\n%?\nAdded: %U" "~/org/gtd.org" "INBOX")
	("Note" ?n "\n* %U %^{笔记} %^g \n%i%?\n %a" "~/org/notes.org")
	))

(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (htmlize-output-type 'css)))

(setq org-agenda-custom-commands
      '(
	("p" "Projects"
	 ((tags "PROJECT")))
	("h" "Office and Home Lists"
	 ((agenda)
	  (tags-todo "OFFICE")
	  (tags-todo "HOME")
	  (tags-todo "WEB")
	  (tags-todo "CALL")
	  ))

	("d" "Daily Action List"
	 (
	  (agenda "" ((org-agenda-ndays 1)
		      (org-agenda-sorting-strategy
		       (quote ((agenda time-up priority-down tag-up) )))
		      (org-deadline-warning-days 0)
		      ))))))

(setq org-todo-keywords '((sequence "TODO" "APPT" "STARTED" "DONE")))
(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org"))
(global-set-key (kbd "C-c g") 'gtd)

(add-hook 'org-agenda-mode-hook 'hl-line-mode)
