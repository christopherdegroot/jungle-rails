require 'rails_helper'
require 'products_controller'

RSpec.describe Product, type: :model do
  describe 'Product Validations' do
    it 'Saves a valid product' do
      @category = Category.create(name:"Boats")
      boat = Product.new(
      name: "Walrus",
      price_cents: 10000,
      quantity: 1,
      category_id: @category.id
      )
      expect(boat).to be_valid
    end
    it 'Validates name' do
      @category = Category.create(name:"Boats")
      boat = Product.new(
      name: nil,
      price_cents: 10000,
      quantity: 1,
      category_id: @category.id
      )
      expect(boat).to_not (be_valid)
      expect(boat.errors.full_messages).to include("Name can't be blank")
    end 
    it 'Validates price' do
      @category = Category.create(name:"Boats")
      boat = Product.new(
      name: "Walrus",
      price_cents: nil,
      quantity: 1,
      category_id: @category.id
      )
      expect(boat).to_not (be_valid)
      expect(boat.errors.full_messages).to include("Price can't be blank")
    end 
    it 'Validates quantity' do
      @category = Category.create(name:"Boats")
      boat = Product.new(
      name:  "Walrus",
      price_cents:  10000,
      quantity:  nil,
      category_id: @category.id
      )
      expect(boat).to_not (be_valid)
      expect(boat.errors.full_messages).to include("Quantity can't be blank")
    end 
    it 'Validates category' do
      @category = Category.create(name:"Boats")
      boat = Product.new(
      name: "Walrus",
      price_cents: 10000,
      quantity: 1,
      category_id: nil
      )
      expect(boat).to_not (be_valid)
      expect(boat.errors.full_messages).to include("Category can't be blank")
    end 
  end
end
