;; This is a web programmer's .emacs file for GNU Emacs on Mac.
;;
;; Note that due to the workings of the Aquamacs "skin" for Emacs that is used here, the companion file '~/Library/Preferences/Aquamacs Emacs/customizations.el'
;; has been included alongside this file, in the same directory.
;;
;; This file has been tested on:
;;     * The Aquamacs "skin" of GNU Emacs, available at: http://aquamacs.org/  .  M-x version yields:
;;         GNU Emacs 23.3.50.1 (i386-apple-darwin9.8.0, NS apple-appkit-949.54) of 2011-10-25 on braeburn.aquamacs.org - Aquamacs Distribution 2.4, on Mac OS X Lion.
;;     * A plain build of GNU Emacs on OS X, available at http://emacsformacosx.com/ .  M-x version yields:
;;         GNU Emacs 24.3.1 (x86_64-apple-darwin, NS apple-appkit-1038.36) of 2013-03-12 on bob.porkrind.org
;; A similar variant has also been tested on Ubuntu 10.1, Centos 5 (kernel 2.6.18-194.el5) and on Windows XP, Service Pack 2.
;;
;; M-x version:
;;        GNU Emacs 23.4.1 (x86_64-apple-darwin12.3.0, NS apple-appkit-1187.37) of 2013-06-13 on acs-trailblazer.ist.psu.edu - Aquamacs Distribution 2.5
;;
;; The GNU Emacs Homepage is located at:
;;             Http://www.gnu.org/directory/GNU/emacs.html
;;
;; This Document Last Modified: 2013-06-14.
;;
;; Portability: Comment out code for one platform and comment in the code for another.
;; For example, this file is currently set for Unix.
;;
;; @author: Christopher M. Balz.
;;
;; Aquamacs Users:
;;   Find this file on github at: https://github.com/christopherbalz/.emacs-/blob/master/aquamacs/.emacs
;;   Find its companion file (see above for details), 'customizations.el', at: https://github.com/christopherbalz/.emacs-/blob/master/aquamacs/customizations.el
;;   Note that for Aquamacs, custom extensions are often located under: '/Library/Application Support/Aquamacs Emacs/'
;;
;; General Notes:  It is often said that a new Emacs user should stay away from old, crusty
;;                 '.emacs' files from others.  However, the only way that I ever was able
;;                 to get a reasonable return on the investment of my time put into setting
;;                 up my Emacs configurations was by borrowing code snippets from others.
;;                 It is true that no '.emacs' file should be used uncritically, by newbie or
;;                 by others.
;;
;;                 However, for the best user base, new users should be able to
;;                 fairly easily clip out sections of '.emacs' files that interest them and put
;;                 them to use right away in their own '.emacs' files.  To this end, I have
;;                 attempted to effectively segment the various independent components of this
;;                 '.emacs' file and have documented what I have done as clearly as possible.
;;                 It's very exciting how Emacs modes related to software engineering for the
;;                 web are maturing.
;;

;; ------------   Invocation of Gnu Emacs on Windows:
;;
;;
;;    First, set user-specific 'HOME' environment variable to 'C:/cygwin/home/Christopher Balz/'
;;    (substituting whatever your home directory is), which is
;;    the directory in which your '.emacs' file is located.  Do this by going to the 'Control Panel',
;;    then to 'System', then to 'Advanced', then to 'Environment Variables', the to 'Variables
;;    for <user>'.
;;
;;    Next, run the 'addpm.exe' program to install Emacs on Windows.  You don't have to do this,
;;    and can do the necessary tasks to run Emacs on Windows manually, but this is the best way to go.
;;
;;    If you experience temporary "blanking out" of the screen when you select one of the two Emacs windows
;;    (meaning specifically the Windows command line), select 'Properties' on the Emacs short cut,
;;    select the 'Options' tab, select the 'Window' radio button, and then select 'Ok' and 'Save
;;    for future sessions.'  If you run Windows command programs from Emacs, such as Cygwin, you
;;    may also get "blanking out" of the screen unless you run "Command" from the Windows "Run" option
;;    on the "Start" menu, right-click on the window title bar, select 'Default',
;;    and perform the same property change just described, selecting "Window" instead of "Full Screen".
;;

;; ------------  Commense lisping:

;;  - - - Begin CEDET
;; Load a more up-to-date CEDET than the one that ships with emacs.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;; (load-file "/home/user/cedet/cedet-devel-load.el")

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
;; (semantic-mode 1)

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;;  - - - End CEDET

;; - - - Begin Auto-Complete (non-CEDET autocompletion; knows about JavaScript).  Manual: http://cx4a.org/software/auto-complete/manual.html
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; - - - End Auto-Complete

