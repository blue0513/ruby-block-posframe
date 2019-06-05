# Ruby Block Posframe

Greatly respecting [ruby-block.el](https://github.com/juszczakn/ruby-block).

[![Image from Gyazo](https://i.gyazo.com/4005e288138683fc90d6ba112887b215.png)](https://gyazo.com/4005e288138683fc90d6ba112887b215)

## Requirements

+ [ruby-block.el](https://github.com/juszczakn/ruby-block)
+ [posframe.el](https://github.com/tumashu/posframe)

## Usage

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'ruby-block-posframe)
(ruby-block-mode t)

;; show with posframe
(setq ruby-block-highlight-toggle 'posframe)
;; show with others. see ruby-block.el in detail
(setq ruby-block-highlight-toggle t)
```

## Custom

You can change background-color of posframe.

```elisp
(setq ruby-block-posframe-background "YOUR COLOR")
```
