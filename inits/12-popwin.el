;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; popwin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq pop-up-windows nil)
(require 'popwin nil t)
(setq popwin:close-popup-window-timer-interval 0.5)

(when (require 'popwin nil t)
  (setq anything-samewindow nil)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
  (push '("helm" :regexp t :height 0.5) popwin:special-display-config)
  (push '(dired-mode :position top :height 0.4) popwin:special-display-config)
  (push '("*Completions*" :height 0.4) popwin:special-display-config)
  (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
  (push '("*Help*" :height 0.5 :noselect t :stick t) popwin:special-display-config)
  (push '("*quickrun*" :height 0.5 :stick t) popwin:special-display-config)
  (push '("\*grep\*" :regexp t :height 0.5 :stick t) popwin:special-display-config))
