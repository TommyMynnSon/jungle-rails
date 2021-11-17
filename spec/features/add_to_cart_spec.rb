require 'rails_helper'

RSpec.feature "Cart increases by 1 each time Add is clicked on Home page", type: :feature, js: true do

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

  scenario "Click Add to increase cart size" do
    # ACT
    visit root_path

    @all_add_buttons = page.all('button', text: 'Add')
    @all_add_buttons[0].click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content('My Cart (1)')    
  end

end
