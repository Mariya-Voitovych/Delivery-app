describe 'the login process', type: :feature do
  
  let!(:delivery_manager) { create(:delivery_manager, enabled: true) }
  let!(:delivery_manager_not_active) { create(:delivery_manager) }

  it 'logs active delivery manager in' do
    visit '/admin/login'
    within('#login') do
      fill_in 'Email', with: delivery_manager.email
      fill_in 'Password', with: delivery_manager.password
    end
    click_button 'Login'
    expect(page).to have_content 'dashboard'
  end

  it 'logs not active delivery manager in' do
    visit '/admin/login'
    within('#login') do
      fill_in 'Email', with: delivery_manager_not_active.email
      fill_in 'Password', with: delivery_manager_not_active.password
    end
    click_button 'Login'
    expect(page).to have_content 'Home'
  end
end
