class LightweightUserAgentParser
  module ContentAnalyzer

    def application
      chompify(user_agent_string.scan(/^(.*?) *\(/)[0][0]) rescue nil
    end

    def compatible_mod
      inner_content_elements && inner_content_elements[0]
    end

    def browser_type
      inner_content_elements && inner_content_elements[1]
    end

    def operation_system
      inner_content_elements && inner_content_elements[2]
    end

    def to_hash
      (ContentAnalyzer.public_instance_methods(false)-[:to_hash]).reduce({}) do |memory,method_name|
        memory.merge!(method_name => self.public_send(method_name));memory
      end
    end

    protected

    def inner_content_elements
      @inner_content ||= lambda {
        raw_content_section = inner_content_string
        return nil if raw_content_section.nil?
        raw_content_section.split(';').map{|str| chompify(str) }
      }.call
    end

    def inner_content_string
      user_agent_string.scan(/\(((?:.+?)?; .*?\))/)[0][0] rescue nil
    end

    def chompify(str)
      str.gsub(/^ *(.*) *$/,'\1')
    end

  end
end