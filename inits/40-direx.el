;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; direx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'direx)
(require 'direx-project)

(setq direx:leaf-icon "  "
      direx:open-icon "▾"
      direx:closed-icon "▸")

(push '(direx:direx-mode
        :position left
        :width 20
        :dedicated t)
      popwin:special-display-config)

(global-set-key
 (kbd "C-x C-j")
 'direx-project:jump-to-project-root-other-window)
