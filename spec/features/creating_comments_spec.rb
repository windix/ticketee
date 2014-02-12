require 'spec_helper'

feature "Creating comments" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  before do
    define_permission!(user, :view, project)
    # define_permission!(user, :creating_comments, project)

    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario "Creating a comment" do
    fill_in "Leave a comment", with: "This is a comment!"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")

    within("#comments") do
      expect(page).to have_content("This is a comment!")
    end
  end

  scenario "Creating an invalid comment" do
    click_button "Create Comment"

    expect(page).to have_content("Comment has not been created.")
    expect(page).to have_content("Content can't be blank")
  end
end