;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
(eval-when-compile (require 'cl))
(unless (fboundp 'cl-flet)
  (define 'cl-flet 'flet))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ~/.emacs.d/site-lisp/ 以下を全て読み込み
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ~/.emacs.d/inits/ 以下を全て読み込み
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; load-path の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path
      (append
       (list
    (expand-file-name "~/.emacs.d")
    (expand-file-name "~/.emacs.d/color-theme")
    (expand-file-name "~/.emacs.d/packages")
    (expand-file-name "~/.emacs.d/plugins")
    (expand-file-name "~/.emacs.d/elisp"))
       load-path))

;; [TODO] - 整理する
;;  google-translate
(require 'google-translate)
(global-set-key (kbd "C-x t") 'google-translate-at-point)
;; 翻訳のデフォルト値を設定(en -> ja)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" default)))
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(rspec-use-rake-when-possible nil)
 '(yas-trigger-key "TAB"))

;;; c-mode
(setq-default c-basic-offset 4     ;;基本インデント量4
              tab-width 4          ;;タブ幅4
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか

;; C++ style
(defun add-c++-mode-conf ()
  (c-set-style "stroustrup")  ;;スタイルはストラウストラップ
  (show-paren-mode t))        ;;カッコを強調表示する
(add-hook 'c++-mode-hook 'add-c++-mode-conf)

;; C style
(defun add-c-mode-common-conf ()
  (c-set-style "stroustrup")                  ;;スタイルはストラウストラップ
  (show-paren-mode t)                         ;;カッコを強調表示する
  )
(add-hook 'c-mode-common-hook 'add-c-mode-common-conf)

;;;ido
(require 'ido)
(ido-mode t)

;;;rinari
(require 'rinari)

;;;highlight-indentation
(require 'highlight-indentation)
(setq highlight-indentation-offset 2)
(set-face-background 'highlight-indentation-face "#696969")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
(add-hook 'ruby-mode-hook 'highlight-indentation-mode)
(highlight-indentation-mode)

;;;git-gutter
(require 'git-gutter)
(global-git-gutter-mode t)
(define-key global-map (kbd "C-x g") 'git-gutter:toggle)
(setq git-gutter:window-width 2)

(setq git-gutter:modified-sign " ")
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign "-")

(set-face-foreground 'git-gutter:modified "blue")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(add-hook 'ruby-mode-hook '(lambda ()
                             (require 'rcodetools)
                             (require 'anything-rcodetools)
                             (require 'myrurema)
                             (load-auto-complete)
                             (define-key ruby-mode-map "\M-c" 'rct-complete-symbol)
                             (define-key ruby-mode-map "\M-d" 'xmp)
                             (setq ruby-deep-indent-paren-style nil)))

(defun ruby-mode-hook-init ()
  "avoid auto insert encoding pragma"
  (remove-hook 'before-save-hook 'ruby-mode-set-encoding)
  (define-key ruby-mode-map (kbd "C-c e") 'my-ruby-mode-set-encoding))

(add-hook 'ruby-mode-hook 'ruby-mode-hook-init)

(defun my-ruby-mode-set-encoding ()
  "set-encoding ruby-mode"
  (interactive)
  (ruby-mode-set-encoding))

;; magic-comment を無効にする
(setq ruby-insert-encoding-magic-comment nil)

;;;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(defun load-auto-complete()
  (require 'auto-complete-config)
  (ac-config-default)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")

  (setq ac-use-menu-map t)
  (define-key ac-menu-map "\C-n" ac-next)
  (define-key ac-menu-map "\C-p" ac-previous)

  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)

  (robe-mode)
  )

;;; robe-mode
(require 'robe)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
(add-hook 'robe-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'robe-ac-setup)
(add-hook 'robe-mode-hook 'inf-ruby-keys)

;; flymake-coffee
(require 'flymake-coffee)

;;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; tern
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))

;;; markdown-mode
(require 'markdown-mode)

;; smart-compile
(require 'smart-compile)
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;; rbenv でインストールした ruby を smart-compile で使う
;; TODO - PATH の見直し
(setenv "PATH" (concat (expand-file-name "~/.rbenv/shims:") (getenv "PATH")))

;;; yasnippet
(require 'yasnippet)

;; helm-c-yasnippet
(require 'helm-c-yasnippet)

;; yasnippet-bundle
(require 'yasnippet-bundle)

(yas/initialize)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas/global-mode 1)

;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか

;; 既存スニペットを挿入する
(define-key yas/minor-mode-map (kbd "C-x i i") 'yas/insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas/minor-mode-map (kbd "C-x i n") 'yas/new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas/minor-mode-map (kbd "C-x i v") 'yas/visit-snippet-file)

;; flymake
(when (locate-library "flymake")
  (require 'flymake)

  ;;シンタックスチェックは次のコマンドが呼ばれる
  ;;make -s -C . CHK_SOURCES=hoge.cpp SYNTAX_CHECK_MODE=1 check-syntax
  ;;
  ;; Makefile があれば、次のルールを追加
  ;;PHONY: check-syntax
  ;;#check-syntax:
  ;;#$(CC) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)
  ;;
  ;;CHECKSYNTAX.c = $(CC) $(CFLAGS) $(CPPFLAGS) -Wall -Wextra -pedantic -fsyntax-only
  ;;CHECKSYNTAX.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) -Wall -Wextra -pedantic -fsyntax-only
  ;;
  ;;check-syntax: $(addsuffix -check-syntax,$(CHK_SOURCES))
  ;;%.c-check-syntax:  ; $(CHECKSYNTAX.c)  $*.c
  ;;%.cc-check-syntax: ; $(CHECKSYNTAX.cc) $*.cc


  ;; GUIの警告は表示しない
  (setq flymake-gui-warnings-enabled nil)

  ;; 全てのファイルで flymakeを有効化
  (add-hook 'find-file-hook 'flymake-find-file-hook)

  ;; flymake を使えない場合をチェック
  (defadvice flymake-can-syntax-check-file
    (after my-flymake-can-syntax-check-file activate)
    (cond
     ((not ad-return-value))
     ;; tramp 経由であれば、無効
     ((and (fboundp 'tramp-list-remote-buffers)
           (memq (current-buffer) (tramp-list-remote-buffers)))
      (setq ad-return-value nil))
     ;; 書き込み不可ならば、flymakeは無効
     ((not (file-writable-p buffer-file-name))
      (setq ad-return-value nil))
     ;; flymake で使われるコマンドが無ければ無効
     ((let ((cmd (nth 0 (prog1
                            (funcall (flymake-get-init-function buffer-file-name))
                          (funcall (flymake-get-cleanup-function buffer-file-name))))))
        (and cmd (not (executable-find cmd))))
      (setq ad-return-value nil))
     ))

  ;; M-p/M-n で警告/エラー行の移動
  (global-set-key "\M-p" 'flymake-goto-prev-error)
  (global-set-key "\M-n" 'flymake-goto-next-error)

  ;; 警告エラー行の表示
  (global-set-key "\C-cd"
                  '(lambda ()
                     (interactive)
                     (my-flymake-display-err-minibuf-for-current-line)
                     ;; (my-flymake-display-err-popup.el-for-current-line)
                     ))

  ;; Minibuf に出力
  (defun my-flymake-display-err-minibuf-for-current-line ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (let* ((line-no             (flymake-current-line-no))
           (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (count               (length line-err-info-list)))
      (while (> count 0)
        (when line-err-info-list
          (let* ((text       (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)))
        (setq count (1- count)))))

  ;; popup.el を使って tip として表示
  (defun my-flymake-display-err-popup.el-for-current-line ()
    "Display a menu with errors/warnings for current line if it has errors and/or warnings."
    (interactive)
    (let* ((line-no             (flymake-current-line-no))
           (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
           (menu-data           (flymake-make-err-menu-data line-no line-err-info-list)))
      (if menu-data
          (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                                (nth 1 menu-data)
                                "\n")))
      ))

  (defun flymake-simple-generic-init (cmd &optional opts)
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list cmd (append opts (list local-file)))))

  ;; Makefile が無くてもC/C++のチェック
  (defun flymake-simple-make-or-generic-init (cmd &optional opts)
    (if (file-exists-p "Makefile")
        (flymake-simple-make-init)
      (flymake-simple-generic-init cmd opts)))

  (defun flymake-c-init ()
    (flymake-simple-make-or-generic-init
     "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

  (defun flymake-cc-init ()
    (flymake-simple-make-or-generic-init
     "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

  (push '("\\.[cCmM]\\'" flymake-c-init) flymake-allowed-file-name-masks)
  (push '("\\.\\(?:cc\|cpp\|CC\|CPP\\)\\'" flymake-cc-init) flymake-allowed-file-name-masks)

  ;; FlymakeTailorRuby
  (when (executable-find "tailor")
    (defun flymake-tailor-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "tailor" (list "-d" local-file))))

    (push '(".+\\.rb$" flymake-tailor-ruby-init) flymake-allowed-file-name-masks)
    (push '("^.*?<Problem> ?+\\([0-9]+\\)\\[\\([0-9]+\\)\\] ?+: ?+ERROR\\[.*?\\] ?+\\(.*?\\)$" nil 1 2 3) flymake-err-line-patterns)
    )

  ;; Invoke ruby with '-c' to get syntax checking
  (when (executable-find "ruby")
    (defun flymake-ruby-init ()
      (flymake-simple-generic-init
       "ruby" '("-c")))

    (push '(".+\\.rb\\'" flymake-ruby-init) flymake-allowed-file-name-masks)
    (push '(".+\\.rake\\'" flymake-ruby-init) flymake-allowed-file-name-masks)
    (push '("Rakefile\\'" flymake-ruby-init) flymake-allowed-file-name-masks)

    (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
    )

  ;; bash チェック
  (defvar flymake-shell-of-choice
    "bash"
    "Path of shell.")

  (defvar flymake-shell-arguments
    (list "-n")
    "Shell arguments to invoke syntax checking.")

  (defun flymake-shell-init ()
    (flymake-simple-generic-init
     flymake-shell-of-choice flymake-shell-arguments))

  (push '(".+\\.sh\\'" flymake-shell-init) flymake-allowed-file-name-masks)
  (push '("^\\(.+\\): line \\([0-9]+\\): \\(.+\\)$" 1 2 nil 3) flymake-err-line-patterns)

  )

;; flymake-ruby
(require 'flymake-ruby)

;; dash-at-point
(require 'dash-at-point)
(define-key global-map (kbd "C-c C-d") 'dash-at-point)
(add-hook 'rinari-minor-mode-hook
          (lambda () (setq dash-at-point-docset "rails")))

;; js2-mode
(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 4)))

;; ag
(require 'ag)
(setq ag-highlight-search t)

;; region-bindings-mode
(require 'region-bindings-mode)
(region-bindings-mode-enable)

;; rhtml-mode
(require 'rhtml-mode)

;; 自分の elisp の設定
(load-file "~/.emacs.d/site-lisp/dash.el")
(load-file "~/.emacs.d/site-lisp/move-line.el")
(load-file "~/.emacs.d/site-lisp/copy-and-paste-for-osx.el")
(load-file "~/.emacs.d/site-lisp/reopen-file.el")
(load-file "~/.emacs.d/site-lisp/hlline-face.el")
(load-file "~/.emacs.d/site-lisp/helm-git-project.el")

(load-theme 'zenburn)
