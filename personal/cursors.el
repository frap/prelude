(use-package ace-jump-mode
  :defer t)

(use-package ace-window
  :bind* ("<C-return>" . ace-window)
  :custom
  (aw-dispatch-when-more-than 6)
  (aw-scope 'frame))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package multiple-cursors
  :after phi-search
  :defer 5

  ;; - Sometimes you end up with cursors outside of your view. You can scroll
  ;;   the screen to center on each cursor with `C-v` and `M-v`.
  ;;
  ;; - If you get out of multiple-cursors-mode and yank - it will yank only
  ;;   from the kill-ring of main cursor. To yank from the kill-rings of every
  ;;   cursor use yank-rectangle, normally found at C-x r y.

  :bind (("<C-m> c"   . mc/edit-lines)
         ("<C-m> ."   . mc/mark-next-like-this)
         ("<C-m> <"   . mc/unmark-next-like-this)
         ("<C-m> C->" . mc/skip-to-next-like-this)
         ("<C-m> ,"   . mc/mark-previous-like-this)
         ("<C-m> >"   . mc/unmark-previous-like-this)
         ("<C-m> C-<" . mc/skip-to-previous-like-this)
         ("<C-m> y"   . mc/mark-next-symbol-like-this)
         ("<C-m> Y"   . mc/mark-previous-symbol-like-this)
         ("<C-m> w"   . mc/mark-next-word-like-this)
         ("<C-m> W"   . mc/mark-previous-word-like-this)
         ("<C-m> ^"     . mc/edit-beginnings-of-lines)
         ("<C-m> `"     . mc/edit-beginnings-of-lines)
         ("<C-m> $"     . mc/edit-ends-of-lines)
         ("<C-m> '"     . mc/edit-ends-of-lines)
         ("<C-m> R"     . mc/reverse-regions)
         ("<C-m> S"     . mc/sort-regions)
         ("<C-m> W"     . mc/mark-all-words-like-this)
         ("<C-m> Y"     . mc/mark-all-symbols-like-this)
         ("<C-m> a"     . mc/mark-all-like-this-dwim)
         ("<C-m> c"     . mc/mark-all-dwim)
         ("<C-m> l"     . mc/insert-letters)
         ("<C-m> n"     . mc/insert-numbers)
         ("<C-m> r"     . mc/mark-all-in-region)
         ("<C-m> s"     . set-rectangular-region-anchor)
         ("<C-m> %"     . mc/mark-all-in-region-regexp)
         ("<C-m> t"     . mc/mark-sgml-tag-pair)
         ("<C-m> w"     . mc/mark-next-like-this-word)
         ("<C-m> x"     . mc/mark-more-like-this-extended)
         ("<C-m> y"     . mc/mark-next-like-this-symbol)
         ("<C-m> C-x"   . reactivate-mark)
         ("<C-m> C-SPC" . mc/mark-pop)
         ("<C-m> ("     . mc/mark-all-symbols-like-this-in-defun)
         ("<C-m> C-("   . mc/mark-all-words-like-this-in-defun)
         ("<C-m> M-("   . mc/mark-all-like-this-in-defun)
         ("<C-m> ["     . mc/vertical-align-with-space)
         ("<C-m> {"     . mc/vertical-align)

         ("S-<down-mouse-1>")
         ("S-<mouse-1>" . mc/add-cursor-on-click))
  :custom
  (mc/list-file (user-data "mc-lists.el"))
  :preface
  (defun reactivate-mark ()
    (interactive)
    (activate-mark)))

(defalias 'qr 'query-replace)
(defalias 'qrr 'query-replace-regexp)
(global-set-key (kbd "C-c x") 'replace-regexp)

(use-package mc-extras
  :after multiple-cursors
  :bind (("<C-m> M-C-f" . mc/mark-next-sexps)
         ("<C-m> M-C-b" . mc/mark-previous-sexps)
         ("<C-m> <"     . mc/mark-all-above)
         ("<C-m> >"     . mc/mark-all-below)
         ("<C-m> C-d"   . mc/remove-current-cursor)
         ("<C-m> C-k"   . mc/remove-cursors-at-eol)
         ("<C-m> M-d"   . mc/remove-duplicated-cursors)
         ("<C-m> |"     . mc/move-to-column)
         ("<C-m> ~"     . mc/compare-chars)))

(use-package mc-rect
  :after multiple-cursors
  :bind ("<C-m> ]" . mc/rect-rectangle-to-multiple-cursors))

(use-package phi-search
  :defer 5
  :custom
  (phi-search-limit 100000))

(use-package phi-search-mc
  :after (phi-search multiple-cursors)
  :config
  (phi-search-mc/setup-keys)
  (add-hook 'isearch-mode-mode #'phi-search-from-isearch-mc/setup-keys))

;;(use-package ace-mc
 ;; :bind (("<C-m> h"   . ace-mc-add-multiple-cursors)
 ;;        ("<C-m> M-h" . ace-mc-add-single-cursor)))
