;;; I must require these two elisps before loading powerline...
(require 'elscreen)
(require 'smartrep)

(require 'powerline)

;;; modeの名前を自分で再定義
(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (flymake-mode . " Fm")
    (paredit-mode . "")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . "")
    (git-gutter-mode . "")
    (anzu-mode . "")
    (yas-minor-mode . "")
    (guide-key-mode . "")

    ;; Major modes
    (fundamental-mode . "Fund")
    (dired-mode . "Dir")
    (lisp-interaction-mode . "Li")
    (cperl-mode . "Pl")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 24 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\"..........  \",
\"........... \",
\"............\",
\"........... \",
\"..........  \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \",
\"            \"};"  color1 color2))



(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 24 2 1\",
\". c %s\",
\"  c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"  ..........\",
\" ...........\",
\"............\",
\" ...........\",
\"  ..........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\",
\"            \"};"  color2 color1))

(defconst color1 "#6699ff")
(defconst color2 "#ff66ff")
(defconst color3 "#696969")

(defvar arrow-right-1 (create-image (arrow-right-xpm color1 color2) 'xpm t :ascent 'center))
(defvar arrow-right-2 (create-image (arrow-right-xpm color2 color3) 'xpm t :ascent 'center))
(defvar arrow-right-3 (create-image (arrow-right-xpm color3 "None") 'xpm t :ascent 'center))
(defvar arrow-left-1  (create-image (arrow-left-xpm color2 color1) 'xpm t :ascent 'center))
(defvar arrow-left-2  (create-image (arrow-left-xpm "None" color2) 'xpm t :ascent 'center))

(setq-default mode-line-format
              (list  '(:eval (concat (propertize " %* %b " 'face 'mode-line-color-1)
                                     (propertize " " 'display arrow-right-1)))
                     '(:eval (concat (propertize " %Z " 'face 'mode-line-color-2)
                                     (propertize " " 'display arrow-right-2)))
                     '(:eval (concat (propertize " %m " 'face 'mode-line-color-3)
                                     (propertize " " 'display arrow-right-3)))

                     ;; Justify right by filling with spaces to right fringe - 16
                     ;; (16 should be computed rahter than hardcoded)
                     '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))

                     '(:eval (concat (propertize " " 'display arrow-left-2)
                                     (propertize " %p " 'face 'mode-line-color-2)))
                     '(:eval (concat (propertize " " 'display arrow-left-1)
                                     (propertize "%4l:%2c  " 'face 'mode-line-color-1)))
                     ))

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
                    :foreground "#fff"
                    :background color1)

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
                    :foreground "#fff"
                    :background color2)

(make-face 'mode-line-color-3)
(set-face-attribute 'mode-line-color-3 nil
                    :foreground "#fff"
                    :background color3)

(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background "#000"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground "#fff"
                    :background "#000")