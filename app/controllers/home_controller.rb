class HomeController < ApplicationController
  def index
    @queries = Rails.application.routes.routes.map do |route|
      route.defaults[:controller]
    end.uniq.compact.select { |c| c.starts_with?('queries') }
  end
end
