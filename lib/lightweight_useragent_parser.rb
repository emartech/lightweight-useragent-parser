require 'lightweight_useragent_parser/version'
require 'lightweight_useragent_parser/regexp'
require 'lightweight_useragent_parser/parser'

module LightweightUseragentParser

  class Instance

    # include Parser

    public

    attr_reader :user_agent_string

    alias to_s user_agent_string

    def initialize(user_agent_str)
      @user_agent_string = user_agent_str || raise(ArgumentError)
    end

    def platform
      @platform ||= -> {

        DEVICES.each do |name,regexp|
          if user_agent_string =~ regexp[:strict]
            return name
          end
        end

        DEVICES.each do |name,regexp|
          if user_agent_string =~ regexp[:lazy]
            return name
          end
        end

        # if detected as a mobile such as Nokia C2-01 and others than Symbian
        return is_mobile? ? lightweight-useragent-parser::NameTable.symbian : :other

      }.call
    end

    def is_mobile?
      !!(user_agent_string =~ MOBILE_REGEXP)
    end

    def platform_by_followed_devices

      if platform == :other
        raise(ArgumentError,'Unknown UserAgentString, cant determine without futher implementation, that the agent\'s platform is not a followed one')
      end

      if FOLLOWED_MOBILE_DEVICES.include?(platform)
        platform
      else
        :other
      end

    end

    alias mobile? is_mobile?

  end

  def self.new(*args)
    Instance.new(*args)
  end

end