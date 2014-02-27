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
          '(lambda() (coffee-custom)))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

;; coffee-modeでACを使えるようにする
(add-to-list 'ac-modes 'coffee-mode)
;; coffee-modeで、追加したjs2-modeのdict(辞書)で補完するようにする
;; wget https://raw.github.com/sandai/dotfiles/master/.emacs.d/ac-dict/js2-mode
(add-hook 'coffee-mode-hook
          '(lambda ()
             (add-to-list 'ac-dictionary-files "~/.emacs.d/elisp/el-get/auto-complete/dict/js2-mode")
             ))
