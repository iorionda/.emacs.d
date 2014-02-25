;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-highlight-symbol
;; https://github.com/emacsmirror/auto-highlight-symbol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-highlight-symbol)
(auto-highlight-symbol-mode t)
(global-auto-highlight-symbol-mode t)

;; ハイライトするまでの時間を指定
(ahs-set-idle-interval 0.5)
