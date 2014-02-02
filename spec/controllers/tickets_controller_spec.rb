require 'spec_helper'

describe TicketsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in_as!(user)

      get :show, :project_id => project.id, :id => ticket.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql('The project you were looking for could not be found.')
    end
  end

  context "with permission to view the project" do
    before do
      sign_in_as!(user)
      define_permission!(user, :view, project)
      # define_permission!(user, :create_tickets, project)
    end

    def cannot_create_tickets!
      response.should redirect_to(project)
      message = "You cannot create tickets on this project."
      flash[:alert].should eql(message)
    end

    it "cannot begin to create a ticket" do
      get :new, project_id: project.id
      cannot_create_tickets!
    end

    it "cannot create a ticket without permission" do
      post :create, { project_id: project.id, ticket: { title: 'aaa', description: 'bbb' } }
      cannot_create_tickets!
    end

    def cannot_update_tickets!
      response.should redirect_to(project)
      message = "You cannot edit tickets on this project."
      flash[:alert].should eql(message)
    end

    it "cannot edit a ticket without permission" do
      get :edit, { project_id: project.id, id: ticket.id }
      cannot_update_tickets!
    end

    it "cannot update a ticket without permission" do
      put :update, { project_id: project.id, id: ticket.id, ticket: { title: 'aaa', description: 'bbb' } }
      cannot_update_tickets!
    end
  end

end
