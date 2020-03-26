;; [[file:~/.config/doom/config.org::*Rudimentary configuration][Rudimentary configuration:1]]
;;; config.el -*- lexical-binding: t; -*-
;; Rudimentary configuration:1 ends here

;; [[file:~/.config/doom/config.org::*Personal Information][Personal Information:1]]
(setq user-full-name "tecosaur"
      user-mail-address "tecosaur@gmail.com")
;; Personal Information:1 ends here

;; [[file:~/.config/doom/config.org::*Simple settings][Simple settings:1]]
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t)           ; When there are lots of glyphs, keep them in memory

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words
;; Simple settings:1 ends here

;; [[file:~/.config/doom/config.org::*Fullscreen][Fullscreen:1]]
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))
;; Fullscreen:1 ends here

;; [[file:~/.config/doom/config.org::*Auto-customisations][Auto-customisations:1]]
(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))
;; Auto-customisations:1 ends here

;; [[file:~/.config/doom/config.org::*Windows][Windows:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below t)
;; Windows:1 ends here

;; [[file:~/.config/doom/config.org::*Windows][Windows:2]]
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
;; Windows:2 ends here

;; [[file:~/.config/doom/config.org::*Buffer defaults][Buffer defaults:1]]
;; (setq-default major-mode 'org-mode)
;; Buffer defaults:1 ends here

;; [[file:~/.config/doom/config.org::*Font Face][Font Face:1]]
(setq doom-font (font-spec :family "Fira Code" :size 22)
      doom-big-font (font-spec :family "Fira Code" :size 36)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 24))
;; Font Face:1 ends here

;; [[file:~/.config/doom/config.org::*Theme][Theme:1]]
(setq doom-theme 'doom-vibrant)
;; Theme:1 ends here

;; [[file:~/.config/doom/config.org::*Theme][Theme:2]]
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))
;; Theme:2 ends here

