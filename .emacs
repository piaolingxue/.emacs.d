;;; (set-language-environment 'UTF-8)
;;; current emacs core is unicode code...

(set-default-font "Segoe Print-14")

;;; emacs configuration
;;; (set-foreground-color "grey")
;; (set-background-color "black")
;; (set-cursor-color "gold1")
;; (set-mouse-color "gold1")
(set-scroll-bar-mode nil)
(tool-bar-mode nil)
(setq default-frame-alist
       '((vertical-scroll-bars)
 	(top . 25)
 	(left . 45)
  	(width . 160)
  	(height . 45)
;;;  	(background-color . "black")
;;;  	(foreground-color . "grey")
;;;  	(cursor-color . "gold1")
;;;  	(mouse-color . "gold1")
  	(tool-bar-lines . 0)
  	(menu-bar-lines . 1)
  	(right-fringe)
  	(left-fringe))
)

;; (set-face-foreground 'highlight "white")
;; (set-face-background 'highlight "blue")
;; (set-face-foreground 'region "cyan")
;; (set-face-background 'region "blue")
;; (set-face-foreground 'secondary-selection "skyblue")
;; (set-face-background 'secondary-selection "darkblue")

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
;; (defun insert-frag (name)
;;  "Like insert-file but prepends 'i/' to the path given."
;;  (interactive "MTemplate: ")
;;  (insert-file (concat "~/.emacs.d/templates/" name)))
;;
;; Bind the above command to C-c C-e.
;;
;; (global-set-key "\C-c\C-e" 'insert-frag)


;;; emacs-template
;;; When you create a new file with Emacs, 
;;; package Template supplies an initial buffer content via a template
(setq load-path
      (append load-path
              '("~/.emacs.d/site-lisp/template/")))
(require 'template)
;; (setq template-subdirectories '("~/.emacs.d/site-lisp/.templates")) 
(setq template-default-directories (cons "~/.emacs.d/site-lisp/.templates/" template-default-directories))
(setq template-auto-insert t) 
(template-initialize)

;; Define a command to insert a fragment from the i/ subdirectory.
;;
(defun insert-frag (name)
  "Like insert-file but prepends 'i/' to the path given."
  (interactive "MTemplate: ")
  (insert-file (concat "/home/libin/.emacs.d/site-lisp/.templates/" name)))
;;
;; Bind the above command to C-c C-e.
;;
(global-set-key "\C-c\C-e" 'insert-frag)
