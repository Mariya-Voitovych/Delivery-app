require 'rails_helper'

describe 'couriers actions', type: :views do
  
  it 'edit courier' do
    visit '/couriers/:id/edit'
    within('#edit_courier') do
    attach_file "Driver license",'/home/mariya/Documents/appname/app/assets/images/foto_CV.jpg'
    end
    click_button 'Add driver license'
    expect(page).to(have_content('foto_CV.jpg'))
  end
end
