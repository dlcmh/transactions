module PgsnapRails
  module Sql
    module Commands
      class Base
        class Error < StandardError; end
        extend Utils::MethodCallingConvenience
        include Utils::Echo

        def build
          raise Error, 'Not implemented'
        end
      end
    end
  end
end
