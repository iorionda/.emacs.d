;;; 40-ruby-config.el --- for ruby-mode settings:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun execute-rspec ()
  (interactive)
  (do-applescript
   (format
    "tell application \"iTerm\"
       activate
       tell current session of current terminal
         write text \"bundle exec rspec %s:%s\"
       end tell
     end tell"
    buffer-file-name (line-number-at-pos))))

(define-key ruby-mode-map (kbd "C-c r") 'execute-rspec)
