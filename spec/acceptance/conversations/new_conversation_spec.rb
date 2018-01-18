require 'rails_helper'

feature 'new conversation', %q{
  In order to start messaging with other user
  As a user
  I want to be able to start a conversation
} do
  given!(:user) { create(:user) }

  scenario 'User can start a conversation' do
    visit conversations_path
    click_on user.name

    expect(page).to have_content user.name
    expect(page).to have_content user.username
    expect(page).to have_field('MessageBody')
  end
end