;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; migemo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'migemo)
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-options '("-q" "--emacs" "-i" "\g"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8)
  (setq migemo-command "/usr/local/bin/cmigemo")
  (migemo-init))

(require 'helm-migemo)
(setq helm-use-migemo t)
;; 候補が表示されないときがあるので
;; migemoらないように設定
(defadvice helm-c-apropos
  (around ad-helm-apropos activate)
  (let ((helm-use-migemo nil))
    ad-do-it))

(defadvice helm-M-x
  (around ad-helm-M-x activate)
  (let ((helm-use-migemo nil))
    ad-do-it))
