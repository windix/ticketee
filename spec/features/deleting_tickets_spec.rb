require 'spec_helper'

feature 'Deleting tickets' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }
  
  before do
    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario "Deleting a ticket" do
    click_link "Delete Ticket"
    expect(page).to have_content("You need to sign in or sign up before continuing.")

    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")

    click_link project.name
    click_link ticket.title
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been destroyed.")
    expect(page.current_url).to eq(project_url(project))
  end
end