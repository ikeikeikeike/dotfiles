;; load-path
					;(setq load-path (cons "~/.emacs.d/elisp" load-path))
;;====================
;; General
;;====================
;; load-pathを追加
(setq load-path (append
                 '("/Applications/Emacs.app/Contents/Resources/site-lisp"
		   "~/.emacs.d/elisp"
		   "~/.emacs.d/auto-install"
		   "~/.emacs.d/init"
		   )
                 load-path))

(setq exec-path (append
                 '("/opt/local/bin"
                   "/usr/bin" "/bin"
                   "/usr/sbin" "/sbin" "/usr/local/bin"
                   "/usr/X11/bin" "/opt/local/bin" "/opt/local/bin")
                 exec-path))

;; テキストエンコーディングとしてUTF-8を優先使用
(prefer-coding-system 'utf-8)

(require 'install-elisp)
;; install-elisp-reposirory
(setq install-elisp-repository-directory "~/.emacs.d/elisp")
(setq mac-option-modifier 'meta)

;; zshを使う
(setq shell-file-name "/opt/local/bin/zsh")

;; 関連パッケージインストールバッジ
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)	; 互換性確保

;; anything関連ロード
(require 'anything-startup)
;; anything config
(require 'anything-config)
(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-recentf
                             anything-c-source-file-name-history
                             anything-c-source-locate))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)

;; 画面分割時defaultが左右に画面分割
(defun my-horizontally-split-window (buf)
  (delete-other-windows)
  (split-window-horizontally)
  (funcall (if anything-samewindow 'switch-to-buffer 'pop-to-buffer) buf))
(setq anything-display-function 'my-horizontally-split-window)

;; mmm-mode
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face "#333333")
;; html系
(mmm-add-classes
 '((mmm-html-css-mode
    :submode css-mode
    :face mmm-code-submode-face
    :front "<style[^>]*>\\([^<]*\\)?\n[ \t]*</style>"
    )

;;    (html-php
;;     :submode php-mode
;;     :front "<\\?\\(php\\)?"
;;     :back "\\?>"
;;     )

   (mmm-html-javascript-mode
    :submode javascript-mode
    :face mmm-code-submode-face
    :front "<script[^>]*>\\([^<]*\\)?</script>"
    :back "</script>"
    )

   (mmm-ml-css-mode
    :submode css-mode
    :face mmm-code-submode-face
    :front "<style[^>]*>"
    :back "\n?[ \t]*</style>"
    )

   (mmm-ml-javascript-mode
    :submode javascript-mode
    :face mmm-code-submode-face
    :front "<script[^>]*>[^<]"
    :front-offset -1
    :back "\n?[ \t]*</script>"
    )

   (mmm-mxml-actionscript-mode
    :submode actionscript-mode
    :face mmm-code-submode-face
    :front "<mx:Script><!\\[CDATA\\["
    :back "[ \t]*\\]\\]></mx:Script>"
    )
   ))
(mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
(mmm-add-mode-ext-class 'sgml-mode nil 'mmm-html-css-mode)
(mmm-add-mode-ext-class 'sgml-mode nil 'mmm-html-javascript-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-ml-css-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-ml-javascript-mode)
(mmm-add-mode-ext-class 'xml-mode nil 'mmm-mxml-actionscript-mode)
;; 開いてるバッファをmmm-modeでパースしなおし
(global-set-key [f8] 'mmm-parse-buffer)

;; mmm-mode in php
;; (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
;; (mmm-add-classes
;;  '((html-php
;;     :submode php-mode
;;     :front "<\\?\\(php\\)?"
;;     :back "\\?>")))
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . nxhtml-mode))

