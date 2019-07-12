module Queries
  class TopSellingProductsController < ApplicationController
    def index
      # @q = TopSellingProducts
      @q = TopSellingProducts.top_ten
    end
  end
end
