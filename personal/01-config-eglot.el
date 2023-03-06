(prelude-require-package 'eglot)

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-l .") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "C-c C-l ?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c C-l r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c C-l i") 'eglot-find-implementation)
  (define-key eglot-mode-map (kbd "C-c C-l d") 'eldoc)
  (define-key eglot-mode-map (kbd "C-c C-l e") 'eglot-code-actions))

(provide 'config-eglot)
