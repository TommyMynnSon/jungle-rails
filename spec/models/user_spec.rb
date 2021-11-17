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
  end
  
end
