(require 'prelude-programming)
(require 'config-eglot)

(prelude-require-packages '(go-mode
                            go-projectile
                            company
                            gotest))

;; Open go files with tree-sitter support.
(add-to-list 'major-mode-remap-alist
             '(go-mode . go-ts-mode))

(require 'go-projectile)

;; Ignore go test -c output files
(add-to-list 'completion-ignored-extensions ".test")

(define-key 'help-command (kbd "G") 'godoc)

;; Fix: super-save will cause go files to be saved when lsp-mode does
;; certain things, triggering lsp-format-buffer. This causes, inter alia,
;; commas to disappear when typing go function invocations
(add-to-list 'super-save-predicates
             (lambda () (not (eq major-mode 'go-ts-mode))))

(with-eval-after-load 'go-ts-mode
  (defun prelude-go-mode-defaults ()
    ;; Add to default go-mode key bindings
    (let ((map go-mode-map))
      (define-key map (kbd "C-c a") 'go-test-current-project) ;; current package, really
      (define-key map (kbd "C-c m") 'go-test-current-file)
      (define-key map (kbd "C-c .") 'go-test-current-test)
      (define-key map (kbd "C-c b") 'go-run)
      (define-key map (kbd "C-h f") 'godoc-at-point))

    ;; Prefer goimports to gofmt if installed
    (let ((goimports (executable-find "goimports")))
      (when goimports
        (setq gofmt-command goimports)))

    (whitespace-toggle-options '(tabs))

    ;; CamelCase aware editing operations
    (subword-mode +1))

  ;; if yas is present, this enables yas-global-mode
  ;; which provides completion via company
  (if (fboundp 'yas-global-mode)
      (yas-global-mode))

  ;; tree-sitter fontification
  (defun go-ts-mode-tree-sitter-setup ()
    (treesit-font-lock-recompute-features))
  (add-hook 'go-ts-mode-hook #'go-ts-mode-tree-sitter-setup)

  ;; configure lsp for go
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'eglot-format-buffer t t)
    (add-hook 'before-save-hook #'eglot-code-action-organize-imports t t))
  (add-hook 'go-ts-mode-hook #'lsp-go-install-save-hooks)
  (add-hook 'go-ts-mode-hook #'eglot-ensure)

  (setq prelude-go-mode-hook 'prelude-go-mode-defaults)
  (add-hook 'go-ts-mode-hook (lambda ()
                               (run-hooks 'prelude-go-mode-hook))))

(provide 'config-go-mode)
