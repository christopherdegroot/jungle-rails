require 'rails_helper'
require 'users_controller'
require 'user'

user = User.create(
  name: "Chris De Groot",
  password: "123",
  password_confirmation: "123",
  email: "cdg@gmail.com"
)

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it 'Saves a valid user' do
      user = User.create(
        name: "Chris De Groot",
        password: "123",
        password_confirmation: "123",
        email: "chrisdg@gmail.com"
      )
      expect(user).to be_valid
    end 
    it 'validates name' do
      user = User.create(
        name: nil,
        password: "123",
        password_confirmation: "123",
        email: "chris@gmail.com"
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it 'validates password when left empty' do
      user = User.create(
        name: "Chris De Groot",
        password: "",
        password_confirmation: "",
        email: "chris@gmail.com"
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'validates password when password too short' do
      user = User.create(
        name: "Chris De Groot",
        password: "12",
        password_confirmation: "12",
        email: "chris@gmail.com"
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
    it 'validates password when mismatched' do
      user = User.create(
        name: "Chris De Groot",
        password: "123",
        password_confirmation: "124",
        email: "chris@gmail.com"
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates email when left blank' do
      user = User.create(
        name: "Chris De Groot",
        password: "123",
        password_confirmation: "123",
        email: nil
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'validates email' do
   
      user = User.create(
        name: "Chris De Groot",
        password: "123",
        password_confirmation: "123",
        email: "cdg@gmail.com"
      )
      puts user.errors.full_messages
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should return nil with incorrect credentials' do
      user = User.create(
        name: "Chris De Groot",
        password: "1234",
        password_confirmation: "1234",
        email: "cdeg@gmail.com"
      )
      authenticate = User.authenticate_with_credentials('cdg@gmail.com', user.password )
      puts(authenticate.inspect)
    end 
    it 'should return with user with correct credentials' do
      user = User.create(
        name: "Christopher De Groot",
        password: "1234",
        password_confirmation: "1234",
        email: "christopher@gmail.com"
      )
      authenticate = User.authenticate_with_credentials('christopher@gmail.com', user.password )
      puts(authenticate[:name])
      expect(authenticate[:name]).to include("Christopher De Groot")
    end 
  end
end
