require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:each) do
    u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
    u1.save
    g1 = Group.new(name: 'Food', icon: 'fa-utensils', user_id: 1)
    g1.save
  end

  context 'test transaction model' do
    it 'return true if created transaction is valid' do
      e1 = Transaction.new(name: 'lunch in town', amount: 13, user_id: 1, group_id: 2)
      e1.save
      expect(e1.valid?).to eq(true)
    end

    it 'return true if created transaction is valid without group' do
      e1 = Transaction.new(name: 'Have lunch with sunil', amount: 20, user_id: 1)
      e1.save
      expect(e1.valid?).to eq(true)
    end

    it 'return false if created transaction is invalid missing name' do
      e1 = Transaction.new(amount: 13, user_id: 1, group_id: 2)
      e1.save
      expect(e1.valid?).to eq(false)
    end

    it 'return false if created transaction is invalid missing amount' do
      e1 = Transaction.new(name: 'lunch in town', user_id: 1, group_id: 2)
      e1.save
      expect(e1.valid?).to eq(false)
    end
  end
end
