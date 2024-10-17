# require "rubygems"
# require "activesupport"
# require "pp"
# require "irb/completion"
# require "what_methods"
require "irb/ext/save-history"
# # require "wirble"
#
# # require "utility_belt"
#
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 100_000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" # 履歴を保存するファイルのパスを設定します。
# IRB.conf[:AUTO_INDENT] = true

# Wirble.init(:skip_prompt => :DEFAULT)
# Wirble.colorize
