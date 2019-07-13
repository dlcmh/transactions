module Queries
  class AllController < ApplicationController
    def index
      @q = Users.table
    end
  end
end
