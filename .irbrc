# require "rubygems"
# require "activesupport"
require "pp"
require "irb/completion"
# require "what_methods"
# require "irb/ext/save-history"
# require "wirble"
# require "utility_belt"
begin
  require 'irbtools'
rescue LoadError
end
begin
  require 'awesome_print'
rescue LoadError
end


IRB.conf[:USE_READLINE] = true                          # Enable Readline support
IRB.conf[:SAVE_HISTORY] = 100_000                       # Sets the number of lines of history to save.
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history" # Sets the path to the file where the history will be saved.
IRB.conf[:USE_COLORIZE] = true                          # Enable Color Display
IRB.conf[:AUTO_INDENT] = true                           # Enabled automatic indentation when entering multiline input (Ruby 3.1+)
IRB.conf[:PROMPT_MODE] = :DEFAULT                       # To change the style of prompts

# Wirble.init(:skip_prompt => :DEFAULT)
# Wirble.colorize
