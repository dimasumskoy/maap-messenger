require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should belong_to :sender }
  it { should belong_to :recipient }
  it { should have_many :messages }

  let!(:users) { create_list(:user, 2) }
  let!(:conversation) { create(:conversation, sender: users.first, recipient: users.last) }

  describe '.between' do
    it 'should return a conversation between two users' do
      expect(Conversation.between(users.first.id, users.last.id).first).to eq conversation
    end
  end

  describe '.find_or_create' do
    context 'conversation exists' do
      it 'returns a conversation' do
        expect(Conversation.find_or_create(users.first.id, users.last.id)).to eq conversation
      end
    end

    context 'conversation not found' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }

      it 'creates new conversation for users' do
        expect(Conversation.find_or_create(user1.id, user2.id)).to eq(user1.conversations.first)
      end
    end
  end
end
