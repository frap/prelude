;; let's pick a nice font

(when (display-graphic-p)

  ;; calculate the font size based on display-pixel-height
  (setq resolution-factor (eval (/ (x-display-pixel-height) 1920.0)))
  (setq doom-font (font-spec :family "JetBrains Mono" :size (eval (round (* 13 resolution-factor))))
        doom-big-font (font-spec :family"JetBrains Mono" :size (eval (round (* 18 resolution-factor))))
        doom-variable-pitch-font (font-spec :family "Overpass" :size (eval (round (* 13 resolution-factor))))
        doom-unicode-font (font-spec :family "JuliaMono" :size (eval (round (* 13 resolution-factor))))
        doom-serif-font (font-spec :family "IBM Plex Mono" :size (eval (round (* 13 resolution-factor))) :weight 'light)
        doom-modeline-height (eval (round (* 14 resolution-factor))))
  (setq doom-font-increment 1)

  ;; set initl screen size
  (setq initial-frame-alist
        '((width . 110)
          (height . 65))))

(cond
 ((find-font (font-spec :name "Cascadia Code"))
  (set-frame-font "Cascadia Code-14" t t))
 ((find-font (font-spec :name "Inconsolata"))
  (set-frame-font "Inconsolata-14" t t)))

(add-to-list 'default-frame-alist '(font . "Hack Nerd Font-13"))
(require 'doom-themes)

(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
