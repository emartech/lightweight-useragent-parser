module LightweightUseragentParser
  module Parser

    def application
      chompify(user_agent_string.scan(/^(.*?)\(/)[0][0])
    end

    def compatible_mod
      inner_content_elements[0]
    end

    def browser_type
      inner_content_elements[1]
    end

    def operation_system
      inner_content_elements[2]
    end

    def to_hash
      (Parser.public_instance_methods(false)-[:to_hash]).reduce({}) do |memory,method_name|
        memory.merge!(method_name => self.public_send(method_name));memory
      end
    end

    protected

    def inner_content_elements
      @inner_content ||= inner_content_string.split(';').map{|str| chompify(str) }
    end

    def inner_content_string
      user_agent_string.scan(/\(((?:.+?)?; .*?\))/)[0][0]
    end

    def chompify(str)
      str.gsub(/^ *(.*) *$/,'\1')
    end

  end
end