require 'rails_helper'

RSpec.feature "User pages", type: :feature do
  subject { page }

  describe "profile page" do
    let(:user) { create(:user) }

    before do
      visit user_path(user)
    end

    it { should have_text(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_text('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
end
