require 'rails_helper'

RSpec.feature "MicropostPages", type: :feature do
  subject { page }

  let(:user) { create(:user) }

  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button 'Post' }

        it { should have_text('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: 'Lorem ipsum' }

      it "should create a micropost" do
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link 'delete' }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost count" do
    before { visit root_path }

    specify { expect(page).to have_text(/\b0 microposts\b/) }
    specify { expect(page).not_to have_text(/\b0 micropost\b/) }

    describe "post a micropost" do
      before do
        fill_in 'micropost_content', with: 'foo'
        click_button 'Post'
      end

      specify { expect(page).to have_text(/\b1 micropost\b/) }
      specify { expect(page).not_to have_text(/\b1 microposts\b/) }

      describe "post another micropost" do
        before do
          fill_in 'micropost_content', with: 'bar'
          click_button 'Post'
        end

        specify { expect(page).to have_text(/\b2 microposts\b/) }
        specify { expect(page).not_to have_text(/\b2 micropost\b/) }
      end
    end
  end

  describe "pagination" do
    before do
      30.times do |i|
        user.microposts.create!(content: "micropost #{i}")
      end

      visit user_path(user)
    end

    it { should have_selector('ul.pagination') }

    it "should list each micropost" do
      user.microposts.page(1).each do |micropost|
        expect(page).to have_selector('span.content', text: micropost.content)
      end
    end
  end
end
