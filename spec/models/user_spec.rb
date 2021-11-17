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

    it 'should not be valid if password and password_confirmation do not match' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '1111'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

      @user.password_confirmation = '0000'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should not be valid if password and password_confirmation are not set' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")

      @user.password = '0000'
      @user.password_confirmation = '0000'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should not be valid if email set already exists in database' do
      @user_1 = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user_1.save

      expect(@user_1.errors.full_messages).to be_empty

      @user_2 = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user_2.save

      expect(@user_2.errors.full_messages).to include("Email has already been taken")

      @user_2.email = 'johndoe1@gmail.com'

      @user_2.save

      expect(@user_2.errors.full_messages).to be_empty
    end
  end
  
end