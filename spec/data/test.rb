require_relative '../spec_helper'
require 'yaml'

start_time= Time.now
TEST_DATA.each do |user_agent_string|

  agent = LightweightUseragentParser.new(user_agent_string)

  if agent.mobile? == false && LightweightUseragentParser::FOLLOWED_MOBILE_DEVICES.include?(agent.platform)
    p agent.to_s
    $stdin.gets
  end

end
puts Time.now - start_time

