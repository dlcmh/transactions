module PgsnapRails
  class Builder
    class Error < StandardError; end

    def self.method_missing(method, *args, &block)
      new.send(method, *args, &block)
    end

    attr_reader :built_sql, :nodes

    def build(nodes)
      @nodes = nodes
      build_from_table_command
      built_sql
    end

    private

    def build_from_table_command
      return unless nodes[:table_command]
      overwrite_built_sql [
        nodes[:table_command][:command],
        nodes[:table_command][:args].last
      ].join(' ')
    end

    def overwrite_built_sql(str)
      @built_sql = str
    end
  end
end
