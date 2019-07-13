module Queries
  class AllController < ApplicationController
    def index
      @q = Users
    end
  end
end