;; [[file:~/.config/doom/config.org::*Miscellaneous][Miscellaneous:1]]
(setq display-line-numbers-type 'relative)
;; Miscellaneous:1 ends here

;; [[file:~/.config/doom/config.org::*Miscellaneous][Miscellaneous:2]]
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
;; Miscellaneous:2 ends here

;; [[file:~/.config/doom/config.org::*Miscellaneous][Miscellaneous:3]]
(custom-set-faces! '(doom-modeline-evil-insert-state :weight bold :foreground "#339CDB"))
;; Miscellaneous:3 ends here

;; [[file:~/.config/doom/config.org::*Mouse buttons][Mouse buttons:1]]
(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)
;; Mouse buttons:1 ends here

;; [[file:~/.config/doom/config.org::*Window title][Window title:1]]
(setq frame-title-format
    '(""
      "%b"
      (:eval
       (let ((project-name (projectile-project-name)))
         (unless (string= "-" project-name)
           (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))
;; Window title:1 ends here

;; [[file:~/.config/doom/config.org::*Abbrev mode][Abbrev mode:1]]
(use-package abbrev
  :init
  (setq-default abbrev-mode t)
  ;; a hook funtion that sets the abbrev-table to org-mode-abbrev-table
  ;; whenever the major mode is a text mode
  (defun tec/set-text-mode-abbrev-table ()
    (if (derived-mode-p 'text-mode)
        (setq local-abbrev-table org-mode-abbrev-table)))
  :commands abbrev-mode
  :hook
  (abbrev-mode . tec/set-text-mode-abbrev-table)
  :config
  (setq abbrev-file-name (expand-file-name "abbrev.el" doom-private-dir))
  (setq save-abbrevs 'silently))
;; Abbrev mode:1 ends here

;; [[file:~/.config/doom/config.org::*Centaur Tabs][Centaur Tabs:1]]
(after! centaur-tabs
  (setq centaur-tabs-height 36
        centaur-tabs-set-icons t
        centaur-tabs-modified-marker "o"
        centaur-tabs-close-button "×"
        centaur-tabs-set-bar 'above)
        centaur-tabs-gray-out-icons 'buffer
  (centaur-tabs-change-fonts "P22 Underground Book" 160))
;; (setq x-underline-at-descent-line t)
;; Centaur Tabs:1 ends here

;; [[file:~/.config/doom/config.org::*Company][Company:1]]
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
(add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.
;; Company:1 ends here

;; [[file:~/.config/doom/config.org::*Company][Company:2]]
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
;; Company:2 ends here

;; [[file:~/.config/doom/config.org::*Plain Text][Plain Text:1]]
(set-company-backend! '(text-mode
                        markdown-mode
                        gfm-mode)
  '(:seperate company-ispell
              company-files
              company-yasnippet))
;; Plain Text:1 ends here

;; [[file:~/.config/doom/config.org::*ESS][ESS:1]]
(set-company-backend! 'ess-r-mode '(company-R-args company-R-objects company-dabbrev-code :separate))
;; ESS:1 ends here

;; [[file:~/.config/doom/config.org::*\[\[https://github.com/zachcurry/emacs-anywhere\]\[Emacs Anywhere\]\] configuration][[[https://github.com/zachcurry/emacs-anywhere][Emacs Anywhere]] configuration:1]]
(defun markdown-window-p (window-title)
  "Judges from WINDOW-TITLE whether the current window likes markdown"
  (or (string-match-p "Pull Request" window-title)
      (string-match-p "Issue" window-title)
      (string-match-p "Discord" window-title)))
;; [[https://github.com/zachcurry/emacs-anywhere][Emacs Anywhere]] configuration:1 ends here

;; [[file:~/.config/doom/config.org::*\[\[https://github.com/zachcurry/emacs-anywhere\]\[Emacs Anywhere\]\] configuration][[[https://github.com/zachcurry/emacs-anywhere][Emacs Anywhere]] configuration:2]]
(define-minor-mode emacs-anywhere-mode
  "To tweak the current buffer for some emacs-anywhere considerations"
  :init-value nil
  ;; I'm used to C-c C-c for 'completed the thing' so add that
  ;; :keymap '((kbd "C-c C-c") . (lambda () (interactive) (if (equal major-mode "org-mode") (if (org-in-src-block-p) (org-ctrl-c-ctrl-c) (delete-frame)) (delete-frame))))

  (when emacs-anywhere-mode
    ;; line breaking
    (turn-off-auto-fill)
    (visual-line-mode t)
    ;; disable tabs
    (when (centaur-tabs-mode) (centaur-tabs-local-mode t)))
  )

(defun ea-popup-handler (app-name window-title x y w h)
  (set-frame-size (selected-frame) 80 12)
  (interactive)
  ;; position
  (let* ((mousepos (split-string (shell-command-to-string "xdotool getmouselocation | sed -E \"s/ screen:0 window:[^ ]*|x:|y://g\"")))
         (mouse-x (- (string-to-number (nth 0 mousepos)) 100))
         (mouse-y (- (string-to-number (nth 1 mousepos)) 50)))
    (set-frame-position (selected-frame) mouse-x mouse-y))

  (set-frame-name (concat "Quick Edit ∷ " ea-app-name " — "
                          (truncate-string-to-width (string-trim  (string-trim-right window-title (format "-[A-Za-z0-9 ]*%s" ea-app-name)) "[\s-]+" "[\s-]+") 45 nil nil "…")))

  ;; set major mode
  (cond
   ((markdown-window-p window-title) (gfm-mode))
   (t (org-mode)) ; default major mode
   )

  (when (gui-get-selection 'PRIMARY) (insert (gui-get-selection 'PRIMARY)))

  (evil-insert-state) ; start in insert
  (emacs-anywhere-mode 1))

(add-hook 'ea-popup-hook 'ea-popup-handler)
;; [[https://github.com/zachcurry/emacs-anywhere][Emacs Anywhere]] configuration:2 ends here

;; [[file:~/.config/doom/config.org::*Flyspell][Flyspell:1]]
(after! flyspell (require 'flyspell-lazy) (flyspell-lazy-mode 1))
;; Flyspell:1 ends here

;; [[file:~/.config/doom/config.org::*Tramp][Tramp:1]]
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")) ;; defult + 
;; Tramp:1 ends here

;; [[file:~/.config/doom/config.org::*Treemacs][Treemacs:1]]
(after! treemacs
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))
;; Treemacs:1 ends here

;; [[file:~/.config/doom/config.org::*Treemacs][Treemacs:2]]
(setq treemacs-file-ignore-extensions '(;; LaTeX
                                        "aux"
                                        "ptc"
                                        "fdb_latexmk"
                                        "fls"
                                        "synctex.gz"
                                        "toc"
                                        ;; LaTeX - glossary
                                        "glg"
                                        "glo"
                                        "gls"
                                        "glsdefs"
                                        "ist"
                                        "acn"
                                        "acr"
                                        "alg"
                                        ;; LaTeX - pgfplots
                                        "mw"
                                        ;; LaTeX - pdfx
                                        "pdfa.xmpi"
                                        ))
(setq treemacs-file-ignore-globs '(;; LaTeX
                                   "*/_minted-*"
                                   ;; AucTeX
                                   "*/.auctex-auto"
                                   "*/_region_.log"
                                   "*/_region_.tex"))
;; Treemacs:2 ends here

;; [[file:~/.config/doom/config.org::*calc][calc:1]]
(setq calc-angle-mode 'rad)
;; calc:1 ends here

;; [[file:~/.config/doom/config.org::*electric pair mode][electric pair mode:1]]
(electric-pair-mode t)
;; electric pair mode:1 ends here

;; [[file:~/.config/doom/config.org::*ispell][ispell:1]]
(setq ispell-dictionary "en_GBs_au_SCOWL_80_0_k_hr")
(setq company-ispell-dictionary "en_GBs_au_SCOWL_80_0_k_hr")
;; ispell:1 ends here

;; [[file:~/.config/doom/config.org::*ispell][ispell:2]]
(setq ispell-personal-dictionary (expand-file-name ".hunspell_personal" doom-private-dir))
;; ispell:2 ends here

;; [[file:~/.config/doom/config.org::*spray][spray:1]]
(setq spray-wpm 500
      spray-height 700)
;; spray:1 ends here

;; [[file:~/.config/doom/config.org::*theme magic][theme magic:1]]
(add-hook 'doom-load-theme-hook 'theme-magic-from-emacs)
;; theme magic:1 ends here

;; [[file:~/.config/doom/config.org::*wttrin][wttrin:1]]
(setq wttrin-default-cities '(""))
;; wttrin:1 ends here

;; [[file:~/.config/doom/config.org::*LSP][LSP:1]]
(defvar lsp-ui-doc-winum-ignore nil)
;; LSP:1 ends here

;; [[file:~/.config/doom/config.org::*File Templates][File Templates:1]]
(set-file-template! "\\.tex$" :trigger "__" :mode 'latex-mode)
;; File Templates:1 ends here

;; [[file:~/.config/doom/config.org::*Tweaking defaults][Tweaking defaults:1]]
(setq org-directory "~/.org"                      ; let's put files here
      org-use-property-inheritance t              ; it's convenient to have properties inherited
      org-log-done 'time                          ; having the time a item is done sounds convininet
      org-list-allow-alphabetical t               ; have a. A. a) A) list bullets
      org-export-in-background t                  ; run export processes in external emacs process
      org-catch-invisible-edits 'smart)           ; try not to accidently do weird stuff in invisible regions
;; Tweaking defaults:1 ends here

;; [[file:~/.config/doom/config.org::*Tweaking defaults][Tweaking defaults:2]]
(setq org-babel-default-header-args '((:session . "none")
                                      (:results . "replace")
                                      (:exports . "code")
                                      (:cache . "no")
                                      (:noweb . "no")
                                      (:hlines . "no")
                                      (:tangle . "no")
                                      (:comments . "link")))
;; Tweaking defaults:2 ends here

;; [[file:~/.config/doom/config.org::*Extra functionality][Extra functionality:1]]
(evil-define-command evil-buffer-org-new (count file)
  "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
      (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)))))
(map! :leader
  (:prefix "b"
    :desc "New empty ORG buffer" "o" #'evil-buffer-org-new))
;; Extra functionality:1 ends here

;; [[file:~/.config/doom/config.org::*Extra functionality][Extra functionality:2]]
(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+")))
;; Extra functionality:2 ends here

;; [[file:~/.config/doom/config.org::*Extra functionality][Extra functionality:3]]
(def-package! org-ref
   :after org
   :config
    (setq org-ref-completion-library 'org-ref-ivy-cite))
;; Extra functionality:3 ends here

;; [[file:~/.config/doom/config.org::*Extra functionality][Extra functionality:4]]
(after! org (add-hook 'org-mode-hook 'turn-on-org-cdlatex))
;; Extra functionality:4 ends here

;; [[file:~/.config/doom/config.org::*Extra functionality][Extra functionality:5]]
(after! org (add-hook 'org-mode-hook 'turn-on-flyspell))
;; Extra functionality:5 ends here

;; [[file:~/.config/doom/config.org::*Nicer ~org-return~][Nicer ~org-return~:1]]
(after! org
  (defun unpackaged/org-element-descendant-of (type element)
    "Return non-nil if ELEMENT is a descendant of TYPE.
TYPE should be an element type, like `item' or `paragraph'.
ELEMENT should be a list like that returned by `org-element-context'."
    ;; MAYBE: Use `org-element-lineage'.
    (when-let* ((parent (org-element-property :parent element)))
      (or (eq type (car parent))
          (unpackaged/org-element-descendant-of type parent))))

;;;###autoload
  (defun unpackaged/org-return-dwim (&optional default)
    "A helpful replacement for `org-return-indent'.  With prefix, call `org-return-indent'.

On headings, move point to position after entry content.  In
lists, insert a new item or end the list, with checkbox if
appropriate.  In tables, insert a new row or end the table."
    ;; Inspired by John Kitchin: http://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
    (interactive "P")
    (if default
        (org-return t)
      (cond
       ;; Act depending on context around point.

       ;; NOTE: I prefer RET to not follow links, but by uncommenting this block, links will be
       ;; followed.

       ;; ((eq 'link (car (org-element-context)))
       ;;  ;; Link: Open it.
       ;;  (org-open-at-point-global))

       ((org-at-heading-p)
        ;; Heading: Move to position after entry content.
        ;; NOTE: This is probably the most interesting feature of this function.
        (let ((heading-start (org-entry-beginning-position)))
          (goto-char (org-entry-end-position))
          (cond ((and (org-at-heading-p)
                      (= heading-start (org-entry-beginning-position)))
                 ;; Entry ends on its heading; add newline after
                 (end-of-line)
                 (insert "\n\n"))
                (t
                 ;; Entry ends after its heading; back up
                 (forward-line -1)
                 (end-of-line)
                 (when (org-at-heading-p)
                   ;; At the same heading
                   (forward-line)
                   (insert "\n")
                   (forward-line -1))
                 ;; FIXME: looking-back is supposed to be called with more arguments.
                 (while (not (looking-back (rx (repeat 3 (seq (optional blank) "\n")))))
                   (insert "\n"))
                 (forward-line -1)))))

       ((org-at-item-checkbox-p)
        ;; Checkbox: Insert new item with checkbox.
        (org-insert-todo-heading nil))

       ((org-in-item-p)
        ;; Plain list.  Yes, this gets a little complicated...
        (let ((context (org-element-context)))
          (if (or (eq 'plain-list (car context))  ; First item in list
                  (and (eq 'item (car context))
                       (not (eq (org-element-property :contents-begin context)
                                (org-element-property :contents-end context))))
                  (unpackaged/org-element-descendant-of 'item context))  ; Element in list item, e.g. a link
              ;; Non-empty item: Add new item.
              (org-insert-item)
            ;; Empty item: Close the list.
            ;; TODO: Do this with org functions rather than operating on the text. Can't seem to find the right function.
            (delete-region (line-beginning-position) (line-end-position))
            (insert "\n"))))

       ((when (fboundp 'org-inlinetask-in-task-p)
          (org-inlinetask-in-task-p))
        ;; Inline task: Don't insert a new heading.
        (org-return t))

       ((org-at-table-p)
        (cond ((save-excursion
                 (beginning-of-line)
                 ;; See `org-table-next-field'.
                 (cl-loop with end = (line-end-position)
                          for cell = (org-element-table-cell-parser)
                          always (equal (org-element-property :contents-begin cell)
                                        (org-element-property :contents-end cell))
                          while (re-search-forward "|" end t)))
               ;; Empty row: end the table.
               (delete-region (line-beginning-position) (line-end-position))
               (org-return t))
              (t
               ;; Non-empty row: call `org-return-indent'.
               (org-return t))))
       (t
        ;; All other cases: call `org-return-indent'.
        (org-return t)))))
  (advice-add #'org-return-indent :override #'unpackaged/org-return-dwim))
;; Nicer ~org-return~:1 ends here

;; [[file:~/.config/doom/config.org::*Font Display][Font Display:1]]
(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
;; Font Display:1 ends here

;; [[file:~/.config/doom/config.org::*Font Display][Font Display:2]]
(setq global-org-pretty-table-mode t)
;; Font Display:2 ends here

;; [[file:~/.config/doom/config.org::*Font Display][Font Display:3]]
(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.2)
  '(outline-2 :weight bold :height 1.12)
  '(outline-3 :weight bold :height 1.1)
  '(outline-4 :weight semi-bold :height 1.08)
  '(outline-5 :weight semi-bold :height 1.05)
  '(outline-6 :weight semi-bold :height 1.02)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))
;; Font Display:3 ends here

;; [[file:~/.config/doom/config.org::*Symbols][Symbols:1]]
(setq org-ellipsis " ▾ "
      org-bullets-bullet-list '("◉" "○" "✸" "✿" "✤")
      ;; org-bullets-bullet-list '("Ⅰ" "Ⅱ" "Ⅲ" "Ⅳ" "Ⅴ" "Ⅵ" "Ⅶ" "Ⅷ" "Ⅸ" "Ⅹ")
      )
;; Symbols:1 ends here

;; [[file:~/.config/doom/config.org::*Symbols][Symbols:2]]
(after! org
  (appendq! +pretty-code-symbols
            '(:checkbox    "☐"
              :pending     "◼"
              :checkedbox  "☑"
              :results     "🠶"
              :property    "☸"
              :properties  "⚙"
              :end         "∎"
              :options     "⌥"
              :title       "𝙏"
              :author      "𝘼"
              :date        "𝘿"
              :begin_quote "❮"
              :end_quote   "❯"
              :em_dash     "—"))
  (set-pretty-symbols! 'org-mode
    :merge t
    :checkbox    "[ ]"
    :pending     "[-]"
    :checkedbox  "[X]"
    :results     "#+RESULTS:"
    :property    "#+PROPERTY:"
    :property    ":PROPERTIES:"
    :end         ":END:"
    :options     "#+OPTIONS:"
    :title       "#+TITLE:"
    :author      "#+AUTHOR:"
    :date        "#+DATE:"
    :begin_quote "#+BEGIN_QUOTE"
    :end_quote   "#+END_QUOTE"
    :em_dash     "---")
)
(plist-put +pretty-code-symbols :name "⁍") ; or › could be good?
;; Symbols:2 ends here

;; [[file:~/.config/doom/config.org::*Symbols][Symbols:3]]
(add-hook 'org-mode-hook 'org-fragtog-mode)
;; Symbols:3 ends here

;; [[file:~/.config/doom/config.org::*LaTeX Fragments][LaTeX Fragments:1]]
(setq org-format-latex-header "\\documentclass{article}
\\usepackage[usenames]{color}

\\usepackage[T1]{fontenc}
\\usepackage{mathtools}
\\usepackage{textcomp,amssymb}
\\usepackage[makeroom]{cancel}

\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}
% my custom stuff
\\usepackage{arev}
\\usepackage{arevmath}")
;; LaTeX Fragments:1 ends here

;; [[file:~/.config/doom/config.org::*LaTeX Fragments][LaTeX Fragments:2]]
(after! org
;; make background of fragments transparent
;; (let ((dvipng--plist (alist-get 'dvipng org-preview-latex-process-alist)))
;;   (plist-put dvipng--plist :use-xcolor t)
;;   (plist-put dvipng--plist :image-converter '("dvipng -D %D -bg 'transparent' -T tight -o %O %f")))
  (add-hook! 'doom-load-theme-hook
    (defun +org-refresh-latex-background ()
      (plist-put! org-format-latex-options
                  :background
                  (face-attribute (or (cadr (assq 'default face-remapping-alist))
                                      'default)
                                  :background nil t))))
)
;; LaTeX Fragments:2 ends here

;; [[file:~/.config/doom/config.org::*LaTeX Fragments][LaTeX Fragments:3]]
(after! org
  (add-to-list 'org-latex-regexps '("\\ce" "^\\\\ce{\\(?:[^\000{}]\\|{[^\000}]+?}\\)}" 0 nil)))
;; LaTeX Fragments:3 ends here

;; [[file:~/.config/doom/config.org::*Stolen from \[\[https://github.com/jkitchin/scimax\]\[scimax\]\] (semi-working right now)][Stolen from [[https://github.com/jkitchin/scimax][scimax]] (semi-working right now):1]]
(after! org
  (defun scimax-org-latex-fragment-justify (justification)
    "Justify the latex fragment at point with JUSTIFICATION.
JUSTIFICATION is a symbol for 'left, 'center or 'right."
    (interactive
     (list (intern-soft
            (completing-read "Justification (left): " '(left center right)
                             nil t nil nil 'left))))
    (let* ((ov (ov-at))
           (beg (ov-beg ov))
           (end (ov-end ov))
           (shift (- beg (line-beginning-position)))
           (img (overlay-get ov 'display))
           (img (and (and img (consp img) (eq (car img) 'image)
                          (image-type-available-p (plist-get (cdr img) :type)))
                     img))
           space-left offset)
      (when (and img
                 ;; This means the equation is at the start of the line
                 (= beg (line-beginning-position))
                 (or
                  (string= "" (s-trim (buffer-substring end (line-end-position))))
                  (eq 'latex-environment (car (org-element-context)))))
        (setq space-left (- (window-max-chars-per-line) (car (image-size img)))
              offset (floor (cond
                             ((eq justification 'center)
                              (- (/ space-left 2) shift))
                             ((eq justification 'right)
                              (- space-left shift))
                             (t
                              0))))
        (when (>= offset 0)
          (overlay-put ov 'before-string (make-string offset ?\ ))))))

  (defun scimax-org-latex-fragment-justify-advice (beg end image imagetype)
    "After advice function to justify fragments."
    (scimax-org-latex-fragment-justify (or (plist-get org-format-latex-options :justify) 'left)))


  (defun scimax-toggle-latex-fragment-justification ()
    "Toggle if LaTeX fragment justification options can be used."
    (interactive)
    (if (not (get 'scimax-org-latex-fragment-justify-advice 'enabled))
        (progn
          (advice-add 'org--format-latex-make-overlay :after 'scimax-org-latex-fragment-justify-advice)
          (put 'scimax-org-latex-fragment-justify-advice 'enabled t)
          (message "Latex fragment justification enabled"))
      (advice-remove 'org--format-latex-make-overlay 'scimax-org-latex-fragment-justify-advice)
      (put 'scimax-org-latex-fragment-justify-advice 'enabled nil)
      (message "Latex fragment justification disabled"))))
;; Stolen from [[https://github.com/jkitchin/scimax][scimax]] (semi-working right now):1 ends here

;; [[file:~/.config/doom/config.org::*Stolen from \[\[https://github.com/jkitchin/scimax\]\[scimax\]\] (semi-working right now)][Stolen from [[https://github.com/jkitchin/scimax][scimax]] (semi-working right now):2]]
;; Numbered equations all have (1) as the number for fragments with vanilla
;; org-mode. This code injects the correct numbers into the previews so they
;; look good.
(after! org
  (defun scimax-org-renumber-environment (orig-func &rest args)
    "A function to inject numbers in LaTeX fragment previews."
    (let ((results '())
          (counter -1)
          (numberp))
      (setq results (loop for (begin .  env) in
                          (org-element-map (org-element-parse-buffer) 'latex-environment
                            (lambda (env)
                              (cons
                               (org-element-property :begin env)
                               (org-element-property :value env))))
                          collect
                          (cond
                           ((and (string-match "\\\\begin{equation}" env)
                                 (not (string-match "\\\\tag{" env)))
                            (incf counter)
                            (cons begin counter))
                           ((string-match "\\\\begin{align}" env)
                            (prog2
                                (incf counter)
                                (cons begin counter)
                              (with-temp-buffer
                                (insert env)
                                (goto-char (point-min))
                                ;; \\ is used for a new line. Each one leads to a number
                                (incf counter (count-matches "\\\\$"))
                                ;; unless there are nonumbers.
                                (goto-char (point-min))
                                (decf counter (count-matches "\\nonumber")))))
                           (t
                            (cons begin nil)))))

      (when (setq numberp (cdr (assoc (point) results)))
        (setf (car args)
              (concat
               (format "\\setcounter{equation}{%s}\n" numberp)
               (car args)))))

    (apply orig-func args))


  (defun scimax-toggle-latex-equation-numbering ()
    "Toggle whether LaTeX fragments are numbered."
    (interactive)
    (if (not (get 'scimax-org-renumber-environment 'enabled))
        (progn
          (advice-add 'org-create-formula-image :around #'scimax-org-renumber-environment)
          (put 'scimax-org-renumber-environment 'enabled t)
          (message "Latex numbering enabled"))
      (advice-remove 'org-create-formula-image #'scimax-org-renumber-environment)
      (put 'scimax-org-renumber-environment 'enabled nil)
      (message "Latex numbering disabled.")))

  (advice-add 'org-create-formula-image :around #'scimax-org-renumber-environment)
  (put 'scimax-org-renumber-environment 'enabled t))
;; Stolen from [[https://github.com/jkitchin/scimax][scimax]] (semi-working right now):2 ends here

;; [[file:~/.config/doom/config.org::*Exporting (general)][Exporting (general):1]]
(after! org (setq org-export-headline-levels 5)) ; I like nesting
;; Exporting (general):1 ends here

;; [[file:~/.config/doom/config.org::*Custom CSS/JS][Custom CSS/JS:2]]
(defun my-org-inline-css-hook (exporter)
  "Insert custom inline css to automatically set the
   background of code to whatever theme I'm using's background"
  (when (eq exporter 'html)
      (setq
       org-html-head-extra
       (concat
        org-html-head-extra
        (format "
<style type=\"text/css\">
   :root {
      --theme-bg: %s;
      --theme-bg-alt: %s;
      --theme-base0: %s;
      --theme-base1: %s;
      --theme-base2: %s;
      --theme-base3: %s;
      --theme-base4: %s;
      --theme-base5: %s;
      --theme-base6: %s;
      --theme-base7: %s;
      --theme-base8: %s;
      --theme-fg: %s;
      --theme-fg-alt: %s;
      --theme-grey: %s;
      --theme-red: %s;
      --theme-orange: %s;
      --theme-green: %s;
      --theme-teal: %s;
      --theme-yellow: %s;
      --theme-blue: %s;
      --theme-dark-blue: %s;
      --theme-magenta: %s;
      --theme-violet: %s;
      --theme-cyan: %s;
      --theme-dark-cyan: %s;
   }
</style>"
       (doom-color 'bg)
       (doom-color 'bg-alt)
       (doom-color 'base0)
       (doom-color 'base1)
       (doom-color 'base2)
       (doom-color 'base3)
       (doom-color 'base4)
       (doom-color 'base5)
       (doom-color 'base6)
       (doom-color 'base7)
       (doom-color 'base8)
       (doom-color 'fg)
       (doom-color 'fg-alt)
       (doom-color 'grey)
       (doom-color 'red)
       (doom-color 'orange)
       (doom-color 'green)
       (doom-color 'teal)
       (doom-color 'yellow)
       (doom-color 'blue)
       (doom-color 'dark-blue)
       (doom-color 'magenta)
       (doom-color 'violet)
       (doom-color 'cyan)
       (doom-color 'dark-cyan))
        "
<link rel='stylesheet' type='text/css' href='https://fniessen.github.io/org-html-themes/styles/readtheorg/css/htmlize.css'/>
<link rel='stylesheet' type='text/css' href='https://fniessen.github.io/org-html-themes/styles/readtheorg/css/readtheorg.css'/>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'></script>
<script type='text/javascript' src='https://fniessen.github.io/org-html-themes/styles/lib/js/jquery.stickytableheaders.min.js'></script>
<script type='text/javascript' src='https://fniessen.github.io/org-html-themes/styles/readtheorg/js/readtheorg.js'></script>

<style>
   pre.src {
     background-color: var(--theme-bg);
     color: var(--theme-fg);
     scrollbar-color:#bbb6#9992;
     scrollbar-width: thin;
     margin: 0;
     border: none;
   }
   div.org-src-container {
     border-radius: 12px;
     overflow: hidden;
     margin-bottom: 24px;
     margin-top: 1px;
     border: 1px solid#e1e4e5;
   }
   pre.src::before {
     background-color:#6666;
     top: 8px;
     border: none;
     border-radius: 5px;
     line-height: 1;
     border: 2px solid var(--theme-bg);
     opacity: 0;
     transition: opacity 200ms;
   }
   pre.src:hover::before { opacity: 1; }
   pre.src:active::before { opacity: 0; }

   pre.example {
     border-radius: 12px;
     background: var(--theme-bg-alt);
     color: var(--theme-fg);
   }

   code {
     border-radius: 5px;
     background:#e8e8e8;
     font-size: 80%;
   }

   kbd {
     display: inline-block;
     padding: 3px 5px;
     font: 80% SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
     line-height: normal;
     line-height: 10px;
     color:#444d56;
     vertical-align: middle;
     background-color:#fafbfc;
     border: 1px solid#d1d5da;
     border-radius: 3px;
     box-shadow: inset 0 -1px 0#d1d5da;
   }

   table {
     max-width: 100%;
     overflow-x: auto;
     display: block;
     border-top: none;
   }

   a {
       text-decoration: none;
       background-image: linear-gradient(#d8dce9, #d8dce9);
       background-position: 0% 100%;
       background-repeat: no-repeat;
       background-size: 0% 2px;
       transition: background-size .3s;
   }
   \#table-of-contents a {
       background-image: none;
   }
   a:hover, a:focus {
       background-size: 100% 2px;
   }
   a[href^='#'] { font-variant-numeric: oldstyle-nums; }
   a[href^='#']:visited { color:#3091d1; }

   li .checkbox {
       display: inline-block;
       width: 0.9em;
       height: 0.9em;
       border-radius: 3px;
       margin: 3px;
       top: 4px;
       position: relative;
   }
   li.on > .checkbox { background: var(--theme-green); box-shadow: 0 0 2px var(--theme-green); }
   li.trans > .checkbox { background: var(--theme-orange); box-shadow: 0 0 2px var(--theme-orange); }
   li.off > .checkbox { background: var(--theme-red); box-shadow: 0 0 2px var(--theme-red); }
   li.on > .checkbox::after {
     content: '';
     height: 0.45em;
     width: 0.225em;
     -webkit-transform-origin: left top;
     transform-origin: left top;
     transform: scaleX(-1) rotate(135deg);
     border-right: 2.8px solid#fff;
     border-top: 2.8px solid#fff;
     opacity: 0.9;
     left: 0.10em;
     top: 0.45em;
     position: absolute;
   }
   li.trans > .checkbox::after {
       content: '';
       font-weight: bold;
       font-size: 1.6em;
       position: absolute;
       top: 0.23em;
       left: 0.09em;
       width: 0.35em;
       height: 0.12em;
       background:#fff;
       opacity: 0.9;
       border-radius: 0.1em;
   }
   li.off > .checkbox::after {
    content: '✖';
    color:#fff;
    opacity: 0.9;
    position: relative;
    top: -0.40rem;
    left: 0.17em;
    font-size: 0.75em;
  }

   span.timestamp {
       color: #003280;
       background: #647CFF44;
       border-radius: 3px;
       line-height: 1.25;
   }

   \#table-of-contents { overflow-y: auto; }
   blockquote p { margin: 8px 0px 16px 0px; }
   \#postamble .date { color: var(--theme-green); }

   ::-webkit-scrollbar { width: 10px; height: 8px; }
   ::-webkit-scrollbar-track { background:#9992; }
   ::-webkit-scrollbar-thumb { background:#ccc; border-radius: 10px; }
   ::-webkit-scrollbar-thumb:hover { background:#888; }
</style>
"
        ))))

(add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)
;; Custom CSS/JS:2 ends here

;; [[file:~/.config/doom/config.org::*Make verbatim different to code][Make verbatim different to code:1]]
(setq org-html-text-markup-alist
      '((bold . "<b>%s</b>")
        (code . "<code>%s</code>")
        (italic . "<i>%s</i>")
        (strike-through . "<del>%s</del>")
        (underline . "<span class=\"underline\">%s</span>")
        (verbatim . "<kbd>%s</kbd>")))
;; Make verbatim different to code:1 ends here

;; [[file:~/.config/doom/config.org::*Change checkbox type][Change checkbox type:1]]
(after! org
(appendq! org-html-checkbox-types '((html-span .
	  ((on . "<span class='checkbox'></span>")
	  (off . "<span class='checkbox'></span>")
	  (trans . "<span class='checkbox'></span>")))))
(setq org-html-checkbox-type 'html-span))
;; Change checkbox type:1 ends here

;; [[file:~/.config/doom/config.org::*LaTeX Rendering][LaTeX Rendering:1]]
;; (setq-default org-html-with-latex `dvisvgm)
;; LaTeX Rendering:1 ends here

;; [[file:~/.config/doom/config.org::*Exporting to LaTeX][Exporting to LaTeX:1]]
;; TODO make this /only/ apply to text (i.e. not URL)
(after! org
  (defun tec/org-export-latex-filter-acronym (text backend info)
    (when (org-export-derived-backend-p backend 'latex)
      (let ((case-fold-search nil))
        (replace-regexp-in-string
         ";?\\b[A-Z][A-Z]+s?"
         (lambda (all-caps-str)
           ; only \acr if str doesn't start with ";"
           (if (equal (aref all-caps-str 0) 59) (substring all-caps-str 1)
             (if (equal (aref all-caps-str (- (length all-caps-str) 1)) ?s)
                 (concat "\\textls*[70]{\\textsc{" (s-downcase (substring all-caps-str 0 -1)) "}\\protect\\scalebox{.91}[.84]{s}}")
               (concat "\\textls*[70]{\\textsc{" (s-downcase all-caps-str) "}}"))))
         text t t))))

  (add-to-list 'org-export-filter-plain-text-functions
               'tec/org-export-latex-filter-acronym)
  (add-to-list 'org-export-filter-headline-functions
               'tec/org-export-latex-filter-acronym))
;; Exporting to LaTeX:1 ends here

;; [[file:~/.config/doom/config.org::*Exporting to LaTeX][Exporting to LaTeX:2]]
(after! ox-latex
  (add-to-list 'org-latex-classes
               '("fancy-article"
               "\\documentclass{scrartcl}\n\
\\usepackage[T1]{fontenc}\n\
\\usepackage[osf,largesc,helvratio=0.9]{newpxtext}\n\
\\usepackage[scale=0.92]{sourcecodepro}\n\
\\usepackage[varbb]{newpxmath}\n\
\\usepackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=2000]{microtype}\n\
\\usepackage{xcolor}\n\
\\setlength{\\parskip}{\\baselineskip}\n\
\\setlength{\\parindent}{0pt}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("blank"
               "[NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("bmc-article"
               "\\documentclass[article,code,maths]{bmc}
               [NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("bmc"
               "\\documentclass[code,maths]{bmc}
               [NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "fancy-article")

  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
        '(("frame" "lines")
          ("fontsize" "\\scriptsize")
          ("linenos" "")
          ("breakanywhere" "true")
          ("breakautoindent" "true")
          ("breaklines" "true")
          ("autogobble" "true")
          ("obeytabs" "true")
          ("python3" "true")
          ("breakbefore" "\\\\\\.+")
          ("breakafter" "\\,")
          ("style" "autumn")
          ("breaksymbol" "\\tiny\\ensuremath{\\hookrightarrow}")
          ("breakanywheresymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")
          ("breakbeforesymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")
          ("breakaftersymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")))

  (setq org-latex-hyperref-template "\\hypersetup{
  pdfauthor={%a},
  pdftitle={%t},
  pdfkeywords={%k},
  pdfsubject={%d},
  pdfcreator={%c},
  pdflang={%L},
  breaklinks=true,
  colorlinks=true,
  linkcolor=,
  urlcolor=blue!70!green,
  citecolor=green!60!blue\n}
\\urlstyle{same}\n")
  (setq org-latex-pdf-process
        '("latexmk -shell-escape -interaction=nonstopmode -f -pdf -output-directory=%o %f")))
;; Exporting to LaTeX:2 ends here

;; [[file:~/.config/doom/config.org::*Exporting to Beamer][Exporting to Beamer:1]]
(setq org-beamer-theme "[progressbar=foot]metropolis")
;; Exporting to Beamer:1 ends here

;; [[file:~/.config/doom/config.org::*Exporting to Beamer][Exporting to Beamer:2]]

;; Exporting to Beamer:2 ends here

;; [[file:~/.config/doom/config.org::*Exporting to Beamer][Exporting to Beamer:3]]
(setq org-beamer-frame-level 2)
;; Exporting to Beamer:3 ends here

;; [[file:~/.config/doom/config.org::*Exporting to GFM][Exporting to GFM:1]]
(eval-after-load "org"
  '(require 'ox-gfm nil t))
;; Exporting to GFM:1 ends here

;; [[file:~/.config/doom/config.org::*Babel][Babel:1]]
(setq org-babel-python-command "python3")
;; Babel:1 ends here

;; [[file:~/.config/doom/config.org::*Babel][Babel:2]]
(defun tec-org-python ()
  (if (eq major-mode 'python-mode)
   (progn (anaconda-mode t)
          (company-mode t)))
  )
(add-hook 'org-src-mode-hook 'tec-org-python)
;; Babel:2 ends here

;; [[file:~/.config/doom/config.org::*ESS][ESS:1]]
(setq ess-eval-visibly 'nowait)
;; ESS:1 ends here

;; [[file:~/.config/doom/config.org::*ESS][ESS:2]]
(setq ess-R-font-lock-keywords '((ess-R-fl-keyword:keywords . t)
 (ess-R-fl-keyword:constants . t)
 (ess-R-fl-keyword:modifiers . t)
 (ess-R-fl-keyword:fun-defs . t)
 (ess-R-fl-keyword:assign-ops . t)
 (ess-R-fl-keyword:%op% . t)
 (ess-fl-keyword:fun-calls . t)
 (ess-fl-keyword:numbers . t)
 (ess-fl-keyword:operators . t)
 (ess-fl-keyword:delimiters . t)
 (ess-fl-keyword:= . t)
 (ess-R-fl-keyword:F&T . t)))
;; ESS:2 ends here

;; [[file:~/.config/doom/config.org::*Snippet value][Snippet value:2]]
(setq tec/yas-latex-template-preamble "
\\usepackage[pdfa,unicode=true,hidelinks]{hyperref}

\\usepackage[dvipsnames,svgnames,table,hyperref]{xcolor}
\\renewcommand{\\UrlFont}{\\ttfamily\\small}

\\usepackage[a-2b]{pdfx} % why not be archival

\\usepackage[T1]{fontenc}
\\usepackage[osf,helvratio=0.9]{newpxtext} % pallatino
\\usepackage[scale=0.92]{sourcecodepro}

\\usepackage[varbb]{newpxmath}
\\usepackage{mathtools}
\\usepackage{amssymb}

\\usepackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=2000]{microtype}
% microtype makes text look nicer

\\usepackage{graphicx} % include graphics
\\usepackage{grffile} % fix allowed graphicx filenames

\\usepackage{booktabs} % nice table rules
")

(defun tec/yas-latex-get-class-choice ()
  "Prompt user for LaTeX class choice"
  (setq tec/yas-latex-class-choice (ivy-read "Select document class: " '("article" "scrartcl" "bmc") :def "bmc")))

(defun tec/yas-latex-preamble-if ()
  "Based on class choice prompt for insertion of default preamble"
    (if (equal tec/yas-latex-class-choice "bmc") 'nil
             (eq (read-char-choice "Include default preamble? [Type y/n]" '(?y ?n)) ?y)))
;; Snippet value:2 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:1]]
(add-hook 'LaTeX-mode-hook #'mixed-pitch-mode)
;; Editor visuals:1 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:2]]
(setq TeX-fold-math-spec-list
      '(;; missing/better symbols
        ("≤" ("le"))
        ("≥" ("ge"))
        ("≠" ("ne"))
        ("★" ("star"))
        ;; conviniance shorts
        ("‹" ("left"))
        ("›" ("right"))
        ;; private macros
        ("ℝ" ("RR"))
        ("ℕ" ("NN"))
        ("ℤ" ("ZZ"))
        ("ℚ" ("QQ"))
        ("ℂ" ("CC"))
        ("ℙ" ("PP"))
        ("ℍ" ("HH"))
        ("𝔼" ("EE"))
        ("𝑑" ("dd"))
        ;; known commands
        ("" ("phantom"))
        ("({1}⧸{2})" ("frac"))
        ("‘{1}’" ("text"))
        ;; private commands
        ("|{1}|" ("abs"))
        ("‖{1}‖" ("norm"))
        ("⌊{1}⌋" ("floor"))
        ("⌈{1}⌉" ("ceil"))
        ("⌊{1}⌉" ("round"))
        ("⭡{1}" ("vec"))
        ("𝑑{1}⧸𝑑{2}" ("dv"))
        ("∂{1}⧸∂{2}" ("pdv"))
        )
      TeX-fold-macro-spec-list
      '(
        ;; as the defaults
        ("[f]" ("footnote" "marginpar"))
        ("[c]" ("cite"))
        ("[l]" ("label"))
        ("[r]" ("ref" "pageref" "eqref"))
        ("[i]" ("index" "glossary"))
        ("..." ("dots"))
        ("{1}" ("emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt"
            "textbf" "textsc" "textup"))
        ;; tweaked defaults
        ("©" ("copyright"))
        ("®" ("textregistered"))
        ("™"  ("texttrademark"))
        ("[1]:||►" ("item"))
        ("❡❡ {1}" ("part" "part*"))
        ("❡ {1}" ("chapter" "chapter*"))
        ("§ {1}" ("section" "section*"))
        ("§§ {1}" ("subsection" "subsection*"))
        ("§§§ {1}" ("subsubsection" "subsubsection*"))
        ("¶ {1}" ("paragraph" "paragraph*"))
        ("¶¶ {1}" ("subparagraph" "subparagraph*"))
        ;; extra
        ("⬖ {1}" ("begin"))
        ("⬗ {1}" ("end"))
        ))
;; Editor visuals:2 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:3]]
(defvar +latex-use-TeX-fold t
  "Use TeX fold in TeX-mode.
When set to non-nil, this adds a few hooks/advices to fold stuff.")

;; Fold after cdlatex and snippets.
(defun +TeX-fold-line-ah (&rest _)
  "Auto-fold LaTeX macros after functions that typically insert them."
  (TeX-fold-region (line-beginning-position) (line-end-position)))

(when +latex-use-TeX-fold
  (advice-add #'cdlatex-math-symbol :after #'+TeX-fold-line-ah)
  (advice-add #'cdlatex-math-modify :after #'+TeX-fold-line-ah)
  ;; local after-snippet hook for folding
  (add-hook! 'TeX-mode-hook
    (add-hook 'yas-after-exit-snippet-hook #'+TeX-fold-line-ah nil t))
  ;; TeX-fold messes up the font face a bit too much, so
  (add-hook! 'mixed-pitch-mode-hook
    (when mixed-pitch-mode
      (let ((var-pitch (face-attribute 'variable-pitch :family))
            (var-height (face-attribute 'variable-pitch :height)))
        (add-to-list 'mixed-pitch-fixed-cookie
                     (face-remap-add-relative
                      'TeX-fold-folded-face :family var-pitch :height var-height))))))
;; Editor visuals:3 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:4]]
(after! tex
  (map!
   :map LaTeX-mode-map
   :ei [C-return] #'LaTeX-insert-item

   ;; normal stuff here
   :localleader
   :desc "View" "v" #'TeX-view
   (:when +latex-use-TeX-fold
     :desc "Fold paragraph"     "f"   #'TeX-fold-paragraph
     :desc "Unfold paragraph"   "C-f" #'TeX-fold-clearout-paragraph
     :desc "Fold buffer"        "F"   #'TeX-fold-buffer
     :desc "Unfold buffer"      "C-F" #'TeX-fold-clearout-buffer))
  (setq TeX-electric-math '("\\(" . "")))
;; Editor visuals:4 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:5]]
;; Making \( \) less visible
(defface unimportant-latex-face
  '((t
     :inherit font-lock-comment-face :family "Overpass" :weight light))
  "Face used to make \\(\\), \\[\\] less visible."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `((,(rx (and "\\" (any "()[]"))) 0 'unimportant-latex-face prepend))
 'end)

(font-lock-add-keywords
 'latex-mode
 `((,"\\\\[[:word:]]+" 0 'font-lock-keyword-face prepend))
 'end)
;; Editor visuals:5 ends here

;; [[file:~/.config/doom/config.org::*Editor visuals][Editor visuals:6]]
(setq preview-LaTeX-command '("%`%l \"\\nonstopmode\\nofiles\
\\PassOptionsToPackage{" ("," . preview-required-option-list) "}{preview}\
\\AtBeginDocument{\\ifx\\ifPreview\\undefined"
preview-default-preamble "\\fi}\"%' \"\\detokenize{\" %t \"}\""))
;; Editor visuals:6 ends here

;; [[file:~/.config/doom/config.org::*CDLaTeX][CDLaTeX:1]]
(after! cdlatex
  (setq ;; cdlatex-math-symbol-prefix ?\; ;; doesn't work at the moment :(
   cdlatex-math-symbol-alist
   '( ;; adding missing functions to 3rd level symbols
     (?_    ("\\downarrow"  ""           "\\inf"))
     (?^    ("\\uparrow"    ""           "\\sup"))
     (?k    ("\\kappa"      ""           "\\ker"))
     (?m    ("\\mu"         ""           "\\lim"))
     (?c    (""             "\\circ"     "\\cos"))
     (?d    ("\\delta"      "\\partial"  "\\dim"))
     (?D    ("\\Delta"      "\\nabla"    "\\deg"))
     ;; no idea why \Phi isnt on 'F' in first place, \phi is on 'f'.
     (?F    ("\\Phi"))
     ;; now just conveniance
     (?.    ("\\cdot" "\\dots"))
     (?:    ("\\vdots" "\\ddots"))
     (?*    ("\\times" "\\star" "\\ast")))
   cdlatex-math-modify-alist
   '( ;; my own stuff
     (?B    "\\mathbb"        nil          t    nil  nil)
     (?a    "\\abs"           nil          t    nil  nil))))
;; CDLaTeX:1 ends here

;; [[file:~/.config/doom/config.org::*Editor Visuals][Editor Visuals:1]]
(after! ess-r-mode
  (appendq! +pretty-code-symbols
            '(:assign "⟵"
              :multiply "×"))
  (set-pretty-symbols! 'ess-r-mode
    ;; Functional
    :def "function"
    ;; Types
    :null "NULL"
    :true "TRUE"
    :false "FALSE"
    :int "int"
    :floar "float"
    :bool "bool"
    ;; Flow
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :in "%in%"
    :return "return"
    ;; Other
    :assign "<-"
    :multiply "%*%"))
;; Editor Visuals:1 ends here

;; [[file:~/.config/doom/config.org::*hledger][hledger:1]]
(setq ledger-mode-should-check-version nil
      ledger-report-links-in-register nil
      ledger-binary-path "hledger")
;; hledger:1 ends here

;; [[file:~/.config/doom/config.org::*Markdown][Markdown:1]]
(add-hook! (gfm-mode markdown-mode) #'mixed-pitch-mode)
;; Markdown:1 ends here

;; [[file:~/.config/doom/config.org::*Markdown][Markdown:2]]
(add-hook! (gfm-mode markdown-mode) #'visual-line-mode #'turn-off-auto-fill)
;; Markdown:2 ends here

;; [[file:~/.config/doom/config.org::*Beancount][Beancount:1]]
(use-package! beancount
  :load-path "~/.config/doom/lisp"
  :mode ("\\.beancount\\'" . beancount-mode)
  :config
  (setq beancount-electric-currency t)
  (defun beancount-bal ()
    "Run bean-report bal."
    (interactive)
    (let ((compilation-read-command nil))
      (beancount--run "bean-report"
                      (file-relative-name buffer-file-name) "bal")))
  ;; TODO make the following *work*
  :bind (:map beancount-mode-map ("S-RET" . #'beancount-align-to-previous-number)))
;; Beancount:1 ends here
