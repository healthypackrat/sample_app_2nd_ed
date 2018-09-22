require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "deleting users" do
    let!(:admin) { create(:admin) }

    before { sign_in admin, no_capybara: true }

    describe "admin user cannot delete himself" do
      specify { expect { delete user_path(admin) }.not_to change(User, :count) }
    end

    describe "admin user can delete other admin user" do
      let!(:other_admin) { create(:admin) }

      specify { expect { delete user_path(other_admin) }.to change(User, :count).by(-1) }
    end
  end
end
