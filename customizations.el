(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(default-frame-alist
    (quote
     ((top-toolbar-shadow-color . "#111")
      (bottom-toolbar-shadow-color . "#000")
      (background-toolbar-color . "#000")
      (viper-saved-cursor-color-in-replace-mode . "Red3")
      (fringe)
      (right-fringe)
      (left-fringe . 1)
      (internal-border-width . 0)
      (vertical-scroll-bars . right)
      (cursor-type . box)
      (menu-bar-lines . 1)
      (tool-bar-lines . 1)
      (background-color . "black")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "yellow")
      (foreground-color . "white")
      (mouse-color . "sienna1"))))
 '(ediff-custom-diff-program "bcomp")
 '(ediff-diff-program "bcomp")
 '(ediff-diff3-program "bcomp")
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(ns-tool-bar-display-mode (quote labels) t)
 '(ns-tool-bar-size-mode (quote small) t)
 '(tab-width 4)
 '(tabbar-cycle-scope (quote tabs))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(truncate-lines t)
 '(visual-line-mode nil t))

(set-fontset-font "fontset-default" 'han '("PingFang SC"))
(set-default-font "Source Code Pro for Powerline")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 110 :width normal :foundry "nil"))))
 '(aquamacs-variable-width ((t (:stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Lucida Grande"))))
 '(bold ((t (:weight semi-bold))))
 '(bold-italic ((t (:slant italic :weight semi-bold))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight light :height 110 :width normal)))))

(defun bcomp ()
  "Run ediff-files on a pair of files marked in dired buffer"
  (interactive)
  (let* ((marked-files (dired-get-marked-files nil nil))
         (other-win (get-window-with-predicate
                     (lambda (window)
                       (with-current-buffer (window-buffer window)
                         (and (not (eq window (selected-window)))
                              (eq major-mode 'dired-mode))))))
         (other-marked-files (and other-win
                                  (with-current-buffer (window-buffer other-win)
                                    (dired-get-marked-files nil)))))
    (cond ((= (length marked-files) 2)
           (ediff-files (nth 0 marked-files)
                        (nth 1 marked-files)))
          ((and (= (length marked-files) 1)
                (= (length other-marked-files) 1))
           (ediff-files (nth 0 marked-files)
                        (nth 0 other-marked-files)))
          ((= (length marked-files) 1)
           (let ((single-file (nth 0 marked-files)))
             (ediff-files single-file
                          (read-file-name
                           (format "Diff %s with: " single-file)
                           nil (m (if (string= single-file (dired-get-filename))
                                      nil
                                    (dired-get-filename))) t))))
          (t (error "mark no more than 2 files")))))

(require 'msearch)

(add-hook 'markdown-mode-hook
          (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook
                        'check-parens
                        nil t))))

;; warning, may yield wrong results in edge-cases like single double-quotes in code block.
;; Use only if your files usually are balanced w/r/t double-quotes
;; <http://stackoverflow.com/questions/9527593/>
(add-hook 'markdown-mode-hook (lambda () (modify-syntax-entry ?\" "\"" markdown-mode-syntax-table)))

(eval-after-load "markdown-mode"
  '(defalias 'markdown-add-xhtml-header-and-footer 'as/markdown-add-xhtml-header-and-footer))

(defun as/markdown-add-xhtml-header-and-footer (title)
  "Wrap XHTML header and footer with given TITLE around current buffer."
  (goto-char (point-min))
  (insert "<!DOCTYPE html5>\n"
          "<html>\n"
          "<head>\n<title>")
  (insert title)
  (insert "</title>\n")
  (insert "<meta charset=\"utf-8\" />\n")
  (when (> (length markdown-css-paths) 0)
    (insert (mapconcat 'markdown-stylesheet-link-string markdown-css-paths "\n")))
  (insert "\n</head>\n\n"
          "<body>\n\n")
  (goto-char (point-max))
  (insert "\n"
          "</body>\n"
          "</html>\n"))

;; The Markdown files I write using IA Writer use newlines to separate
;; paragraphs. That's why I need Visual Line Mode. I also need to
;; disable M-q. If I fill paragraphs, that introduces unwanted
;; newlines.
(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'markdown-mode-hook 'as/markdown-config)
(defun as/markdown-config ()
  (local-set-key (kbd "M-q") 'ignore))

;; I write a lot of Markdown but then I want to post the text on
;; Google+ so here's a quick export.
(defun as/markdown-region-to-google (start end)
  (interactive "r")
  (goto-char start)
  (while (search-forward "*" end t)
    (goto-char (match-beginning 0))
    (cond ((looking-at "\\b\\*\\*\\|\\*\\*\\b")
           (delete-char 1)
           (forward-char 1))
          ((looking-at "\\b\\*\\|\\*\\b")
           (delete-char 1)
           (insert "_")))))

;; Often Markdown gets added to a LaTeX project, too. So I eventually
;; need a LaTeX export.
(defun as/markdown-region-to-latex (start end)
  (interactive "r")
  (goto-char start)
  (save-restriction
    (let (in-list skip-to)
      (narrow-to-region start end)
      (while (re-search-forward "\\*\\|\n\\|\\`" nil t)
        (goto-char (match-beginning 0))
        (if (= (point) (match-end 0))
            (setq skip-to (1+ (point)))
          (setq skip-to (match-end 0)))
        (cond ((looking-at "\\*\\*\\b\\([^*]*?\\)\\b\\*\\*")
               (replace-match "\\\\textbf{\\1}"))
              ((looking-at "\\*\\b\\([^*]*?\\)\\b\\*")
               (replace-match "\\\\textit{\\1}"))
              ((looking-at "^# \\(.*\\)")
               (replace-match "\\\\section{\\1}"))
              ((looking-at "^## \\(.*\\)")
               (replace-match "\\\\subsection{\\1}"))
              ((looking-at "^### \\(.*\\)")
               (replace-match "\\\\subsubsection{\\1}"))
              ((looking-at "^\\* ")
               (replace-match (if in-list "\\\\item " "\\\\begin{itemize}\n\\\\item "))
               (setq in-list "itemize"))
              ((looking-at "^[0-9]+\\. ")
               (replace-match (if in-list "\\\\item " "\\\\begin{enumerate}\n\\\\item "))
               (setq in-list "enumerate"))
              ((and in-list (looking-at "^"))
               (replace-match (format "\\\\end{%s}\n" in-list))
               (setq in-list nil))
              (t (goto-char skip-to)))))))


;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(put 'downcase-region 'disabled nil)
