require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do
  
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

  scenario "Go to detail page of a product" do
    # ACT
    visit root_path

    @all_details_buttons = page.all('a', text: 'Details »')
    @all_details_buttons[0].click
    @all_details_buttons[0].click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content('Name')
    expect(page).to have_content('Description')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('»')    
  end

end
