module PgsnapRails
  class Base
    class Error < StandardError; end
    extend Utils::MethodCallingConvenience
    include DotCommands
    include Utils::TableName
    include Utils::ReturnSelf

    def inspect
      'lol'
    end
  end
end
