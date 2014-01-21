require 'spec_helper'

feature "Editing projects" do
  before do
    project = FactoryGirl.create(:project, name: "TextMate 2")

    visit '/'
    click_link 'TextMate 2'
    click_link 'Edit Project'
  end

  scenario "Updating a project" do
    fill_in "Name", with: "TextMate 3 Beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid name" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end

end