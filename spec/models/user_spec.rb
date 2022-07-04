require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "defines validation specs" do
      user = User.new(
        name: 'John',
        email: 'john@john.com',
        password: '123456789',
        password_confirmation: '123456789'
      )
      expect(user).to be_valid
    end

    it "password do not match" do 
      user = User.new(
        name: 'John',
        email: 'john@john.com',
        password: '123456789',
        password_confirmation: '12345677891'
      )
      expect(user).not_to be_valid
    end

    it "emails must be unique" do
      user = User.new
        user.name = 'John'
        user.email = 'test@test.com'
        user.password = '123456789'
        user.password_confirmation = '123456789'
      user.save

      userTwo = User.new
        userTwo.name = 'John'
        userTwo.email = 'test@test.com'
        userTwo.password = '123456789'
        userTwo.password_confirmation = '123456789'
      userTwo.save

      expect(userTwo.id).not_to be_present
    end

    it "name is required" do 
      user = User.new(
        name: nil,
        email: 'john@john.com',
        password: '123456',
        password_confirmation: '123456789'
      )
      expect(user).not_to be_valid
    end

    it "email is required" do 
      user = User.new(
        name: "john",
        email: nil,
        password: '123456',
        password_confirmation: '123456789'
      )
      expect(user).not_to be_valid
    end

    it "pasword has to be at least 8 characters" do
      user = User.new(
        name: "john",
        email: nil,
        password: '123456',
        password_confirmation: '123456'
      )
      expect(user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    
    it "should authenticate with credentials if email and password are valid" do
      user = User.new(
        name: 'Marc',
        email: 'marc@example.com',
        password: '123456789abc', 
        password_confirmation: '123456789abc'
      )
      user.save
      
      authenticatedUser = User.authenticate_with_credentials("marc@example.com", "123456789abc")

      expect(authenticatedUser).not_to be(nil)
    end

    it "should pass with upper and lower case email" do
       user = User.new(
        name: 'Liam',
        email: 'liam@example.com',
        password: '123456789abc', 
        password_confirmation: '123456789abc'
      )
      user.save

      authenticatedUser = User.authenticate_with_credentials("lIAm@examPle.com", "123456789abc")

      expect(authenticatedUser).not_to be(nil)
    end

    it "should pass with spaces in the email" do
       user = User.new(
        name: 'Dirk',
        email: 'dirk@example.com',
        password: '123456789abc', 
        password_confirmation: '123456789abc'
      )
      user.save

      authenticatedUser = User.authenticate_with_credentials("  dirk@example.com  ", "123456789abc")

      expect(authenticatedUser).not_to be(nil)
    end
  end
end
