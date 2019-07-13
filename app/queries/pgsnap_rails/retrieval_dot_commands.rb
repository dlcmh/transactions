module PgsnapRails
  module RetrievalDotCommands
    def all
      build_missing_select
      retrieve_results_from_database
      @retrieval_done = true
      results.to_a
    end

    def columns
      current_limit = nodes.dig(:limit_clause, :args)&.last
      limit(0)
      retrieve_results_from_database
      r = results.columns
      if current_limit
        limit(current_limit)
      else
        remove_node(:limit_clause)
      end
      r
    end
  end
end
