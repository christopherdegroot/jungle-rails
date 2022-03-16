require 'rails_helper'
require 'support/images'

RSpec.feature "Visitor can add a product to their cart", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      name: "Chris De Groot",
      password: "123",
      password_confirmation: "123",
      email: "cdg@gmail.com"
    )
  end

  scenario "They can login" do
    # ACT
    visit root_path
    click_on 'Login', match: :first
    fill_in 'email', with: 'cdg@gmail.com'
    fill_in 'password', with: '123'
    click_on 'Submit'

    
    # VERIFY
    expect(page).to have_content('Signed in as Chris De Groot')

    # DEBUG
    save_screenshot
  end
end
