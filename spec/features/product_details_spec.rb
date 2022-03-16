require 'rails_helper'
require 'support/images'

RSpec.feature "Visitor can click and see an individual product from home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click on a product" do
    # ACT
    visit root_path
    click_on 'Details', match: :first

    
    # VERIFY
    expect(page).to have_css 'section.products-show', count: 1
    
    # DEBUG
    save_screenshot
  end
end
