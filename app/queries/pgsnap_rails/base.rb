module PgsnapRails
  class Base
    class Error < StandardError; end
    extend Utils::MethodCallingConvenience
    include DotCommands
    include Utils::TableName

    def inspect
      'lol'
    end
  end
end
