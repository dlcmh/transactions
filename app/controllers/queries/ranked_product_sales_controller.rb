module Queries
  class RankedProductSalesController < ApplicationController
    def index
      @q = RankedProductSales.top_and_bottom_ten
    end
  end
end
