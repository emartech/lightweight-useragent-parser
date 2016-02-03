require 'lightweight_user_agent_parser/version'
require 'lightweight_user_agent_parser/regexp'
require 'lightweight_user_agent_parser/content_analyzer'

class LightweightUserAgentParser

  # include ContentAnalyzer

  public

  attr_reader :user_agent_string
  alias to_s user_agent_string

  def initialize(user_agent_str)
    @user_agent_string = user_agent_str || raise(ArgumentError)
  end

  def platform
    @platform ||= -> {

      DEVICES.each do |name, regexp|
        if user_agent_string =~ regexp[:strict]
          return name
        end
      end

      DEVICES.each do |name, regexp|
        if user_agent_string =~ regexp[:lazy]
          return name
        end
      end

      # if detected as a mobile such as Nokia C2-01 and others than Symbian
      return :other

    }.call
  end

  def is_mobile?
    mobile = !!(user_agent_string =~ MOBILE_REGEXP)
    desktop = !!(user_agent_string =~ DESKTOP_REGEXP)

    (mobile or not desktop) #and not anonymized?
  end

  alias mobile? is_mobile?

  def anonymized?
    !!(user_agent_string =~ ANONYMIZED_REGEXP)
  end

end