module PgsnapRails
  class Base
    class Error < StandardError; end
    extend Utils::MethodCallingConvenience
    include SqlCommands
  end
end
