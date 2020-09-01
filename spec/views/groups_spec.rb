require 'spec_helper'

RSpec.describe 'Groups Views', type: :feature do
  before(:each) do
    u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
    u1.save

    g1 = Group.new(name: 'Food', icon: 'fa-utensils', user_id: 1)
    g1.save

    visit '/users/sign_in'
    fill_in 'Email', with: 'anna@gmail.com'
    fill_in 'Password', with: 'password'
    click_button('Log in')
    expect(page).to have_content('welcome')
  end

  scenario 'Add new group' do
    find('a', text: 'Groups').click
    find(:xpath, "//a[@href='/groups/new']").click
    fill_in 'Name', with: 'Transport'
    choose(option: 'fa-car')
    click_button('Create Group')
    expect(page).to have_content('Groups')
  end
end
