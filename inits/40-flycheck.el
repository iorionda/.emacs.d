;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Python
(add-hook 'python-mode-hook 'flycheck-mode)

;; Ruby
(add-hook 'ruby-mode-hook 'flycheck-mode)
(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool."
  :command ("rubocop" "--format" "emacs" "--silent"
            (config-file "--config" flycheck-rubocoprc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
   :modes (enh-ruby-mode motion-mode))

;; definition for flycheck
(flycheck-define-checker ruby-rubylint
  "A Ruby syntax and style checker using the rubylint tool."
  :command ("ruby-lint" source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
  :modes (enh-ruby-mode ruby-mode))

;; javascript
(flycheck-add-next-checker 'javascript-jshint
                           'javascript-gjslint)


(require 'flycheck-tip)
(define-key global-map (kbd "C-c C-n") 'flycheck-tip-cycle)
(define-key global-map (kbd "C-c C-n") 'flycheck-tip-cycle-reverse)


;; flymake
(smartrep-define-key
    global-map "M-q" '(("M-n" . 'flymake-goto-next-error)
                       ("M-p" . 'flymake-goto-prev-error)))
