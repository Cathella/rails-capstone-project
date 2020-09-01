require 'spec_helper'

RSpec.describe 'Transaction Views', type: :feature do
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

  scenario 'visit my transactions' do
    find('a', text: 'My Transactions').click
    expect(page).to have_content('Transactions')
  end

  scenario 'visit non-grouped transactions' do
    find('a', text: 'My External Transactions').click
    expect(page).to have_content('Non grouped Transactions')
  end

  scenario 'visit groups' do
    find('a', text: 'Transaction Groups').click
    expect(page).to have_content('Groups')
  end

  scenario 'visit other members transactions' do
    find('a', text: 'All member Transactions').click
    expect(page).to have_content('Members Expenditures')
  end

  scenario 'create new grouped transaction' do
    find('a', text: 'My Transactions').click
    find(:xpath, "//a[@href='/transactions/new']").click
    fill_in 'Name', with: 'lunch in town'
    fill_in 'Amount', with: '13'
    find('#transaction_group_id').find(:xpath, 'option[2]').select_option
    click_button('Create Transaction')
    expect(page).to have_content('Transactions')
  end

  scenario 'create new non-grouped transaction' do
    find('a', text: 'My External Transactions').click
    find(:xpath, "//a[@href='/transactions/new']").click
    fill_in 'Name', with: 'Have lunch with sunil'
    fill_in 'Amount', with: '20'
    click_button('Create Transaction')
    expect(page).to have_content('Non grouped')
  end
end
