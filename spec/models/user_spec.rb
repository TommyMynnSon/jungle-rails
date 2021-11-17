require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'is valid to be saved if name, email, password, and password_confirmation are set' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      expect(@user).to be_valid
    end

    it 'should not be valid if password is not set and password_confirmation is set' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password_confirmation: '0000'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Password can't be blank")

      @user.password = '0000'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should not be valid if password is set and password_confirmation is not set' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")

      @user.password_confirmation = '0000'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end
  end
  
end
