;;; ruby-block-posframe --- ruby-block's posframe extension

;; Copyright (C) 2019- blue0513

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: blue0513
;; URL: https://github.com/blue0513/ruby-block-posframe
;; Version: 0.1.0

;;; Commentary:

;; Edit your init.el
;;
;; (require 'ruby-block-posframe)
;;

;;; Code:

(require 'ruby-block)
(require 'posframe)

(defvar ruby-block-posframe-buffer " *ruby-block-posframe*")
(defcustom ruby-block-posframe-background "black"
  "Background color for posframe."
  :type 'string
  :group 'ruby-block-posframe)

(defun ruby-block-function ()
  "Point position's word decides behavior."
  (let* ((cur (current-word))
         ;; if point after END, dec point and get face
         (p (point))
         (face (get-text-property p 'face))
         (p (if (and (eq nil face) (> p 3))
                (1- p)
              p)))
    (when (and (member cur '("else" "elsif" "end"))
               (eq face 'font-lock-keyword-face))
      (let* ((pos (ruby-block-corresponding-position p))
             (sp (ruby-block-line-beginning-position pos))
             (ep (ruby-block-line-end-position pos)))
        (when pos
          (let* ((line-num (1+ (count-lines (point-min) sp)))
                 (corresponding-block (buffer-substring sp ep))
                 (str (format "%d: %s" line-num corresponding-block)))
            ;; display line contents to `posframe'
            (when (memq ruby-block-highlight-toggle '(t posframe))
              (ruby-block-show-posframe str))
            ;; display line contents to minibuffer
            (when (memq ruby-block-highlight-toggle '(t minibuffer))
              (message str))
            ;; do overlay
            (when (memq ruby-block-highlight-toggle '(t overlay))
              (ruby-block-do-highlight sp ep))))))))

(defun ruby-block-show-posframe (str)
  (posframe-show ruby-block-posframe-buffer
                 :string str
                 :background-color ruby-block-posframe-background)
  (add-hook 'pre-command-hook 'ruby-block-posframe-hide))

(defun ruby-block-posframe-hide ()
  (remove-hook 'pre-command-hook 'ruby-block-posframe-hide)
  (posframe-hide ruby-block-posframe-buffer))

;; * provide

(provide 'ruby-block-posframe)

;;; ruby-block-posframe.el ends here
