;;; set proxy, along with polipo and shadowsocks
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "127.0.0.1:8123")
     ("https" . "127.0.0.1:8123")))
;;set melpa archives, using qinghua university source
(require 'package)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("gnu_origin" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ("melpa_origin" . "http://melpa.org/packages/")))

(package-initialize) ;; You might already have this line

;; set airline theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("d21135150e22e58f8c656ec04530872831baebf5a1c3688030d119c114233c24" "0cd56f8cd78d12fc6ead32915e1c4963ba2039890700458c13e12038ec40f6f5" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" default)))
 '(doc-view-scale-internally nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(require 'airline-themes)
(load-theme 'airline-luna)

;; stop welcome page from start
(setq inhibit-startup-message t)

;; set numbers for every line
(global-linum-mode t)
(setq linum-format "%d ")

;; set auto-complete basis
(require 'auto-complete)
(ac-config-default)
;; leave python mode alone with autocomplete
(setq ac-modes (delq 'python-mode ac-modes))
;;(global-auto-complete-mode t)

;; set flycheck
(require 'use-package)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; set helm
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; set autopair
(require 'autopair)
(autopair-global-mode)

;; set auctex
(require 'auto-complete-auctex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(latex-preview-pane-enable)

;; set yasnippets
(require 'yasnippet)
(require 'yasnippet-snippets)
(yas-global-mode 1)

;; set spell check
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports


;;; Configuration for python
(elpy-enable)
(setq elpy-rpc-python-command "python3")

(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i --simple-prompt")
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=100"))

(require 'ein)
(setq ein:use-auto-complete t)
(setq ein:use-smartrep t)

;;; Configuration for python

;; set neotree
(require 'neotree)

;;; Configuration for doc view auto width

(add-to-list
    'load-path 
    (expand-file-name "others" user-emacs-directory))

(add-hook 'doc-view-mode-hook 'doc-view-fit-width-to-window)
(defadvice doc-view-display (after fit-width activate)
  (doc-view-fit-width-to-window))

;;; Configuration for auto complete c header

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
  (add-to-list 'achead:include-directories '"/usr/include/c++/5")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/5")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/5")
  (add-to-list 'achead:include-directories '"/usr/include/c++/5/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/5/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu")
  )

(add-hook 'cc-mode-hook 'my:ac-c-header-init)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
(setq ac-disable-faces nil)

;;; web beauty Configuration

(require 'js2-mode)
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)

;; impatient-mode for real time html
(require 'impatient-mode)

;; ace-jump-mode for highlight words input
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode) 

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;solidity
(require 'solidity-mode)
(setq solidity-flycheck-solc-checker-active t)

;; racket
(require 'racket-mode)
(setq racket-racket-program "racket")
(setq racket-raco-program "raco")
(add-hook 'racket-mode-hook
(lambda ()
(define-key racket-mode-map (kbd "C-x C-j") 'racket-run)))
(setq tab-always-indent 'complete) ;; 使用tab自动补全

;; max size
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

;;html autocomplete
(defun setup-ac-for-html ()
  ;; Require ac-html since we are setup html auto completion
  (require 'ac-html)
  ;; Require default data provider if you want to use
  (require 'ac-html-default-data-provider)
  ;; Enable data providers,
  ;; currently only default data provider available
  (ac-html-enable-data-provider 'ac-html-default-data-provider)
  ;; Let ac-html do some setup
  (ac-html-setup)
  ;; Set your ac-source
  (setq ac-sources '(ac-source-html-tag
                     ac-source-html-attr
                     ac-source-html-attrv))
  ;; Enable auto complete mode
  (auto-complete-mode))

(add-hook 'html-mode-hook 'setup-ac-for-html)

;;; init.el ends here
