class Admin::DashboardController < ApplicationController
  def show
      @productCount = Product.all.count
      @categoriesCount = Category.all.count
  end
end
