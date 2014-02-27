;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; edit-coffeee
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;coffee-mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.Cakefile" . coffee-mode))

;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))

 ;; only show bad whitespace
(setq whitespace-style
      '(trailing space-before-tab indentation empty space-after-tab))

(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (set (make-local-variable 'coffee-tab-width) 2))

(add-hook 'coffee-mode-hook
          (load-auto-complete)
          '(lambda() (coffee-custom)))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(add-to-list 'load-path "~/.emacs.d/elisp/el-get/ac-coffee/")
(require 'ac-coffee)
(add-to-list 'ac-modes 'coffee-mode)
(defun ac-coffee-mode-setup ()
    (setq-default ac-sources my-ac-sources))
(add-hook 'coffee-mode-hook 'ac-coffee-mode-setup)
