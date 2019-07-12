module Queries
  class BestsellingAuthorsController < ApplicationController
    def index
      @q = BestsellingAuthors.top_ten
    end
  end
end
