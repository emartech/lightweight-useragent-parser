UAS = File.read('public/10K.txt').split("\n")

require_relative 'lib/lightweight_useragent_parser'


UAS.each do |user_agent_string|

  ua = LightweightUseragentParser.new user_agent_string
  p ua.to_hash

end
