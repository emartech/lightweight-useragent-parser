UAS = File.read('../spec/data/10K.txt').split("\n")

$LOAD_PATH.unshift File.expand_path(File.join('..','lib'))
require 'lightweight_user_agent_parser'

UAS.each do |user_agent_string|

  ua = LightweightUserAgentParser.new user_agent_string
  p ua.to_hash

  exit
end
