require 'spec_helper'

RSpec.describe 'Sign in Views', type: :feature do
  before(:each) do
    u1 = User.new({ email: 'anna@gmail.com', username: 'anna', password: 'password', password_confirmation: 'password' })
    u1.save
  end

  scenario 'sign in redirect to profile page' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'anna@gmail.com'
    fill_in 'Password', with: 'password'
    click_button('Log in')
    expect(page).to have_content('You are welcome, anna!')
  end

  scenario 'log out redirect to root' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'anna@gmail.com'
    fill_in 'Password', with: 'password'
    click_button('Log in')
    find('a', text: 'Log Out').click
    expect(page).to have_content('Transactions Traker!')
  end
end