;; ;; うまく動かんちょっとしゅうせいが必要かも html nxhtml
;; (load-library "autostart")
;; (custom-set-variables
;;  '(indent-region-mode t)
;;  '(nxhtml-global-minor-mode t)
;;  '(nxhtml-global-validation-header-mode t)
;;  '(nxhtml-skip-welcome t))
;; (custom-set-faces)

;; Auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(require 'ac-company)
;; 対象の全てで補完を有効にする
(global-auto-complete-mode t)

;; php-complete
;; php-mode
;; 設定例
(load-library "php-mode")
(require 'php-mode)
(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))

;; php  auto-complete
(add-hook  'php-mode-hook
           (lambda ()
	     (setq php-mode-force-pear t)
	     (setq php-manual-path "/usr/local/share/php/doc/html")
	     (setq php-manual-url "http://www.php.net/manual/ja/")
	     (c-set-style "stroustrup")
             (setq tab-width 4)
             (setq c-basic-offset 4)
	     (setq indent-tabs-mode t)
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources 'ac-source-php-completion)
               (auto-complete-mode t))))

;; javascript mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|json\\|jsn\\|htc\\)\\'" 'js2-mode))
;;下は好みで tab幅を4にする設定
(add-hook 'js2-mode-hook
          (function
           (lambda ()
             (setq tab-width 4)
             (setq javascript-indent-level 4)
             (setq javascript-basic-offset tab-width)
             )))

;; nxhtml
	
;; css-mode
(autoload 'css-mode "css-mode" nil t)
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
(setq css-indent-level 4)

;; apache-mode
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))

