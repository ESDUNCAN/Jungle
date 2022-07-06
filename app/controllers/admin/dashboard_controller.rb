class Admin::DashboardController < ApplicationController

  before_action :authorize

  def show
      @productCount = Product.all.count
      @categoriesCount = Category.all.count
  end
end
