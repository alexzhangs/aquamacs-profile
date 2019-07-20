(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 305 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(default-frame-alist
    (quote
     ((fringe)
      (right-fringe)
      (left-fringe . 1)
      (internal-border-width . 0)
      (vertical-scroll-bars . right)
      (cursor-type . box)
      (menu-bar-lines . 1)
      (tool-bar-lines . 0)
      (background-color . "#102e4e")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "green")
      (foreground-color . "#eeeeee")
      (mouse-color . "white"))))
 '(ns-tool-bar-display-mode (quote labels) t)
 '(ns-tool-bar-size-mode (quote small) t)
 '(truncate-lines t)
 '(visual-line-mode nil t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#102e4e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 100 :width normal :foundry "nil" :family "Source Code Pro for Powerline"))))
 '(Custom-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight extra-light :width normal))) t)
 '(aquamacs-variable-width ((t (:stipple nil :strike-through nil :underline nil :slant normal :weight normal :width normal))))
 '(echo-area ((t (:stipple nil :strike-through nil :underline nil :slant normal :weight normal :width normal))))
 '(tabbar-default ((t (:inherit nil :stipple nil :background "gray80" :foreground "black" :box nil :strike-through nil :underline nil :slant normal :weight normal :width normal))))
 '(tabbar-selected-modified ((t (:inherit tabbar-selected :weight bold))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "gray80" :box (:line-width 3 :color "grey80")))))
 '(tabbar-unselected-modified ((t (:inherit tabbar-unselected :weight bold))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight extra-light :width normal)))))
