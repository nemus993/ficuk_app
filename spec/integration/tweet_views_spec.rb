require 'rails_helper'
include Warden::Test::Helpers

describe 'the Tweets views', type: :feature do
  before (:all) do
    @user = User.create( first_name: "John", last_name: "Doe", email: "123@gmail.com", birthday: "1960-08-09", password: "1234example", password_confirmation: "1234example")
  end
  before (:each) do
    login_as @user, :scope => :user
    @user.tweets.create(content: "Example tweet!")
    @user.tweets.create(content: "Second tweet!")
    visit tweets_path
  end

  context 'for managing users tweets' do
    it 'shows user information' do
      expect(page).to have_content(@user.first_name)
      expect(page).to have_content(@user.last_name)
    end
    it 'shows all user tweets' do
        expect(page).to have_content('Example tweet!')
        expect(page).to have_content('Second tweet!')
    end
    it 'has form for creating tweets' do
      page.has_field?("What's on your tweet?", :type => 'textarea')
    end
    it 'creates new tweet' do
      page.fill_in('content', :with => "Tweeting is fun!")
      page.click_button('Tweet')
      expect(page).to have_content('Tweeting is fun!')
    end
  end
end
