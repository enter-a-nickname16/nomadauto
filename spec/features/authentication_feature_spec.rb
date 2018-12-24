require 'spec_helper'

describe 'user authentication' do
  it 'allows signin with valid credentials' do
    user = create(:user)
    sign_user_in(user)

    except(page).to have_content('Sign in Successfully')
  end

  it 'does not allow signin with valid credentials' do
    user = create(:user)
    sign_user_in(user)  

    except(page).to have_content('Invalid email or password')
  end

  it 'allows user to Sign out' do
    user = create(:user)
    sign_user_in(user)   

    visit root_path
    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully')
  end
end

def sign_user_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end