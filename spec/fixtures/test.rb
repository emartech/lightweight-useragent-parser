require_relative '../spec_helper'
require 'yaml'

start_time= Time.now
TEST_DATA.each do |user_agent_string|

  agent = LightweightUserAgentParser.new(user_agent_string)

  if agent.mobile? == false && LightweightUserAgentParser::MOBILE_DEVICES.include?(agent.platform)
    p agent.to_s
    $stdin.gets
  end

end
puts Time.now - start_time

