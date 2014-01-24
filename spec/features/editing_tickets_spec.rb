require 'spec_helper'

feature "Editing tickets" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  before do
    visit '/'
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
    expect(page).to have_content("You need to sign in or sign up before continuing.")

    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")

    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
  end
  
  scenario "Updating a ticket" do
    fill_in "Title", with: "Make it really shiny!"
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has been updated."
    
    within("#ticket h2") do
      expect(page).to have_content("Make it really shiny!")
    end
    
    expect(page).to_not have_content ticket.title
  end
  
  scenario "Updating a ticket with invalid information" do
    fill_in "Title", with: ""
    click_button "Update Ticket"
    expect(page).to have_content("Ticket has not been updated.")
  end
end