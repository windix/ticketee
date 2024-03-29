require 'spec_helper'

feature "Deleting Project" do
  scenario "Deleting a project" do
    project = FactoryGirl.create(:project, name: "TextMate 2")

    visit '/'
    click_link 'TextMate 2'
    click_link 'Delete Project'

    expect(page).to have_content("Project has been destroyed.")

    visit '/'

    expect(page).to have_no_content("TextMate 2")    
  end

end