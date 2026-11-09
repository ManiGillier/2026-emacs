
;;; Packages

(use-package org
  :straight t
  :bind (("C-c c" . org-capture)
         ("C-c n c" . org-capture)
	 ("C-c C-w" . my-calendar))
  :bind (:map org-mode-map
	      ("C-c C-f" . org-refile)
	      ("C-c C-w" . my-calendar)))

(use-package el-patch
  :straight t)
(use-package magit
  :straight t)
(use-package org-roam
  :straight t
  :bind
  (("C-c +" . org-roam-capture)
   ("C-c /" . org-roam-node-find)
   ("C-c *" . org-roam-graph)
   :map org-mode-map
   ("C-+" . org-roam-node-insert)
   ("C-/" . org-roam-node-find)
   ("C-*" . org-roam-graph)
   ))

; Download screenshots inside org directly
(use-package org-download
  :straight t
  :after org
  :bind
  (:map org-mode-map
        (("C-M-s" . org-download-screenshot) ; Screen
         ("C-M-p" . org-download-yank)))) ; Paste

;; (use-package org-fc
;;   :straight t
;;   :demand t
;;   :bind ("C-c f d" . org-fc-dashboard)
;;   :bind ("C-c f r" . org-fc-review-early)
;;   :config
;;   (setq org-fc-directories '("~/org/"))
;;   (setq org-fc-index-function #'org-fc-awk-index))

(use-package markdown-mode
  :straight t)

;;; Org & Org Roam config

;; Org roam configuration
(setq org-roam-directory (file-truename "~/org-roam"))
(org-roam-db-autosync-mode) ; On file change, sync
(require 'org-roam-export) ; Better support of org roam export

; Winner mode : browse easily through clicked notes
(winner-mode +1)
(define-key winner-mode-map (kbd "<M-left>") #'winner-undo)
(define-key winner-mode-map (kbd "<M-right>") #'winner-redo)

;;; Programming config

(use-package treemacs
  :straight t
  :config
  (treemacs-follow-mode nil) ; Don't follow the current file
  (treemacs-filewatch-mode t)
  (add-hook 'emacs-startup-hook #'treemacs)) ; Open treemacs on startup

(use-package company-box
  :straight t)

;; Eglot configuration

(use-package eglot
  :ensure nil
  :hook ((python-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	 (c-mode . eglot-ensure)
	 (java-mode . eglot-ensure)
	 (rust-mode . eglot-ensure)
	 (go-mode . eglot-ensure)
	 (js-mode . eglot-ensure)
	 (typescript-mode . eglot-ensure)
	 (csharp-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t
	eglot-workspace-configuration
	'(:csharp (:applyFormattingOptions t))))

(add-hook 'c-mode-hook
          (lambda ()
            (setq-local c-basic-offset 4)))

(use-package corfu
  :straight t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-cycle t)
  :init
  (global-corfu-mode))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic)))

(use-package cape
  :straight t)

(with-eval-after-load 'eglot
  (define-key eglot-mode-map [C-down-mouse-1] #'xref-find-definitions)
  (define-key eglot-mode-map [C-down-mouse-3] #'xref-go-back))

;;; AI config

(use-package copilot
  :straight t
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :bind ("C-c v" . copilot-mode)
  :config
  (add-to-list 'copilot-indentation-alist '(c-mode c-basic-offset)))

(setq copilot-indent-offset-warning-disable t)

;;; Calendar

(use-package calfw
  :straight (:host github
		   :repo "kiwanami/emacs-calfw")
  :demand t)

(use-package calfw-org
  :straight (:host github
		   :repo "kiwanami/emacs-calfw")
  :after calfw
  :demand t)

(setq org-agenda-files '("~/org/" "~/org/agenda/"))

(use-package org-hyperscheduler
  :straight t
  :config
  (setq org-hyperscheduler-readonly-mode nil))

(defun my-square-calendar ()
  (interactive)
  (calfw-open-calendar-buffer
   :contents-sources
   (list
    (calfw-org-create-source nil "org-agenda" "Green")  ; orgmode source from org-agenda files
    )))

;; native org-agenda + a
(defun my-calendar ()
  (interactive)
  (org-agenda nil "a"))

;;; Holidays

;; Clear the default holidays

(setq calendar-holidays nil)

;; German and Baden Württemberg holidays

(setq baden-wuerttemberg-holidays
      '((holiday-fixed 1 1 "Neujahrstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -2 "Karfreitag")
        (holiday-easter-etc 1 "Ostermontag")
        (holiday-fixed 5 1 "Tag der Arbeit")
        (holiday-easter-etc 39 "Christi Himmelfahrt")
        (holiday-easter-etc 50 "Pfingstmontag")
        (holiday-easter-etc 60 "Fronleichnam")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")
        (holiday-fixed 11 1 "Allerheiligen")
        (holiday-fixed 12 25 "Erster Weihnachtstag")
        (holiday-fixed 12 26 "Zweiter Weihnachtstag")))

;;; French holidays

(setq french-holidays
      '((holiday-fixed 1 1 "Jour de l'An")
	(holiday-fixed 5 1 "Fête du Travail")
	(holiday-fixed 5 8 "Victoire 1945")
	(holiday-easter-etc -2 "Vendredi Saint")
	(holiday-easter-etc 1 "Lundi de Pâques")
	(holiday-easter-etc 39 "Ascension")
	(holiday-easter-etc 50 "Lundi de Pentecôte")
	(holiday-fixed 7 14 "Fête Nationale")
	(holiday-fixed 8 15 "Assomption")
	(holiday-fixed 11 1 "Toussaint")
	(holiday-fixed 11 11 "Armistice")
	(holiday-fixed 12 25 "Noël")))

;;; Reset the new holidays

(setq calendar-holidays (append baden-wuerttemberg-holidays french-holidays))

;;; Bindings

;; Open the calendar
(global-set-key (kbd "C-c w") 'my-square-calendar)
(global-set-key (kbd "C-c W") 'my-calendar)
(global-set-key (kbd "C-c C-w") 'my-calendar)
(global-set-key (kbd "<f5>") 'calc)

;;; Jupyter

(use-package ein
  :straight t)

;;; Org babel

;; Org babel for c

(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)))

;; Org babel execute for c


