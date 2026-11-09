
;;; Org templates

(setq org-capture-templates
      '(("h" "Homework" entry (file "~/org/homework.org")
	 "* TODO %? :homework:%^{Matière}g\n%i"
	 :jump-to-captured t)
	("m" "Meeting" entry (file "~/org/meetings.org")
	 "* MEETING %?\n  SCHEDULED: %^{Date}t\n"
	 :jump-to-captured t)
	("w" "Work")
	("we" "EIP" entry (file+headline "~/org/projects.org" "EIP")
	 "* TODO %? %^{Type}g\n%i"
	 :jump-to-captured t)
	))

;; ---------------------------------------------------------------------------
;; Org-roam
;; ---------------------------------------------------------------------------

(setq org-roam-directory (file-truename "~/org-roam/"))

;; Helper: create a directory if it doesn't exist.
(defun my/org-roam-create-dir (dir)
  "Create DIR and its parents if they don't exist."
  (unless (file-directory-p dir)
    (make-directory dir t)))

;; Helper: return today's course directory.
(defun my/org-roam-course-dir (course)
  "Return the directory for COURSE, creating it if necessary."
  (let ((dir (expand-file-name
              (format "%s/courses/%s/%s/"
                      org-roam-directory
                      course
                      (format-time-string "%Y-%m-%d")))))
    (my/org-roam-create-dir dir)
    dir))

;; Directory for general notes/programming/learning.
(my/org-roam-create-dir
 (expand-file-name "notes/" org-roam-directory))


(setq org-roam-capture-templates
      `(
        ;; -------------------------------------------------------------------
        ;; Courses
        ;; -------------------------------------------------------------------

        ("c" "course")

        ("ce" "Software Engineering (SWE)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "SWE")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :SWE:\n\n")
         :unnarrowed t
	 :jump-to-captured t)

        ("cv" "Software Validation and Verification (SVV)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "SVV")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :SVV:\n\n")
         :unnarrowed t
	 :jump-to-captured t)

        ("cm" "Modern Distributed Systems (MDS)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "MDS")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :MDS:\n\n")
         :unnarrowed t
	 :jump-to-captured t)

        ("cg" "German (G)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "G")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :G:\n\n")
         :unnarrowed t
	 :jump-to-captured t)

        ("cp" "Software Project (SPO)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "SPO")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :SPO:\n\n")
         :unnarrowed t
	 :jump-to-captured t)

        ("cc" "Computer Vision (EM1)"
         plain
         "%?"
         :target
         (file+head
          ,(lambda ()
             (concat
              (my/org-roam-course-dir "EM1")
              "%<%Y-%m-%d>-${slug}.org"))
          "#+title: ${title}\n#+date: %U\n#+filetags: :EM1:\n\n")
         :unnarrowed t
	 :jump-to-captured t)


        ;; -------------------------------------------------------------------
        ;; General notes
        ;; -------------------------------------------------------------------

        ("n" "note"
         plain
         "* %?\n"
         :target
         (file+head
          "notes/${slug}.org"
          "#+title: ${title}\n#+date: %U\n\n")
         :unnarrowed t
	 :jump-to-captured t)


        ;; -------------------------------------------------------------------
        ;; Programming language syntax / hacks
        ;; -------------------------------------------------------------------

        ("p" "programming"
         plain
         "* %?\n"
         :target
         (file+head
          "notes/${slug}.org"
          "#+title: ${title}\n#+date: %U\n#+filetags: :programming:\n\n")
         :unnarrowed t
	 :jump-to-captured t)


        ;; -------------------------------------------------------------------
        ;; Learning
        ;; -------------------------------------------------------------------

        ("l" "learning"
         plain
         "* %?\n"
         :target
         (file+head
          "notes/${slug}.org"
          "#+title: ${title}\n#+date: %U\n#+filetags: :learning:\n\n")
         :unnarrowed t
	 :jump-to-captured t)
        ))
