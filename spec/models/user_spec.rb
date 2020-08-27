require 'rails_helper'

RSpec.describe User, type: :model do
  context 'test creation valid user' do
    it 'return true if is created a valid user' do
      u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
      u1.save
      expect(u1.valid?).to eq(true)
    end

    it 'return false if is created invalid user with duplicate username' do
      u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
      u1.save
      u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
      expect(u1.valid?).to eq(false)
    end

    it 'create invalid user with duplicate email' do
      u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
      u1.save
      u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
      expect(u1.valid?).to eq(false)
    end
  end
end
