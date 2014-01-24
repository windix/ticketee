require 'spec_helper'

describe ProjectsController do
  it "displays an error for a missing project" do
    get :show, id: "not-here"

    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end

  let(:user) { FactoryGirl.create(:user) }

  context "standard users" do
    before do
      sign_in_as!(user)
    end

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

  end

end
