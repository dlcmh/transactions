module Queries
  class MonthlySalesTotalController < ApplicationController
    def index
      @q = MonthlySalesTotal
    end
  end
end
