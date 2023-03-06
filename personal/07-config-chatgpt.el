(require 'chatgpt-shell)

(setq chatgpt-shell-openai-key
      (lambda ()
        (nth 0 (process-lines "pass" "show" "openai-key"))))

(provide 'config-chatgpt)
