module PgsnapRails
  module Utils
    module Echo
      def echo(args)
        puts "#{self.class.name} #{args}"
      end
    end
  end
end
