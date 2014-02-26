;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; google translate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'google-translate)
(global-set-key (kbd "C-x t") 'google-translate-at-point)
(custom-set-variables
 ;; 翻訳のデフォルト値を設定(en -> ja)
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))
