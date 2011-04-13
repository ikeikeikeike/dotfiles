;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
	      "/opt/local/sbin"
	      "/usr/local/sbin"
	      "/Developer/usr/sbin/"
              "/bin"
              "/usr/bin"
	      "/opt/local/bin"
	      "/usr/local/bin"
	      "/usr/X11/bin"
	      "/Developer/usr/bin/"
	      "/opt/local/apache2/bin"
	      "/opt/local/lib/mysql5/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
  ;; PATH と exec-path に同じ物を追加します
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/bin/man:/usr/local/man:/opt/local/man:/usr/share/man:/usr/X11/man:/Developer/usr/share/man" (getenv "MANPATH")))

;; shell の存在を確認 順に探して最初にみつかったshellを使用
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; 文字コードの設定
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

;; Mac OS X では utf-8 だと日本語のファイル名を利用すると正常に処理できなくなるので utf-8-hfs を利用します。
(cond
 (t (eq window-system 'mac) (eq window-system 'ns)
     ;; Mac OS X の HFC+ ファイルフォーマットではファイル名は NFD (の様な物)で扱うため以下の設定をする必要がある
     (require 'ucs-normalize)
     (setq file-name-coding-system 'utf-8-hfs)
     (setq locale-coding-system 'utf-8-hfs))

 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)))

;; 4m のような文字が付与されないように Emacs が保持する terminfo を利用す
;;(setq system-uses-terminfo nil)

;; エスケープを綺麗に表示する
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(require 'multi-term)
(setq multi-term-program shell-file-name)
(add-to-list 'term-unbind-key-list '"M-x")
(add-hook 'term-mode-hook
	  '(lambda ()
	     ;; C-h を term 内文字削除にする
	     (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
	     ;; C-y を term 内ペーストにする
	     (define-key term-raw-map (kbd "C-y") 'term-paste)
	     ))
(global-set-key (kbd "C-c t") '(lambda ()
				 (interactive)
				 (if (get-buffer "*terminal<1>*")
				     (switch-to-buffer "*terminal<1>*")
				   (multi-term))))

(require 'shell-pop)
;; multi-term に対応
(add-to-list 'shell-pop-internal-mode-list '("multi-term" "*multi-term*" '(lambda () (multi-term))))
(shell-pop-set-internal-mode "multi-term")
;; frame の高さからサイズを決定 数字を変更してください
(defvar shell-pop-window-height-percent 50.0)
(shell-pop-set-window-height (truncate (* (frame-height)
                                          (/ shell-pop-window-height-percent
                                             100.0))))
(shell-pop-set-internal-mode-shell shell-file-name)
;; ショートカットも好みで変更してください
(global-set-key [f9] 'shell-pop)
