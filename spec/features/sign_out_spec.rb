require 'spec_helper'

feature "Signing out" do
  scenario 'Signing out via link' do
    user = FactoryGirl.create(:user)

    sign_in_as!(user)
    
    visit '/'
    click_link 'Sign out'

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end