;; dsvn subversion
					;(autoload 'svn-status "dsvn" "Run `svn status'." t)
					;(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; 行数表示
(line-number-mode t)
;; goto-line
(global-set-key "\C-xl" 'goto-line)

;; wondowをmac UI
(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
	    (lambda ()
	      (setq mac-autohide-menubar-on-maximize t)
	      ;; (set-frame-parameter nil 'fullscreen 'fullboth)
	      )))

;; full screen
(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))
(global-set-key "\C-cm" 'mac-toggle-max-window)

;; Carbon Emacsの設定で入れられた. メニューを隠したり．
(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces)

;; Color
(if window-system (progn
		    (set-background-color "Black")
		    (set-foreground-color "LightGray")
		    (set-cursor-color "Gray")
		    (set-frame-parameter nil 'alpha 80)
		    ))

;; Macのキーバインドを使う
					;(mac-key-mode 1)

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; 対応する括弧を光らせる。
(show-paren-mode 1)

;; 編集行のハイライト
(global-hl-line-mode)

;; ElScreenの有効化
(require 'elscreen)
;; PrefixキーをC-zに割り当て
(elscreen-set-prefix-key "\C-z")
(if window-system
    (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; linum.el(行番号の表示)
(require 'linum)
;; デフォルトでONにする
(global-linum-mode 1)
;; F5キーにON/OFFの切り替えを割り当てる
(global-set-key [f5] 'linum-mode)
;; 5桁とスペースの領域を割り当てる
(setq linum-format "%5d ")

;; jaspaceを有効化
(require 'jaspace)
;; 全角空白を表示させる
(setq jaspace-alternate-jaspace-string "□")

;; タブを表示
(setq jaspace-highlight-tabs t)

;; フック
(add-hook 'text-mode-hook 'jaspace-mode)

;; backup dir
(setq backup-directory "~/.emacs.d/backup")
(if (and (boundp 'backup-directory)
	 (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
	    (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
	(if (file-directory-p backup-directory)
	    (concat backup-directory "/" (file-name-nondirectory filename))
	  (make-backup-file-name-original filename)))))
;;;終了時に自動生成されたオートセーブファイルを削除行う
(setq delete-auto-save-files t)

;; back space
(global-set-key "\C-h" 'delete-backward-char)

;; undo redo
;; C-_がうまくうごかないのでデフォルトのキーバインドを無効にするのを試す
(when (require 'redo+ nil t)
  (define-key ctl-x-map (if window-system "U" "r") 'redo)
  (define-key global-map  [?\C-?] 'redo))
					;(define-key global-map  [?\C-\S-/] 'redo)
					;(define-key global-map "\C-\S-/" 'redo)
					;(define-key global-map "\C-\S-_" 'redo)) )
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
;; undo tree 
(require 'undo-tree)
(global-undo-tree-mode)

;; one Key 使い方わからん
(require 'one-key)
(require 'one-key-default)   ; one-key.el も一緒に読み込んでくれる
(require 'one-key-config)    ; one-key.el をより便利にする
(one-key-default-setup-keys) ; one-key- で始まるメニュー使える様になる
					;(define-key global-map "\C-x" 'one-key-menu-C-x) ;; C-x にコマンドを定義

;; C-tで画面分割連続押しでフォーカス移動
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

;; grep系keyバインド
(global-set-key [?\C-c?\C-\S-g] 'anything-project-grep)
(global-set-key "\C-c\C-g" 'anything-grep)

;; anything-frep list
					;(setq anything-grep-alist
;; 全バッファのファイル名においてegrepをかける。moccurの代わり。
					;      '(("buffers" ("egrep -Hin %s $buffers" "/"))
;; ~/ 以下から再帰的にegrepをかける。不要なファイルは除かれる。
					;	("home" ("ack | xargs egrep -Hin %s" "~/"))
;; /usr/loacal/share/php/doc から *.html に対してegrepをかける。
					;	("phpdoc" ("egrep -Hin %s *.html" "/usr/loacal/share/php/doc/"))
;; ~/ruby以下の全Rubyスクリプトと~/bin以下のファイルをまとめて検索する。
					;	("~/bin and ~/ruby"
					;	 ("ack -afG 'rb$' | xargs egrep -Hin %s" "~/ruby")
					;	 ("ack | xargs egrep -Hin %s" "~/bin"))
;; ~/smartacademy/ferris 以下から再帰的に 文字列検索 ark をかける。不要なファイルは除かれる。
					;	("ferris" ("ack %s" "~/smartacademy/ferris"))))

;; anything-grep-alistでやりたいことがこれでおkなので上記はコメント
;; ディレクトリは検索からのぞく設定
(require 'anything-project)
(setq ap:project-files-filters
      (list
       (lambda (files)
	 (remove-if 'file-directory-p files))))

;; file検索
(global-set-key [?\C-c?\C-r] 'anything-project)

;; [M-a]で最後に編集した箇所へ辿る
;; [M-e]で編集箇所を逆方向に辿る
;; うまく動かん一度でフォルトのキーバインドを無効にする必要がある
;; http://www.emacswiki.org/cgi-bin/wiki/goto-chg.el
(require 'goto-chg)
(global-set-key (kbd "M-a") 'goto-last-change)
(global-set-key (kbd "M-e") 'goto-last-change-reverse)

;; M-a M-e を M-n M-p に当てる
;; (global-set-key (kbd "M-p") 'backward-sentence)
;; (global-set-key (kbd "M-n") 'forward-sentence)

;; 画面文字折り返し
(setq truncate-partial-width-windows nil)

;; session
(require 'session)
(desktop-save-mode 1)

;; desktop file
;; setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.diary$\\)")
;; (autoload 'desktop-save "desktop" nil t)
;; (autoload 'desktop-clear "desktop" nil t)
;; (autoload 'desktop-load-default "desktop" nil t)
;; (autoload 'desktop-remove "desktop" nil t)
;; (desktop-read)
;; (add-hook 'kill-emacs-hook 'desktop-save-in-desktop-dir)

;; 以前編集していた場所にフォーカスを当てる
(load "saveplace")
(setq-default save-place t)

;; タブをタブとして消す
(global-set-key [backspace] 'backward-delete-char)
 
;; マウスのホイールスクロールスピードを調節
;; (連続して回しているととんでもない早さになってしまう。特にlogicoolのマウス)
(global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 2)))

(setq c-tab-always-indent t)   ; [TAB］キーでインデント実施

;; C-aで文頭に移動
(defun beggining-of-physical-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。
ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (let ((line
         (save-excursion
           (buffer-substring-no-properties
            (progn (physical-line-beginning-of-line) (point))
            current-point)))
        (phys-line-head-pos
         (save-excursion
           (progn (physical-line-beginning-of-line) (point))))
        (line-head-pos
         (save-excursion
           (progn (beginning-of-line) (point)))))
    (if (or (not (eq phys-line-head-pos line-head-pos))
            (string-match "^[ \t]+$" line))
        (physical-line-beginning-of-line)
      (back-to-indentation))))
(global-set-key "\C-a" 'beggining-of-physical-indented-line )

;; C-kで行全体を削除
(setq kill-whole-line t)
(global-set-key "\C-k" 'kill-whole-line)

;; カーソル移動を物理行単位に
(require 'physical-line)
(setq-default physical-line-mode t)
					; dired-modeは論理行移動のままにする
(setq physical-line-ignoring-mode-list '(dired-mode))

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; for shell-mode

;;C-c cで選択範囲をコメントorコメントアウトn
(global-set-key "\C-cc" 'comment-or-uncomment-region)

;;yes/noをy/nに変換
(fset 'yes-or-no-p 'y-or-n-p)

;;set default browser
(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)

;; コピペ summery表示
(global-set-key "\M-y" 'anything-show-kill-ring)

;; ssh root とか sshが重いかも
(require 'tramp)

;; gtags
(require 'gtags)
;; (define-key gtags-mode-map "\M-," 'gtags-find-tag)
(define-key gtags-mode-map "\M-," 'gtags-find-rtag)
(define-key gtags-mode-map (kbd "C-.") 'gtags-find-symbol)
(define-key gtags-mode-map "\M-r" 'gtags-pop-stack)
(add-hook 'php-mode-hook
          (lambda ()
            (gtags-mode 1)
            (setq gtags-libpath `((,(expand-file-name "~/.tags/php") . "/opt/local/lib/php")
                                  (,(expand-file-name "~/.tags/php_zend") . "/var/www/Zend/ZendFramework-1.10.1-minimal/library")))))
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (gtags-mode 1)
;;             (setq gtags-libpath `((,(expand-file-name "~/.tags/c") . "/usr/include")))))
;; (add-hook 'java-mode-hook
;;           (lambda ()
;;             (gtags-mode 1)
;;             (setq gtags-libpath `((,(expand-file-name "~/.tags/haxe") . "/usr/local/haxe")))))
;; (add-hook 'gud-mode-hook
;;           (lambda ()
;;             (gtags-mode 1)))
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (gtags-mode 1)
;;             (setq gtags-libpath `((,(expand-file-name "~/.tags/ruby") . "/usr/lib/ruby/1.8")))))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (gtags-mode 1)
;;             (setq gtags-libpath `((,(expand-file-name "~/.tags/python") . " /usr/lib/python2.5")))))

;; auto-complete-gtags
(require 'auto-complete-gtags)

;; anything-gtags
(require 'anything-gtags) 
(global-set-key (kbd "C-,") 'anything-gtags-select)
(global-set-key (kbd "C-<") 'anything-gtags-resume)

;; dired::本日変更ファイルを強調
;; (defface my-face-f-2 '((t (:foreground "GreenYellow"))) nil)
;; (defvar my-face-f-2 'my-face-f-2)
;; (defun my-dired-today-search (arg)
;;   "Fontlock search function for dired."
;;   (search-forward-regexp
;;    (concat (format-time-string "%b %e" (current-time)) " [0-9]....") arg t))
;; (add-hook 'dired-mode-hook
;;           '(lambda ()
;;              (font-lock-add-keywords
;;               major-mode
;;               (list
;;                '(my-dired-today-search . my-face-f-2)

;; load-init
(load "init-flymake")
