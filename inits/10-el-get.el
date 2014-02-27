;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
(setq el-get-dir "~/.emacs.d/elisp/el-get/")
(add-to-list 'load-path "~/.emacs.d/elisp/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(el-get 'sync)

;;; recipe の格納場所
(setq el-get-sources
      '(
        (:name ac-coffee
               :type github
               :description "open github from here"
               :pkgname "akfish/ac-coffee"
               :branch "master")
        ))

;; Packages to install from el-get
(defvar my/el-get-packages
  '(
    ac-coffee
    )
  "A list of packages to install from el-get at launch.")
(el-get 'sync my/el-get-packages)
