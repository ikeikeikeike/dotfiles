# -*- coding: utf-8 -*-
require 'rubygems'
# require 'activesupport'
require 'pp'
# メソッド補完 autocomplete
require 'irb/completion'
# # what? でメソッドを調べる
# require 'what_methods'
# history
require 'irb/ext/save-history'

# カラーリングの設定
require 'wirble'

# require 'utility_belt'

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_PATH] = File::expand_path("~/.irb.history")
IRB.conf[:AUTO_INDENT] = true

Wirble.init(:skip_prompt => :DEFAULT)
Wirble.colorize



