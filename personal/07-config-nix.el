(require 'prelude-programming)

(prelude-require-packages '(nix-mode
                            company-nixos-options))


(add-hook 'nix-mode-hook (lambda ()
                           (setq-local company-backends '(company-nixos-options))))

(provide 'config-nix)
