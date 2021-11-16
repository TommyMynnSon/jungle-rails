require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'is valid to be saved if name, price/price_cents, quantity, and category are set' do
      @category = Category.new(name: 'Refurbished')
      
      @product = Product.new(
                              name: 'Refurbished iPhone 13 PRO MAX 128GB',
                              price: 500,
                              quantity: 1,
                              category: @category
                            )
        
      expect(@product).to be_valid
    end

    it 'should not be valid if name is not set' do
      @category = Category.new(name: 'Refurbished')
      
      @product = Product.new(
        price: 500,
        quantity: 1,
        category: @category
      )

      @product.valid?

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not be valid if price is not set' do
      @category = Category.new(name: 'Refurbished')

      @product = Product.new(
        name: 'Refurbished iPhone 13 PRO MAX 128GB',
        quantity: 1,
        category: @category
      )

      @product.valid?

      expect(@product.errors.full_messages).to include("Price can't be blank")

      @product.price = 500

      @product.valid?

      expect(@product.errors.full_messages).to be_empty
    end

    it 'something' do
      
    end

    it 'something' do
      
    end
  end

end

# it "is valid" do
#   @product = Product.new
#   @cat = Category.new
#   @cat.name = 'Test'
#   @product.name = 'Test' # invalid state
#   @product.price_cents = 12311
#   @product.quantity = 3
#   @product.category = @cat
#   expect(@product.valid?).to be true
# end