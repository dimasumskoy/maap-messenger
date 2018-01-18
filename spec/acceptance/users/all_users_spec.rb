require 'rails_helper'

feature 'list of users', %q{
  In order to start conversation
  As a user
  I want to be able to see the list of all users
} do
  given!(:users) { create_list(:user, 5) }

  scenario 'User can see the list of other users' do
    visit users_path

    users.each do |user|
      expect(page).to have_content user.name
      expect(page).to have_content user.username
    end
  end
end