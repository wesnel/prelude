(prelude-require-packages '(multiple-cursors
                            selected))

(require 'selected)
(require 'multiple-cursors)

(define-key selected-keymap (kbd "C-x c") 'mc/edit-lines)

(selected-global-mode)

(provide 'config-text-manipulation)
