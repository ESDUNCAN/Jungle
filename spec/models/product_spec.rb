require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "inital example to ensure a product with all four filed will save successfully" do
      @product = Product.new
      @category = Category.new
      @category.name = "blah"
      @product.name = "hello"
      @product.price = 10
      @product.quantity = 5
      @product.category = @category
      expect(@product.valid?).to eq true
    end
    
    it "validates that the name is present" do
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")

      @product.name = "John"
      @product.valid?
      expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it "validates that the price is present" do 
      @product = Product.new
      @product.price = "hello"
      @product.valid?
      expect(@product.errors[:price]).to include("is not a number")

      # @product.price = nil
      # @product.valid?
      # expect(@product.errors[:price]).to include("is not a number")

      @product.price = 123456
      @product.valid?
      expect(@product.errors[:price]).not_to include("is not a number" || "can't be blank" )
    end

    it "validates that the quantity is present" do
      @product = Product.new
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")

      @product.quantity = 1
      @product.valid?
      expect(@product.errors[:quantity]).not_to include("can't be blank")
    end

    it "validates that the category is present" do 
      @category = Category.new
      @product = Product.new
      @product.category = nil
      @product.valid?
      expect(@product.errors[:category]).to include ("must exist")

      @product.category = @category
      @product.valid?
      expect(@product.errors[:category]).not_to include ("must exist")
    end
  end
end
