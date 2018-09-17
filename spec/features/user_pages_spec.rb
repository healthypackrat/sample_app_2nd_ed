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

  describe "signup" do
    before { visit signup_path }

    let(:submit) { 'Create my account' }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submition" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_text('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