(global-set-key [(control tab)] 'dabbrev-expand) ;; Standard Emacs identifier completion (autocomplete/autocompletion).

;; Begin: Turn off unnecessary gui elements:
(if (not(eq (boundp 'tabbar) nil))
    (tabbar-mode -1)          ;; hide the tab bar that just recently became turned on by default in some flavors of Emacs, around Emacs v23.
)
;; Hide the tool-bar, in case it appears.  Note that on Aquamacs, per http://www.emacswiki.org/emacs/AquamacsFAQ , it's a setting in the Aquamacs 'customizations.el' (mentioned above).
;;    E.g.:  “Options → Appearance → Adopt Face and Frame Parameters as Frame Default”. Then choose “Options → Save Options”.
(tool-bar-mode -1)
;; End: Turn off unnecessary gui elements.

;; Provide a useful error trace if loading this .emacs fails.
;; (setq debug-on-error t)

;; List Emacs command-line arguments:
(message "--------------")
(message "Listing the remaining command-line arguments given to Emacs:")
(dolist (arg command-line-args)(
				message arg)
	)
(message "--------------")

;; Manage possibility of running under a bare terminal with no windowing (no X Windows, etc):
(if (not(eq window-system nil))
    (message "Running under a windowing system.")
  (message "Not running under a windowing system: Skipping any code that requires a windowing system.")
  )

;; If you have an oversensitive mouse wheel, stay out of trouble by disabling mouse-wheel pasting:
;; (defun mouse-yank-at-click (event)
;; )


;; Begin: Set character/file encoding - - - -

;; (set-buffer-file-coding-system 'iso-latin-1-unix t)
;; Use the utf8-unix file format always:
(set-buffer-file-coding-system 'utf-8-unix t) ;; Unicode.
;; Use utf-8 everywhere else:
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; End: Set character/file encoding - - - -


;; desktop-menu mode - useful for keeping two instances of Emacs on their own desktop.
(autoload 'desktop-menu "desktop-menu" "desktop-menu mode, useful if you have more than one instance of Emacs under your username." t)

;; This is key for handling shell processes that output utf-8 characters.
;; Some will tell you they failed with a utf-8 char, in which case it's helpful to be able to see it.
(defun u-shell ()
  "Create Shell that supports UTF-8."
  (interactive)
  (set-default-coding-systems 'utf-8)
  (shell))

;; Add the site directory (the site directory is used to contain non-core Emacs Lisp packages)
;; to the Emacs load-path.  The Emacs load-path is
;; the list of directories where Emacs searches for packages that you require.
;; This must be at the head of your .emacs file.  This code prepends the site directory to the load path:

;; Standard emacs lisp access (for non-byte-compiled access):
;;(add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/emacs-21.3/site-lisp/"))
;;(add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/emacs-21.3/site/lisp/progmodes/"))
;; System-wide emacs customizations:
;; (add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/site/"))
;; (add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/site/snippets/"))
;; (add-to-list 'load-path (expand-file-name "/cygdrive/c/Program Files/emacs/site/"))

;; For Mac: MacPorts.  Note that this will augment the load-paths that Aquamacs uses (to see them, check your load-path variable via C-h v load-path).
(add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/")) ;; Note that these show up before Aquamacs paths.
(add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/w3m"))
(add-to-list 'load-path (expand-file-name "/opt/local/share/emacs/site-lisp/magit"))
(add-to-list 'load-path (expand-file-name "/Library/Application Support/Aquamacs Emacs/js2-mode"))

;; Personal emacs/site:
(setq load-path (cons (expand-file-name "~/emacs/site/") load-path)) ;; Prepends to override analogous system libs.
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/html5/html5-el-master")
;; (add-to-list 'load-path (expand-file-name "~/emacs/site/")) ;; Append to let analogous system libs take precedence.
;; So that Emacs can find the home directory files (desktop, etc.):
(add-to-list 'load-path (expand-file-name "~/"))
;; Specific Packages:

;;(add-to-list 'load-path (expand-file-name "~/emacs/site/xslide/"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/nxml-mode-20041004/"))

;; - - - - Begin Image Section

;; For viewing images:
(if (not(eq window-system nil))
    (autoload 'thumbs "thumbs" "Preview images in a directory." t)
    ;;  (load-file (expand-file-name "~/emacs/site/thumbs.el"))
)

;; Eimp Minor Mode
;;
;; This package allows interactive image manipulation from within
;; Emacs.  It uses the mogrify utility from ImageMagick to do the
;; actual transformations.
;;
;; Switch the minor mode on programmatically with:
;;
;;    (eimp-mode 1)
;;
;; or toggle interactively with M-x eimp-mode RET.
;;
;; Switch the minor mode on for all image-mode buffers with:
;;
(autoload 'eimp-mode "eimp" "Emacs Image Manipulation Package." t)
(add-hook 'image-mode-hook 'eimp-mode)

;; - - - - End Image Section

;; - - - Begin woman set-up, to be able to do 'esc-x woman' to view man pages.
(if (getenv "MANPATH")
  ;; Then do nothing: woman will just use the system manpath (works on Mac OS X with MacPorts, etc).

  ;; Else, use a rhel set-up.  This code path here of course will not run the fail-overs built into woman (which don't work on rhel), as described here: http://www.gnu.org/software/emacs/manual/html_node/woman/Topic.html

  ;;     On many Linux systems, such as rhel, the MANPATH environment variable is not set.  Instead, 'man' uses a script, such as rhel's '/etc/man.config', that woman doesn't understand.  So in that case we
  ;;     do this manual configuration.  The values below are pasted from there.
  (setq woman-manpath '("/usr/man"
                        "/usr/share/man"
                        "/usr/local/man"
                        "/usr/local/share/man"
                        "/usr/X11R6/man"
                        "/opt/*/man"
                        "/usr/lib/*/man"
                        "/usr/share/*/man"
                        "/usr/kerberos/man")))

(autoload 'woman "woman" "Browse man pages." t)
;; - - - End woman set-up

;; JDEE Dependencies
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/jde/lisp"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/cedet/common"))
;; Emacs Code Browser is an optional-element to the JDEE Suite:
;;(add-to-list 'load-path "~/emacs/site/ecb")

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;;(add-to-list 'load-path (expand-file-name "~/emacs/site/emacs-w3m-1.4.4/"))
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/w3m/"))

;; ;;        For CSP, a formal notation for _c_ommunicating _s_equential _p_rocesss
;; (add-to-list 'load-path (expand-file-name "c:/Progra~1/emacs/site/csp-mode-1.0.1/"))
;; ;;        For Promela, a concurrent process specification language:
;; (add-to-list 'load-path (expand-file-name "c:/Progra~1/emacs/site/promela/"))


;; On Windows 2000, it is sufficient to set the user-specific 'HOME' environment
;; variable (see above) to the path to your .emacs file.  For example, mine goes to:
;; 'C:/cygwin/home/Christopher Balz'.  Most other systems should have a
;; reasonably sane approach to doing this.  These approaches are best.
;; However, if on some other system you have
;; trouble saving your customizations (meaning, the customizations possible
;; through the command ESC-x customize-group, and meaning, the error message
;; 'saving settings from 'emacs -q' would overwrite customizations'),
;; explicitly assigning the 'user-init-file' variable is a sure-fire way
;; to avoid the problem:
;; (setq user-init-file (expand-file-name "~/.emacs")
;;        custom-file (expand-file-name "~/.emacs"))


;; For use of Bash shell via Cygwin on Windows 2000 (or NT), available from:
;;	     http://www.cygwin.com/
;; (if you do not have Cygwin installed, comment all of this section out).
  ;; This assumes that Cygwin is installed in C:\cygwin (the
  ;; default) and that C:\cygwin\bin is not already in your
  ;; Windows Path (it generally should not be).
      ;;
;;(setq exec-path
;;       (append (list
;;                "c:/cygwin/bin"
;;                "c:/Progra~1/emacs/site/w3m-0.5.1"
;;                )
;;               exec-path))
;; (setenv "PATH" (concat "c:\\cygwin\\bin;c:\\Progra~1\\emacs\\site\\w3m-0.5.1;" (getenv "PATH")))
;;
;;; Add Cygwin Info pages
;;(setq Info-default-directory-list (append Info-default-directory-list (list "c:/cygwin/usr/info/")))
;; End of Cygwin part of bash-shell section.
(setq shell-file-name "bash")                     ;; Leave this line regardless of host o/s (Unix, Win, etc).
(setenv "SHELL" shell-file-name)                  ;; Leave this line regardless of host o/s (Unix, Win, etc).
;; For Cygwin (on Windows) Only:
;; (setq explicit-bash-args '("--login" "--init-file" "c:/home/cbalz/.bash_profile" "-i"))  ;; For Cygwin (on Windows) Only.
(setq explicit-shell-file-name shell-file-name)   ;; Leave this line regardless of host o/s (Unix, Win, etc).
;; Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; End of bash shell use section.

;; This removes unsightly ^M characters that would otherwise appear in the output of code saved in DOS format.
(add-hook 'comint-output-filter-functions
	  'comint-strip-ctrl-m)

;; Set start-up directory with Unix nomenclature
;; (your configuration files _must_ be in this directory):
(setq startup-directory "~/")

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!  '#' files will crash a variety of directory-reading programs.
;; Courtesy: http://cheat.errtheblog.com/s/emacs_tips/
;;
(defvar autosave-dir
 ;; Use this by default: (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
 ;; Use this if the contents of '/tmp' can get deleted:
 (concat "~/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(setq auto-save-file-name-transforms `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat
																	autosave-dir "\\1") t)))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "~/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; ----- Begin JavaScript Section

(autoload 'js2-mode "js2-mode" nil t) ;; http://code.google.com/p/js2-mode/

;; - - - Set js2-mode to know about globals: http://www.emacswiki.org/emacs/Js2Mode
;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
;; add any symbols to a buffer-local var of acceptable global vars
;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
;; you can;t have a symbol called "someName:false"
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (when (> (buffer-size) 0)
              (let ((btext (replace-regexp-in-string
                            ": *true" " "
                            (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                      (split-string
                       (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                       " *, *" t))
                ))))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)) ;; '.json' files do not work well at the time of this writing with 'js2' mode (JavaScript-IDE).
(autoload 'json-mode "json-mode" nil t) ;; https://github.com/joshwnj/json-mode
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; An optional Javascript mode for shellserver to Mozilla
;; See https://sekhmet.acceleration.net/ADW/JsShellServer
;;(add-hook 'javascript-mode-hook 'js-mode)
;;(autoload 'js-mode "js-mode" nil t)

;; This is the container for my custom js editing mode
(defun my-js-indent-setup ()
 (setq c-default-style "bsd") ;; bsd stroustroup
 ;; (setq indent-tabs-mode t)        ;; turn on tabs for js
 (setq indent-tabs-mode nil)   ;; turn off tabs for js
 (setq c-basic-offset 4)
 (lambda () (js-mode 1))
 (js-mode 1))

;; Add the above hook to the c-mode.
;;(add-hook 'javascript-mode-hook 'my-js-indent-setup)
(add-hook 'js2-mode-hook 'my-js-indent-setup)

;; ----- End JavaScript Section


;; ----- Begin Handlebars/Mustache Template Editing Section: From https://github.com/mustache/emacs/blob/master/mustache-mode.el  @to-do: Come up with a way in Emacs to match '.html' that's not '.mu.html'.
(require 'mustache-mode)
(setq auto-mode-alist
      (cons '("\\.\\(dust\\|hbs\\)" . mustache-mode)
	      auto-mode-alist))
;; ----- End Handlebars/Mustache Template Editing Section

;; ----- Begin XML--XSL--HTML Editing Section

;;   - - - From http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; Necessary to override the application of html-mode:
(add-to-list 'magic-mode-alist '("<!DOCTYPE html>" . web-mode) )
(add-to-list 'magic-mode-alist '("<!doctype html>" . web-mode) )
(add-to-list 'magic-mode-alist '("<html>" . web-mode) )


(setq auto-mode-alist
      (cons '("\\.\\(fo\\|xml\\|xsl\\|xsd\\|rng\\|xhtml\\)\\'" . nxml-mode)
	      auto-mode-alist))


;; The following first-line matches are used to load nxml-mode over html-helper mode, since we use the non-xml html5 package (which does also do xhtml5).

 (defun my-nxml-indent-setup ()
   (setq indent-tabs-mode nil) )
 ;; Add the above hook to the nxml-mode.
 (add-hook 'nxml-mode-hook 'my-nxml-indent-setup)

;;   - - - Begin html5 section (also added to load path in custom directory, above).
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "/opt/local/share/emacs/site-lisp/html5/html5-el-master/schemas.xml"))

(require 'whattf-dt)
;;   - - - End html5 section (also added to load path in custom directory, above).
;;
;; ----- End XML--XSL--HTML Editing Section


;; XSL mode -- turned off since this has no validation; using nXML mode instead.
;; (autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)

;;   Turn on font lock when in XSL mode
;; (add-hook 'xsl-mode-hook
;;	  'turn-on-font-lock)

;;(setq auto-mode-alist
;;      (append
;;       (list
;;	'("\\.fo" . xsl-mode)
;;	'("\\.xsl" . xsl-mode))
;;       auto-mode-alist))

;;(add-hook `xsl-mode-hook
;;  `(lambda ()
;;     (define-key xsl-mode-map "M-TAB" 'xsl-complete)))

;; ;; -------- JDE is the Java IDE for Emacs.
;;(require 'overlay-fix ) ;; Needed to fix intermittant font-lock failure in jde - this might be outdated.
;;(require 'jde)
 ;; Use no tabs when editing Java for cross-editor indentation compatibility, and set the indent:
;; (defun my-jde-indent-setup ()
;;   (setq indent-tabs-mode nil)
;;   (c-add-style
;;     "my-java"
;;     '("java"
;;      (c-basic-offset . 4)))
;;   (c-set-style "my-java"))
 ;; Add the above hook to the jde-mode.
;; (add-hook 'jde-mode-hook 'my-jde-indent-setup)

;; ;; --------- Begin CSP Section
;; (require 'csp-mode)
;; (setq auto-mode-alist (cons '("\\.csp$" . csp-mode) auto-mode-alist))
;; (setq csp-validate-command "c:/Windows/System32/cmd.exe e:off /c 'C:\\Progra~1\\probe-1.30-windows\\probe-1.30-windows\\probe.exe'" )
;; ;; --------- End CSP Section

;; ;; -------- Begin Promela Section
;; (autoload 'promela-mode "promela.el" "PROMELA mode" nil t)
;; (setq auto-mode-alist
;;       (append
;;        (list (cons "\\.promela$"  'promela-mode)
;; 		     (cons "\\.spin$"     'promela-mode)
;; 		     (cons "\\.pml$"      'promela-mode)
;; 		     ;; (cons "\\.other-extensions$"     'promela-mode)
;;              )
;;        auto-mode-alist))
;; ;; --------  End Promela Section

;; From http://jblevins.org/projects/markdown-mode/ :
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ;; --------- Begin w3m Section (HTML browser)

;; ;;;======================================================================
;; ;;; w3m browser mode:
;; ;;;======================================================y================
;; See the info near the top of the file about w3m.
;; (require 'w3m-load)
;; ;;; This integrates the external program w3m with emacs.
;; ;; (setq w3m-command (concat "c:/Progra~1/emacs/site/w3m-0.5.1/w3m.exe" ""))
;; ;; Commented out while w3m is broken (setq w3m-browse-url (concat "c:/Progra~1/emacs/site/w3m-0.5.1/w3m.exe" ""))
;; ;; (setq w3m-find-file (concat "c:/Progra~1/emacs/site/w3m-0.5.1/w3m.exe" ""))

;; ;;; Allow browsing of local files:
;; ;; (setq w3m-dirlist-cgi-program "C:/Progra~1/emacs/site/w3m-0.5.1/scripts/dirlist.cgi")

;; ;;; causes the return key to submit a form
;; ;; (setq w3m-use-form t)


;; ;;; Need to load the search to change the search-engine-alist without
;; ;;; using customize, since there appears to be no hook into the
;; ;;; w3m-search function to activate
;; ;; (load-library "w3m-search")

;; ;;; for a list of available engines, or to add a search engine, see
;; ;;; the variable 'w3m-search-engine-alist' defined in w3m-search.el.
;; ;;; It's set in the customization section at the end of this file
;; ;; (add-to-list 'w3m-search-engine-alist
;; ;;  '("google" "http://www.google.com/search?num=30&q=%s" nil))
;; ;; (add-to-list 'w3m-search-engine-alist
;; ;;   '("google-groups" "http://groups.google.com/groups?num=30&q=%s" nil))
;; ;; (add-to-list 'w3m-search-engine-alist
;; ;;   '("teo" "http://www.teoma.com/search.asp?t=%s" nil))

;; ;;; set the default search engine
;; ;; (setq w3m-search-default-engine "google")

;; ;;; Use programs contributed with the w3m distribution
;; ;; (autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
;; ;; (autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
;; ;; (autoload 'w3m-weather "w3m-weather" "Display weather report." t)
;; ;; (autoload 'w3m-antenna "w3m-antenna" "Report change of WEB sites." t)
;; ;; (autoload 'w3m-namazu "w3m-namazu" "Search files with Namazu." t)
;; ;;

;; ;;; external browser in which to view pages/graphics
;; ;; (if (eq window-system 'w32)
;; ;; (setq w3m-content-type-alist
;; ;;       '(("text/plain" "\\.\\(txt\\|tex\\|el\\)" nil)
;; ;;   ("text/html" "\\.s?html?$" w32-shellex-on-object file)
;; ;;   ("image/jpeg" "\\.jpe?g$"  w32-shellex-on-object file)
;; ;;   ("image/png" "\\.png$"     w32-shellex-on-object file)
;; ;;   ("image/gif" "\\.gif$"     w32-shellex-on-object file)
;; ;;   ("image/tiff" "\\.tif?f$"  w32-shellex-on-object file)
;; ;;   ("image/x-xwd" "\\.xwd$"   w32-shellex-on-object file)
;; ;;   ("image/x-xbm" "\\.xbm$"   w32-shellex-on-object file)
;; ;;   ("image/x-xpm" "\\.xpm$"   w32-shellex-on-object file)
;; ;;   ("image/x-bmp" "\\.bmp$"   w32-shellex-on-object file)
;; ;;   ("video/mpeg" "\\.mpe?g$"  w32-shellex-on-object file)
;; ;;   ("video/quicktime" "\\.mov$" w32-shellex-on-object file file)
;; ;;   ("application/postscript" "\\.\\(ps\\|eps\\)$" w32-shellex-on-object file)
;; ;;   ("application/pdf" "\\.pdf$" w32-shellex-on-object file))
;; ;;    ))
;; ;;
;; ;;
;; ;; -------- End w3m Section (HTML browser)


;; -------- End JavaScript editing section. --------


;; -------- Begin XML and SGML Editing Section --------
;;
;; -> Note: this handles HTML also but
;; a formal DTD declaration is needed for that.  Instead, I use
;; html-helper-mode, which handles embedded scripts as well.
;; -> From: http://www.lysator.liu.se/~lenst/about_psgml/
;; -> Environment Variable Must be set for dtd feature to work:
;; PSGML needs to know where to find the SGML catalog files. There are a couple
;;  of ways to accomplish this, as described in the PSGML documentation. I use the method
;;  that makes use of the environment variable SGML_CATALOG_FILES because it is
;;  also used by the SGML parser (patience, I come to it in the next section of this article).
;;  So, now that you have a set of DTDs and a catalog file, create the afore-mentioned
;; environment variable and set it to include the path to your xhtml1.soc file, for
;; example d:\DTDs\xhtml1\xhtml1.soc. If you have more that one catalog file,
;; you can include them all, separating them with a path delimiter (";" on Windows,
;; ":" on UNIX-based systems).
;; Here is my value: c:\Progra~1\dtds\xhtml1\xhtml1.soc;c:\Progra~1\dtds\hodmacro\hodmacro.soc

;; (require 'sgml-mode "psgml.ael" "Major mode to edit SGML files.")
;; (autoload 'xml-mode "psgml.el" "Major mode to edit XML." t)
;; (setq auto-mode-alist
;;       (append '(
;; 		("\\.sgml$" . sgml-mode)
;; 		("\\.idd$" . sgml-mode)
;; 		("\\.ide$" . sgml-mode)
;; 		("\\.xml$" . xml-mode)
;; 		("\\.xsl$" . xml-mode)
;; 		("\\.fo$" . xml-mode)
;; 		)
;; 	      auto-mode-alist
;; 	      )
;;       )

; Auto-activate parsing the DTD when a document is loaded.
; If this isn't enabled, syntax coloring won't take affect until
; you manually invoke "DTD->Parse DTD"
;;(setq sgml-auto-activate-dtd t)

;;; Set up my "DTD->Insert DTD" menu.

;; (setq sgml-custom-dtd '
;;       (
;;        ( "DITA concept"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE concept SYSTEM \"concept.dtd\">" )
;;        ( "DITA task"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE task SYSTEM \"task.dtd\">" )
;;        ( "DITA reftopic"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE reftopic SYSTEM \"reftopic.dtd\">" )
;;        ( "DITA APIdesc"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE APIdesc SYSTEM \"apidesc.dtd\">" )
;;        ( "DITA topic"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE topic SYSTEM \"ditabase.dtd\">" )
;;        ( "HOD Script"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE HASCRIPT SYSTEM \"HAScript.dtd\">" )
;;        ( "XHTML 1.0 Strict"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"xhtml1-strict.dtd\">" )
;;        ( "XHTML 1.0 Transitional"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"xhtml1-transitional.dtd\">" )
;;        ( "XHTML 1.0 Frameset"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\" \"xhtml1-frameset.dtd\">" )
;;        ( "HTML 4.01 Transitional"
;; 	 "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">" )
;;        ( "HTML 4.01 Strict"
;; 	 "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\">" )
;;        ( "HTML 4.01 Frameset"
;; 	 "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\">" )
;;        ( "IBMIDDoc"
;; 	 "<!DOCTYPE ibmiddoc PUBLIC \"+//ISBN 0-933186::IBM//DTD IBMIDDoc//EN\" [\n]>")
;;        ( "DOCBOOK XML 4.1.2"
;; 	 "<?xml version=\"1.0\"?>\n<!DOCTYPE book PUBLIC \"-//OASIS//DTD DocBook XML V4.1.2//EN\" \"http://www.oasis-open.org/docbook/xml/4.0/docbookx.dtd\" [\n]>")
;;        )
;; )
;;
;; (define-key sgml-mode-map "\C-i" 'sgml-insert-element)
; override default validate command to utilize OpenSP's onsgmls executable
;;(setq sgml-validate-command "onsgmls -s %s %s")
; override default xml-mode validate command to utilize OpenSP's onsgmls
; executable by using a mode-hook, since there appears to be no other means
; to accomplish it.
;; (defun my-psgml-xml-hook ()
;;   (setq sgml-validate-command "onsgmls -s %s %s")
;;   (setq sgml-declaration "C:\Progra~1\openjade-1.3.1\pubtext\xml.dcl")
;; )
;; (add-hook 'xml-mode-hook 'my-psgml-xml-hook)
;;
;;
;; -- End psgml / xml section --------


;; --- Begin HTML editing section:
;;
;; See nXML section: using nXML now for HTML editing.
;;
;; I require html helper mode because the hhm-config.el code seems to
;; cause an error if I have both autoloaded.
;;(require 'html-helper-mode "html-helper-mode.el")
;;  (autoload 'html-helper-mode "html-helper-mode.el")
;;  (setq auto-mode-alist (cons '("\\.html$" . html-helper-mode)       auto-mode-alist))
;;  (setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode)        auto-mode-alist))
;;  (setq auto-mode-alist (cons '("\\.phtml$" . html-helper-mode)      auto-mode-alist))
;; --- End HTML editing section.

;; ------ JSP Mode (note: this must come after html-helper-mode is loaded (as it is loaded above)):
;;(require 'jsp-html-helper-mode "jsp-html-helper-mode.el")
;;(setq auto-mode-alist (cons '("\\.jsp$" . jsp-html-helper-mode) auto-mode-alist))

;; ----- CSS mode.
;; This is for the css-mode (will not be necessary in later versions; it should
;; be in the css-mode code itself):
;;(require 'apropos)

;; For css-mode: (from http://synthcode.com/emacs/lang/css-mode.el )
;; I added customizations in that mode file itself to get c-style indenting, per
;; the in-file instructions.  Also I added a newline just after opening braces.
;;(autoload 'css-mode "css-mode.el")
;; (setq auto-mode-alist
;;      (cons '("\\.css$" . css-mode) auto-mode-alist))
;; ----- End CSS mode.

;; ----- Begin Sass Css Mode
;; (require 'sass-mode)
;; ----- End Sass Mode
;; ----- Begin Sass scss flavor Mode
;; (require 'scss-mode)
;; ----- End Sass scss flavor Mode

;; ----- Begin Less Css Mode
(require 'flymake-less)
(add-hook 'less-css-mode-hook 'flymake-less-load)
;; ----- End Less Css Mode

;; Make sure that .emacs file is edited in lisp mode:
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode)        auto-mode-alist))

;; ----- Diary and Appointment Notification Section.
;; There are also some variables set via the Emacs Customization Utility.
;; See the end of the file for those.
;; Read the diary:
(diary)

;; Fancy display for Calendar
;; Here is some code to make your calendar and diary display fancier:
 (setq view-diary-entries-initially t
       mark-diary-entries-in-calendar t
       number-of-diary-entries 7)
 (add-hook 'diary-display-hook 'fancy-diary-display)
 (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Begin mode-line customization:
;; Show column number on mode line.
(column-number-mode t)
;; Show time on mode line, and set appointment notification.
;; (day-and-date)
(display-time)
;; Show the directory of a file or shell buffer in the mode-line ( http://www.emacswiki.org/emacs/ModeLineDirtrack ):
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)
(add-hook 'find-file-hook 'add-mode-line-dirtrack)
;; End mode-line customization.

(add-hook 'diary-hook 'appt-make-list)
(diary 0)

;; Special function to make appointments work:
(defun update-my-calendar ()
  (let ((diary-buffer (get-file-buffer diary-file))
        (number-of-diary-entries 30))
    (if diary-buffer
        (progn
          (set-buffer diary-buffer)
          (revert-buffer t t)))
    (calendar)))

;; - - - General Useful Emacs Switches and Functions Section - - - -
(defun update-aquamacs-visit-website ()
  (interactive)
  "Visits the update page for Aquamacs Emacs."
    (browse-url "http://aquamacs.org/download.shtml")
)

(setq-default transient-mark-mode t)

;; Revision Control
(require 'magit) ;; Git integration: works with the built-in vc-git.

;; Global key maps:
(global-set-key "\C-c\C-v" 'browse-url-of-buffer)
(global-set-key "\C-xU" 'browse-url)
(global-set-key "\C-xP" 'browse-url-at-point)
(global-set-key "\e`" 'search-forward-regexp)
(global-set-key "\e/" 'replace-regexp)
(global-set-key "\C-xtl" 'goto-line)
(global-set-key "\e[" 'enlarge-window)
(global-set-key "\e]" 'shrink-window)
(global-set-key "\e=" 'eval-current-buffer)
(global-set-key "\eg" 'magit-status)

;; Here's some code which is quite handy eg. after doing an update from revision control (i.e., cvs or svn),
;; which results in lots of files being updated. The following function reverts all Emacs file buffers.
;; ( From http://kavaro.com/mediawiki/index.php/Emacs-hacks ).
(defun revert-all-buffers ()
  (interactive)
  (let ((current-buffer (buffer-name)))
    (loop for buf in (buffer-list)
          do
          (unless (null (buffer-file-name buf))
            (switch-to-buffer (buffer-name buf))
            (revert-buffer nil t)))
    (switch-to-buffer current-buffer)
    (message "All buffers reverted!")))


;; Launch a file with \C-&
;;
;; Usually, 'browse-url' works fine.  But for some reason, lately
;; on WinXP (?sp2) I have needed this code.
;;
;; On Unix systems, you'll have to use something like TrivialMode instead.
;;
;; Adapted from http://www.emacswiki.org/cgi-bin/wiki/MsShellExecute
;;
;; On W32 systems, the shell knows what to do with every file
;; because you register the extensions with the explorer.
;;
;; Thus, you can use the following code. It defines a new function,
;; 'w32-browser, to just shell-execute a string. In Windows, this will
;; allow you to edit .doc files, URLs, etc. Just call w32-browser with the filename.
;;
;; Next, there's a keybinding which binds control-x& (or F3 if mapped to [f3])
;; to a call to w32-browser, and
;; it builds a string from the current DiredMode entry.
;; Now you can use cntrl-x& in dired to open any file.
;;

;;(defun w32-browser (doc)
;;  "Browse to a particular file/URL using default web browser"
;;  (w32-shell-execute 1 doc))

;;(eval-after-load "dired"
;;  '(define-key dired-mode-map "\C-x&" (lambda ()
;;				     (interactive)
;;				     (w32-browser
;;				      (dired-replace-in-string
;;				       "/" "\\"
;;				       (dired-get-filename))))))


;; These two key bindings are for up and down scrolling by a either single line at a time
;; or by N lines at a time (default is scroll by one single line at a time).  This is
;; very useful when working with narrow horizontal windows.  ;~)
;; To enter the desired N, hold down \C and type the number and then hit z or q, all the
;; while holding down \C.
;; From the "Writing GNU Emacs Extensions" book, by Bob Glickstein.
(defun scroll-n-lines-up (&optional n)
  "Scroll up N lines (1 line by default)."
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(defun scroll-n-lines-down (&optional n)
  "Scroll down N lines (1 line by default)."
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))

(global-set-key "\C-q" 'scroll-n-lines-up)
(global-set-key "\C-z" 'scroll-n-lines-down)


;; These two bindings make it easier to find a mismatched parenthesis:
(global-set-key "\e'" 'forward-sexp)
(global-set-key "\e;" 'backward-sexp)

;;; Bracket/brace/parentheses highlighting:
   ;; The following is the command for Emacs 20.1 and later:
(show-paren-mode 1)

;; Makes the C-x% keybinding show the matching parenthesis (smooth, curly, or square braket).
;;    - http://www.emacswiki.org/emacs/ParenthesisMatching
(global-set-key "\C-x%" 'goto-match-paren)
(defun goto-match-paren (arg)
  "Go to the matching parentheses if on (), {}, or [] "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

;; Windows only: The following functions enable on-the-fly switching between the bash shell and DOS:

;; (defun set-shell-bash()
;;   (interactive)
;;   ;; (setq binary-process-input t)
;;   (setq shell-file-name "bash")
;;   (setq shell-command-switch "-c")
;;   (setq explicit-shell-file-name "bash")
;;   (setenv "SHELL" explicit-shell-file-name)
;;   (setq explicit-sh-args '("--login" "--init-file" "c:/home/cbalz/.bash_profile" "-i"))
;;   (setq w32-quote-process-args ?\")
;;   (setq mswindows-quote-process-args t)
;;   )

;; (defun set-shell-cmdproxy()
;;   (interactive)
;;   (setq shell-file-name "cmdproxy")
;;   (setq explicit-shell-file-name "cmdproxy")
;;   (setenv "SHELL" explicit-shell-file-name)
;;   (setq explicit-sh-args nil)
;;   (setq w32-quote-process-args nil)
;;   )

;; (global-set-key "\C-xg" 'set-shell-bash) ;; g for Gnu (\C-xb is used for buffer switch command).
;; (global-set-key "\C-xd" 'set-shell-cmdproxy)
;; End shell-switch on-the-fly.


;; Begin move-to-window block:
;; This code is from the O'Reilly "GNU Emacs Extensions" book.
;; The purpose of it is to make a reasonable way to move to the next OR previous window.
;; Change from C-x o to C-x n, so that we have Next and Previous.
(global-set-key "\C-xn" 'other-window)

;; We must make our own function to go to the previous window (but it's simple):
(defun other-window-backward ()
  "Select the previous window."
  (interactive)
  (other-window -1))
;; Now we can bind to this function:
(global-set-key "\C-xp" 'other-window-backward)
;; End move to window block.

;; This turns on the buffer select list in the minibuffer to make it easy to
;; edit any buffer in a given window or frame (C-r and C-s move backwards and forwards, respectively,
;; through the buffer select list).
;;   - - - - Begin for old Emacs ( < Emacs 24.6 )
;; (require 'iswitchb)
;; (iswitchb-default-keybindings) ;; not available on emacs 24.6:
;;   - - - - End for old Emacs ( < Emacs 24.6 )
(iswitchb-mode 1)

;; Set a high recursion limit for parsing the long java files:
(setq max-specpdl-size 1000)

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

;; Adjust the colors and fonts to preference:
(set-default-font "-adobe-courier-*-*-*-*-12-*-*-*-*-*-*-*") ;; Unix, if that font is present.
;; (set-default-font "Fixedsys") ;; Windows.
(set-cursor-color "Deep Pink")
(set-face-foreground 'highlight "blue")
(set-face-background 'highlight "red")
(set-foreground-color "Green")
(set-background-color "Gray10")
;; Aquamacs: To change the initial frame, you can modify initial-frame-alist
(setq initial-frame-alist '((background-color . "Gray10") (left . 50)  ))                          ;; Required for Aquamacs only, but works on straight OS X Emacs builds too.
;; Preventing Aquamacs from changing those properties when opening additional windows
(setq default-frame-alist '((background-color . "Gray10") (left . 0) (width . 141) (height . 44))) ;; Required for Aquamacs only, but works on straight OS X Emacs builds too.
(set-face-foreground 'font-lock-function-name-face "Turquoise")
(set-face-foreground 'font-lock-keyword-face "Yellow")
(set-face-foreground 'font-lock-string-face "Magenta")
(set-face-foreground 'font-lock-variable-name-face "Coral")
(set-face-attribute 'mode-line nil
   :foreground "yellow"
   :background "purple4")
;;(Set-face-foreground 'modeline "yellow")   ;; For < Emacs 24.6; Doesn't work on Emacs 24.6
;;(set-face-background 'modeline "purple4")  ;; For < Emacs 24.6; Doesn't work on Emacs 24.6
(set-face-background 'region "MidnightBlue")
(set-face-background 'secondary-selection "dodger blue")
(set-face-foreground 'diary-face "Yellow")
(set-face-background 'holiday-face "Pink")
(set-face-foreground 'holiday-face "Red")
(set-mouse-color "yellow")

;; The following settings pertain to features that you may not have installed on your GNU Emacs:
  ;; Begin speedbar section (Values set via Emac's 'Customize' interface are found at the
  ;; bottom of the file, and hence if there is a 'conflict' they override these values).
;; (set-face-foreground 'speedbar-directory-face "Green")
;; (set-face-background 'speedbar-directory-face "Black")
;; (set-face-foreground 'speedbar-highlight-face "DarkSlateGray")
;; (set-face-background 'speedbar-highlight-face "Gold")
;; (set-face-background 'speedbar-file-face "MidnightBlue")
;; (set-face-foreground 'speedbar-file-face "Gold")
;; (set-face-foreground 'speedbar-tag-face "Orange")
;; Set the speedbar pop-up window properties: Note that if the speedbar height is too
;; great, the windowing-system's title bar for the
;; speedbar window (at least on Windows2000) will not show completely.
(setq speedbar-frame-parameters '((width . 30)
								  (height . 45)
								  (foreground-color . "green")
								  (background-color . "black")))
  ;; End speedbar section.

  ;; You may not want the following line if you do not have paren-matching running:
(set-face-foreground 'show-paren-match-face "Red")
  ;; The following line is only if you have semantic installed:
;; doesn't work for semantic-1.4beta5 (set-face-foreground 'semantic-intangible-face "Gold")
  ;; The following line is only if you have the JDE installed:
;;(set-face-foreground 'jde-java-font-lock-link-face "Gold")

;; - - - - End General Emacs Switches and Functions Section - - - -



;;  ---------  This is SGML colorizing with the psgml package, loaded above.

;;; Set up and enable syntax coloring.
; Create faces  to assign markup categories.
(make-face 'sgml-doctype-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-comment-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-start-tag-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-attribute-face)

; Assign attributes to faces.
(set-face-foreground 'sgml-doctype-face "yellow")
(set-face-foreground 'sgml-sgml-face "cyan1")
(set-face-foreground 'sgml-pi-face "magenta")
(set-face-foreground 'sgml-comment-face "purple")
(set-face-foreground 'sgml-start-tag-face "deep sky blue")
(set-face-foreground 'sgml-end-tag-face "white")
(set-face-foreground 'sgml-entity-face "orange")

; Assign faces to markup categories.
(setq sgml-markup-faces
      '((doctype	. sgml-doctype-face)
	(pi		. sgml-pi-face)
	(comment	. sgml-comment-face)
	(sgml	. sgml-sgml-face)
	(comment	. sgml-comment-face)
	(start-tag	. sgml-start-tag-face)
	(end-tag	. sgml-end-tag-face)
	(entity	. sgml-entity-face)))


; PSGML - enable face settings
(setq sgml-set-face t)

;; ;; ---- End psgml highlighting section.

;; Gnus: using only for mail.
(setq gnus-select-method '(nntp "news.statesoftware.com"))
(add-hook 'nntp-server-opened-hook 'nntp-send-authinfo)

;; This checks to see if you've set the variable startup-directory and checks to
;; see if you've set it to a real directory.  If so, it will switch there.
(let ((working-directory (or startup-directory nil)))
  (if (and (and working-directory)
    (file-directory-p working-directory))
      (cd working-directory)))

;; ---------- Begin Global Whitespace Section

;; Make sure that tabs are being used (default behavior, but doesn't hurt in case something got changed):
;; (setq indent-tabs-mode t)
;; Make sure that no tab characters are used:
(setq indent-tabs-mode nil)

;; Set the variable default-tab-width.
(setq default-tab-width 4)

;; auto-fill-mode seems to have been turned on by default now in far more places than one would want.
(auto-fill-mode -1)

;; Remove trailing whitespace to avoid extraneous diff results:
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; ---------- End Global Whitespace Section

;; This enables saving the current desktop on shutdown.  The ESC-x desktop-save
;; command must be given once for this to work in perpetuity.
(desktop-save-mode 1)
;; This will save the desktop when Emacs is idle, giving some protection against
;; losing your desktop to a crash.
(add-hook 'auto-save-hook (lambda () (desktop-save-in-desktop-dir)))

;; --------- ** My custom hand-entered additions end here. **

;; --------- ** Begin Auto-written Emacs Customization Section **

;; The following has been automatically written by the Emacs customization utility:
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "red" "green" "yellow" "pink" "magenta" "cyan" "white"])
 '(appt-message-warning-time 60 t)
 ;; '(browse-url-browser-function (quote browse-url-firefox-new-tab)) ;; Not needed for Aquamacs
 ;;'(browse-url-generic-program "~/utils/firefox/firefox")
 '(calculator-number-digits 10)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(dired-recursive-deletes (quote top))
 '(display-time-mode t)
 '(font-use-system-font t)
 '(frame-background-mode nil)
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(mail-host-address "")
 '(midnight-delay 34200)
 '(midnight-hook (quote (update-my-calendar)))
 '(midnight-mode t nil (midnight))
 '(printer-name "USB001")
 '(show-paren-mode t nil (paren))
 '(smtpmail-default-smtp-server "smtp.earthlink.net")
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images t)
 '(standard-indent 4)
 '(uniquify-buffer-name-style nil nil (uniquify))
 '(user-full-name "Christopher M. Balz")
 '(which-function-mode nil nil (which-func)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(speedbar-button-face ((t (:background "black" :foreground "deep sky blue"))))
 '(speedbar-file-face ((t (:background "black" :foreground "yellow1"))))
 '(speedbar-selected-face ((((class color) (background dark)) (:background "black" :foreground "red" :underline t))))
 '(speedbar-tag-face ((t (:background "black" :foreground "Orange")))))
