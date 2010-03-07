;;; flymake
(when (require 'flymake nil t))
(global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
;;(global-set-key "\C-cd" 'credmp/flymake-display-err-minibuf)
(defface my-face-spc-at-eol  '((t (:foreground "Red" :underline t))) nil :group 'my-faces)
(custom-set-faces
 '(flymake-errline ((((class color)) (:foreground "Red" :underline t))))
 '(flymake-warnline ((((class color)) (:foreground "Red" :underline t)))))

;; flymake 現在行のエラーをpopup.elのツールチップで表示する
(require 'popup)
(defun flymake-display-err-menu-for-current-line ()
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no))))
    (when line-err-info-list
      (let* ((count (length line-err-info-list))
             (menu-item-text nil))
        (while (> count 0)
          (setq menu-item-text (flymake-ler-text (nth (1- count) line-err-info-list)))
          (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (line (flymake-ler-line (nth (1- count) line-err-info-list))))
            (if file
                (setq menu-item-text (concat menu-item-text " - " file "(" (format "%d" line) ")"))))
          (setq count (1- count))
          (if (> count 0) (setq menu-item-text (concat menu-item-text "\n")))
          )
        (popup-tip menu-item-text)))))

;; PHP
(when (not (fboundp 'flymake-php-init))
  ;; flymake-php-initが未定義のバージョンだったら、自分で定義する
  (defun flymake-php-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         (quote flymake-create-temp-inplace)))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list "php" (list "-f" local-file "-l"))))
  (setq flymake-allowed-file-name-masks
        (append
         flymake-allowed-file-name-masks
         (quote (("\\.php[345]?$" flymake-php-init)))))
  (setq flymake-err-line-patterns
        (cons
         (quote ("\\(\\(?:Parse error\\|Fatal error\\|Warning\\): .*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil 1))
	 flymake-err-line-patterns)))
(add-hook (quote php-mode-hook)
	  (quote (lambda() (flymake-mode t))))

;;; html
(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "tidy" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.html$\\|\\.ctp" flymake-html-init))

(add-to-list 'flymake-err-line-patterns
             '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
               nil 1 2 4))
(add-hook 'nxml-mode-hook 'flymake-mode)

;;; emacs lisp エラーが出るからコメントアウト
;; (defun flymake-elisp-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "elisplint" (list local-file))))
;; (push '("\\.el$" flymake-elisp-init) flymake-allowed-file-name-masks)
;; (add-hook 'emacs-lisp-mode-hook 'flymake-mode)

;; JavaScript用設定
(when (not (fboundp (quote flymake-javascript-init)))
  ;; flymake-javascript-initが未定義のバージョンだったら、自分で定義する
  (defun flymake-javascript-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       (quote flymake-create-temp-inplace)))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      ;;(list "js" (list "-s" local-file))
      (list "jsl" (list "-process" local-file))
      ))
  (setq flymake-allowed-file-name-masks
	(append
	 flymake-allowed-file-name-masks
	 (quote (("\.json$" flymake-javascript-init)
		 ("\.js$" flymake-javascript-init)))))
  (setq flymake-err-line-patterns
	(cons
	 (quote ("\(.+\)(\([0-9]+\)): \(?:lint \)?\(\(?:warning\|SyntaxError\):.+\)" 1 2 nil 3))
	 flymake-err-line-patterns)))
(add-hook (quote javascript-mode-hook)
	  (quote (lambda() (flymake-mode t))))

;;; Perl
;; http://unknownplace.org/memo/2007/12/21#e001
;; (defvar flymake-perl-err-line-patterns
;;   '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

;; (defconst flymake-allowed-perl-file-name-masks
;;   '(("\\.pl$" flymake-perl-init)
;;     ("\\.pm$" flymake-perl-init)
;;     ("\\.t$" flymake-perl-init)))

;; (defun flymake-perl-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "perl" (list "-wc" local-file))))

;; (defun flymake-perl-load ()
;;   (interactive)
;;   (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;     (setq flymake-check-was-interrupted t))
;;   (ad-activate 'flymake-post-syntax-check)
;;   (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
;;   (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
;;   (set-perl5lib)
;;   (flymake-mode t))

;; (add-hook 'cperl-mode-hook 'flymake-perl-load)


;; ;;; fuzzy pair
;; (defun flymake-fuzzy-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "fuzzylint" (list local-file))))
;; (push '("\\.ctp$" flymake-fuzzy-init) flymake-allowed-file-name-masks)

;; ;;(add-hook 'nxml-mode-hook 'flymake-mode)

;; ;;; Ruby
;; ;; Invoke ruby with '-c' to get syntax checking
;; (defun flymake-ruby-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))
;; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; (add-hook 'ruby-mode-hook '(lambda ()
;;                              ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
;;                              (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;;                                  (flymake-mode))))

;;http://www.credmp.org/2007/07/20/on-the-fly-syntax-checking-java-in-emacs/
;; (defun credmp/flymake-display-err-minibuf ()
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no (flymake-current-line-no))
;;          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count (length line-err-info-list))
;;          )
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)
;;           )
;;         )
;;       (setq count (1- count)))))

;; when buffer-file-name is nil.
(defadvice flymake-mode (around check-buffer-file-name-exists activate)
  (when buffer-file-name
    ad-do-it))