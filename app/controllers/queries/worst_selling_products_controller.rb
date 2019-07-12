module Queries
  class WorstSellingProductsController < ApplicationController
    def index
      @q = WorstSellingProducts.bottom_ten
    end
  end
end
