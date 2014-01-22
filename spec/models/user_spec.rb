require 'spec_helper'

describe User do
  describe "passwords" do
    it "needs a password and confirmation to save" do
      u = User.new(name: "steve")

      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    describe "authentication" do
      let(:user) {
        User.create(name: "steve", password: "hunter2", password_confirmation: "hunter2")
      }

      it "authenticates with a correct password" do
        expect(user.authenticate("hunter2")).to be_true
      end

      it "does not authenticates with an incorrect password" do
        expect(user.authenticate("hunter1")).to_not be_true
      end
    end


  end


end
