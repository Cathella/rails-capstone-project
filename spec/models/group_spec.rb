require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
    u1.save
  end

  context 'test group model' do
    it 'return true if group is valid' do
      g1 = Group.new(name: 'Food', icon: 'fa-utensils', user_id: 1)
      g1.save
      expect(g1.valid?).to eq(true)
    end

    it 'return true if group is invalid duplicate name' do
      g1 = Group.new(name: 'Food', icon: 'fa-utensils', user_id: 1)
      g1.save
      g1 = Group.new(name: 'Food', icon: 'fa-utensils', user_id: 1)
      expect(g1.valid?).to eq(false)
    end

    it 'return true if group is missing the name' do
      g1 = Group.new(icon: 'fa-handshake', user_id: 1)
      expect(g1.valid?).to eq(false)
    end
  end
end
