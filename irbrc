ARGV.concat ["--readline"]

require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
require 'open-uri'
require 'rubygems'

begin
  require 'wirble'
  Wirble.init(:skip_prompt => true, :skip_history => true)
  Wirble.colorize
rescue LoadError
  puts "No wirble!"
end

# WTF tux?  Are you undefining IRB.conf?
if IRB.methods.detect {|method| method.to_s == 'conf'}
  IRB.conf[:PROMPT][:SHORT] = {
    :PROMPT_I=>"%03n:%i> ",
    :PROMPT_C=>"%03n:%i* ",
    :PROMPT_S=>"%03n:%i%l ",
    :PROMPT_N=>"%03n:%i> ",
    :RETURN=>"%s\n"
  }
  IRB.conf[:SAVE_HISTORY] = 2000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
  IRB.conf[:PROMPT_MODE] = :SHORT
end
