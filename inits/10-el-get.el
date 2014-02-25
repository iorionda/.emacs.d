;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
(setq el-get-dir "~/.emacs.d/elisp/el-get/")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;; recipe の格納場所
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)
