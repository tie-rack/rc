# NOT script/server!
unless $0.match(/script\/server/)
  
  # For all versions
  
  IRB_START_TIME = Time.now

  ARGV.concat [ "--readline"]

  require 'irb/completion'
  require 'irb/ext/save-history'
  require 'pp'
  require 'open-uri'
  require 'rubygems'
  
  # WTF tux?  Are you undefining IRB.conf?
  if IRB.methods.detect {|method| method.to_s == 'conf'}
    # Wirble - not in emacs, though
    unless ENV['INSIDE_EMACS']
      require 'wirble'
      Wirble.init(:skip_prompt => true, :skip_history => true)
      Wirble.colorize
    end

    # This happens after everything else.  Including Rails if
    # this is happening in script/console
    IRB.conf[:IRB_RC] = Proc.new do
      ActiveResource::Base.logger = Logger.new(STDOUT) if defined?(ActiveResource)
      HyperactiveResource.logger = Logger.new(STDOUT) if defined?(HyperactiveResource)
      if RUBY_VERSION < '1.9'
        begin
          require 'guessmethod' unless defined?(Rails)
          require 'duration'  # Duration manually fixed for 1.9
          at_exit { puts Duration.new(Time.now - IRB_START_TIME) }
        rescue LoadError
          # whatever
        end
      end
    end

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
end
