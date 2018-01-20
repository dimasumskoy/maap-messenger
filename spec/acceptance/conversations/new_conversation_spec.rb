<<<<<<< HEAD
require 'acceptance/acceptance_helper'
=======
require 'rails_helper'
>>>>>>> d6377022b790d898238b269cc13fcd3351503ce3

feature 'new conversation', %q{
  In order to start messaging with other user
  As a user
  I want to be able to start a conversation
} do
<<<<<<< HEAD
  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:conversation) { create(:conversation, sender: user2, recipient: user1) }
  given!(:message) { create(:message, user: user2, conversation: conversation) }

  scenario 'authenticated user starts a conversation' do
    sign_in(user1)

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path '/'

    click_on user2.name

    expect(page).to have_content message.body
  end

  scenario 'non-authenticated user starts a conversation' do
    visit conversations_path

    expect(page).to_not have_content user1.name
    expect(page).to_not have_content user2.name

    expect(page).to have_field 'Email'
    expect(page).to have_field 'Password'
=======
  given!(:user) { create(:user) }

  scenario 'User can start a conversation' do
    visit conversations_path
    click_on user.name

    expect(page).to have_content user.name
    expect(page).to have_content user.username
    expect(page).to have_field('MessageBody')
>>>>>>> d6377022b790d898238b269cc13fcd3351503ce3
  end
end