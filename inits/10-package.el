;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; パッケージ管理
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


(defvar installing-package-list
  '(
    ;;ここに利用しているパッケージを書く
    ac-inf-ruby
    ack-and-a-half
    ag
    auto-complete
    auto-highlight-symbol
    cl-lib
    coffee-mode
    cucumber-goto-step
    dash-at-point
    direx
    elscreen
    exec-path-from-shell
    flycheck
    flycheck-tip
    flymake
    flymake-coffee
    flymake-ruby
    git-commit-mode
    git-gutter
    gitconfig-mode
    gitignore-mode
    google-translate
    guide-key
    helm
    helm-c-yasnippet
    helm-projectile
    helm-migemo
    highlight-indentation
    ido
    inf-ruby
    js2-mode
    magit
    markdown-mode
    migemo
    mo-git-blame
    mode-compile
    motion-mode
    multiple-cursors
    popup
    popwin
    powerline
    projectile
    rainbow-delimiters
    rbenv
    region-bindings-mode
    request
    rhtml-mode
    rinari
    robe
    robe
    rspec-mode
    rubocop
    ruby-block
    ruby-electric
    ruby-end
    ruby-mode
    smart-compile
    smartparens
    smartrep
    sr-speedbar
    undo-tree
    yaml-mode
    yasnippet
    yasnippet-bundle
    zenburn-theme
    ))

(let ((not-installed (loop for x in installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))
