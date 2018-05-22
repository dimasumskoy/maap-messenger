require 'acceptance/acceptance_helper'

feature 'list of users', %q{
  In order to start conversation
  As a user
  I want to be able to see the list of all users
} do

  given(:user) { create(:user) }
  given!(:users) { create_list(:user, 5) }

  pending 'User can see the list of other users' do
    sign_in(user)

    visit users_path

    users.each do |user|
      expect(page).to have_content user.name
    end
  end
end