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

    it 'should not be valid if email set already exists in database (case_sensitive: true)' do
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

    it 'should not be valid if email set already exists in database (case_sensitive: false)' do
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
        email: 'johnDOE@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user_2.save

      expect(@user_2.errors.full_messages).to include("Email has already been taken")

      @user_2.email = 'johndoe1@gmail.com'

      @user_2.save

      expect(@user_2.errors.full_messages).to be_empty
    end

    it 'should not be valid if email is not set' do
      @user = User.new(
        name: 'John Doe',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Email can't be blank")

      @user.email = 'johndoe@gmail.com'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should not be valid if name is not set' do
      @user = User.new(
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Name can't be blank")

      @user.name = 'John Doe'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should not be valid if password is less than 2 characters' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0',
        password_confirmation: '0'
      )

      @user.valid?

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 2 characters)")

      @user.password = '00'
      @user.password_confirmation = '00'

      @user.valid?

      expect(@user.errors.full_messages).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with valid credentials' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.save
  
      @result = User.authenticate_with_credentials(@user.email, @user.password)
      
      expect(@result).not_to be_nil
    end

    it 'should not authenticate with invalid credentials' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '1111'
      )

      @user.save
  
      @result = User.authenticate_with_credentials(@user.email, '1111')
      
      expect(@result).to be_nil
    end

    it 'should authenticate with white spaces in email' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.save
  
      @result = User.authenticate_with_credentials(' johndoe@gmail.com ', @user.password)
      
      expect(@result).not_to be_nil
    end

    it 'should authenticate with unmatching letter casing in email' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.save
  
      @result = User.authenticate_with_credentials('JOHNDOE@GmAiL.COM', @user.password)
      
      expect(@result).not_to be_nil
    end

    it 'should authenticate with white spaces and unmatching letter casing in email' do
      @user = User.new(
        name: 'John Doe',
        email: 'johndoe@gmail.com',
        password: '0000',
        password_confirmation: '0000'
      )

      @user.save
  
      @result = User.authenticate_with_credentials(' JOHNDOE@GmAiL.COM ', @user.password)
      
      expect(@result).not_to be_nil
    end
  end
  
end