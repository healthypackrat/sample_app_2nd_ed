require 'rails_helper'

RSpec.feature "Static pages", type: :feature do
  subject { page }

  shared_examples "all static pages" do
    it { should have_text(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    before { visit root_path }

    it_behaves_like 'all static pages'
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    before { visit help_path }

    it_behaves_like 'all static pages'
  end

  describe "About page" do
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    before { visit about_path }

    it_behaves_like 'all static pages'
  end

  describe "Contact page" do
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    before { visit contact_path }

    it_behaves_like 'all static pages'
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link 'About'
    expect(page).to have_title(full_title('About Us'))
    click_link 'Help'
    expect(page).to have_title(full_title('Help'))
    click_link 'Contact'
    expect(page).to have_title(full_title('Contact'))
    click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_title(full_title(''))
    click_link 'Sample App'
    expect(page).to have_title(full_title(''))
  end
end
