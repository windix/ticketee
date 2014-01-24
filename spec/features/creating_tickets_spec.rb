require 'spec_helper'

feature "Creating Tickets" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    visit '/'
    click_link project.name
    click_link "New Ticket"
    expect(page).to have_content("You need to sign in or sign up before continuing.")

    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")

    click_link project.name
    click_link "New Ticket"
  end

  scenario "Creating a ticket" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within "#ticket #author" do
      expect(page).to have_content("Created by #{user.name}")
    end
  end
  
  scenario "Creating a ticket without valid attributes fails" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 chars" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "Short!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end

end