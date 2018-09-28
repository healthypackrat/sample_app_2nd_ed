require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in user, no_capybara: true }

  describe "creating a relationship with AJAX" do
    it "should increment the Relationship count" do
      expect do
        post relationships_path, xhr: true, params: { relationship: { followed_id: other_user.id } }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      post relationships_path, xhr: true, params: { relationship: { followed_id: other_user.id } }
      expect(response).to have_http_status(200)
    end
  end

  describe "destroying a relationship with AJAX" do
    before { user.follow!(other_user) }

    let(:relationship) { user.relationships.find_by(followed_id: other_user.id) }

    it "should decrement the Relationship count" do
      expect do
        delete relationship_path(relationship), xhr: true, params: { id: relationship.id }
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      delete relationship_path(relationship), xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
