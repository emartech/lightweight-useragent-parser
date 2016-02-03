require 'digest/md5'

require 'lightweight_user_agent_parser/version'
require 'lightweight_user_agent_parser/regexp'
require 'lightweight_user_agent_parser/content_analyzer'

class LightweightUserAgentParser

  # include ContentAnalyzer

  public

  attr_reader :user_agent_string
  alias to_s user_agent_string

  def initialize(user_agent_str)
    @user_agent_string = (user_agent_str || raise(ArgumentError)).to_s
  end

  def platform
    @platform ||= lambda {

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

      return :other

    }.call
  end

  def is_mobile?
    mobile = !!(user_agent_string =~ MOBILE_REGEXP)
    desktop = !!(user_agent_string =~ DESKTOP_REGEXP)

    (mobile or not desktop) and not empty?
  end
  alias mobile? is_mobile?

  def anonymized?
    !!(user_agent_string =~ ANONYMIZED_REGEXP)
  end

  def md5
    Digest::MD5.hexdigest(user_agent_string)
  end

  def to_hash
    (TO_HASH_METHODS).reduce({}) do |memory, method_name|
      hash_key = method_name.to_s.sub(/\?$/, '').to_sym

      memory.merge!(hash_key => self.public_send(method_name))

      memory
    end
  end

  protected

  def empty?
    user_agent_string.empty?
  end

  TO_HASH_METHODS = self.public_instance_methods(false)-[:to_hash, :user_agent_string, :to_s, :is_mobile?]

end