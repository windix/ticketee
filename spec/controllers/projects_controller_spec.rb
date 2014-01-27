require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(user)
  end

  it "displays an error for a missing project" do
    get :show, id: "not-here"

    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

  context "standard users" do
   { new: :get, 
      create: :post,
      edit: :get,
      update: :patch,
      destroy: :delete }.each do |action, method|

      it "cannot access the #{action} action" do
        # id is for edit, update and destroy
        send(method, action, id: FactoryGirl.create(:project))

        expect(response).to redirect_to("/")
        message = "You must be an admin to do that."
        expect(flash[:alert]).to eql(message)
      end
    end

    it "cannot access the show action without permission" do
      project = FactoryGirl.create(:project)
      get :show, id: project.id

      expect(response).to redirect_to(projects_path)
      message = "The project you were looking for could not be found."
      expect(flash[:alert]).to eql(message)
    end
  end

end
