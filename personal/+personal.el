(eval-and-compile
  (defun emacs-path (path)
    (expand-file-name path user-emacs-directory))

  (defun lookup-password (host user port)
    (require 'auth-source)
    (require 'auth-source-pass)
    (let ((auth (auth-source-search :host host :user user :port port)))
      (if auth
          (let ((secretf (plist-get (car auth) :secret)))
            (if secretf
                (funcall secretf)
              (error "Auth entry for %s@%s:%s has no secret!"
                     user host port)))
        (error "No auth entry found for %s@%s:%s" user host port))))

  (defun filter (f args)
    (let (result)
      (dolist (arg args)
        (when (funcall f arg)
          (setq result (cons arg result))))
      (nreverse result)))

  (defun user-data (dir)
    (expand-file-name dir "data")))

(eval-when-compile
  ;; Disable all warnings about obsolete functions here.
  (dolist (sym '(flet lisp-complete-symbol))
    (setplist sym (use-package-plist-delete (symbol-plist sym)
                                            'byte-obsolete-info))))

(use-package emacs
  :custom
  (frame-title-format
   '(:eval
     (concat
      (if buffer-file-name default-directory "%b")
      "    "
      (number-to-string
       (cdr
        (assq 'width
              (frame-parameters))))
      "x"
      (number-to-string
       (cdr
        (assq 'height
              (frame-parameters)))))))
  :config
  (add-hook 'after-save-hook
            #'executable-make-buffer-file-executable-if-script-p)

  (define-key input-decode-map [?\C-m] [C-m])

  (eval-and-compile
    (mapc #'(lambda (entry)
              (define-prefix-command (cdr entry))
              (bind-key (car entry) (cdr entry)))
          '(("C-,"   . my-ctrl-comma-map)
            ("<C-m>" . my-ctrl-m-map)

            ("C-h e" . my-ctrl-h-e-map)
            ("C-h x" . my-ctrl-h-x-map)

            ("C-c b" . my-ctrl-c-b-map)
            ("C-c e" . my-ctrl-c-e-map)
            ("C-c m" . my-ctrl-c-m-map)
            ("C-c n" . my-ctrl-c-m-map)
            ("C-c w" . my-ctrl-c-w-map)
            ("C-c y" . my-ctrl-c-y-map)
            ("C-c H" . my-ctrl-c-H-map)
            ("C-c N" . my-ctrl-c-N-map)
            ("C-c (" . my-ctrl-c-open-paren-map)
            ("C-c -" . my-ctrl-c-minus-map)
            ("C-c =" . my-ctrl-c-equals-map)
            ("C-c ." . my-ctrl-c-r-map)
            )))
  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))

  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p))

(use-package personal
  :init
  (define-key key-translation-map (kbd "A-TAB") (kbd "C-TAB"))

  :commands unfill-region
  :bind (("M-L"  . mark-line)
         ("M-S"  . mark-sentence)
         ("M-j"  . delete-indentation-forward)
         ("C-c )"   . close-all-parentheses)
         ("C-c 0"   . recursive-edit-preserving-window-config-pop)
         ("C-c 1"   . recursive-edit-preserving-window-config)
         ("C-c C-0" . copy-current-buffer-name)
         ("C-c C-z" . delete-to-end-of-buffer)
         ("C-c M-q" . unfill-paragraph)
         ("C-x D"   . duplicate-line)
         ("C-x C-v" . find-alternate-file-with-sudo)
         ("C-x K"   . delete-current-buffer-file)
         ("C-x M-q" . refill-paragraph)
         ("C-x C-n" . next-line)
         ("C-x C-p" . previous-line))
  :custom
  (user-initials "gas")
  :init
  (bind-keys ("<C-M-backspace>" . backward-kill-sexp)

             ("M-'"   . insert-pair)
             ("M-J"   . delete-indentation)
             ("M-\""  . insert-pair)
             ("M-`"   . other-frame)
             ("M-g c" . goto-char)

             ("C-c SPC" . just-one-space)
             ("C-c M-;" . comment-and-copy)
           ;;  ("C-h h")
             ("C-h v"   . describe-variable)
             ("C-x C-e" . pp-eval-last-sexp)
             ("C-x d"   . delete-whitespace-rectangle)
             ("C-x t"   . toggle-truncate-lines)
             ("C-z"     . delete-other-windows))
  :init
  (defun my-adjust-created-frame ()
    (set-frame-font
     "-*-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
    (set-frame-size (selected-frame) 75 50)
    (set-frame-position (selected-frame) 10 35))

  (advice-add 'make-frame-command :after #'my-adjust-created-frame)
  :config
  (setq
   user-full-name "Andrés Gasson"
   user-mail-address "gas@tuatara.red"
   github-account-name "frap")
  ;; default is in .emacs.d and can be deleted -- used for gpg
  (setq
   auth-sources '("~/.local/state/authinfo.gpg")
   auth-source-cache-expiry nil) ; default is 7200 (2h)
  )
