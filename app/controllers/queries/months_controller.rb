module Queries
  class MonthsController < ApplicationController
    def index
      # @q = Months
      @q = Months.descending_months
    end
  end
end
