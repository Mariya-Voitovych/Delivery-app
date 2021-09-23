describe 'the login process', type: :feature do
  before :each do
    DeliveryManager.create(email: 'user@example.com', password: 'password', enabled: true)
  end

  it 'logs active delivery manager in' do
    visit '/admin/login'
    within('#login') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Login'
    expect(page).to have_content 'dashboard'
  end

  before :each do
    DeliveryManager.create(email: 'user_wrong@example.com', password: 'password', enabled: false)
  end

  it 'logs not active delivery manager in' do
    visit '/admin/login'
    within('#login') do
      fill_in 'Email', with: 'user_wrong@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Login'
    expect(page).to have_content 'Home'
  end
end
