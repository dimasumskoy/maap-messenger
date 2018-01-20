require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  sign_in_user

  let!(:user) { create(:user) }
  let!(:conversation) { create(:conversation, sender: @user, recipient: user) }

  describe 'POST #create' do
    # it 'sets requested conversation' do
    #   post :create, params: { conversation_id: conversation }
    #   expect(assigns(:converastion)).to eq conversation
    # end

    context 'valid message params' do
      let(:message_params) { post :create, params: { message: attributes_for(:message), conversation_id: conversation, user: @user }, format: :js }

      it 'assigns conversation' do
        message_params
        expect(assigns(:conversation)).to eq conversation
      end

      it 'creates new message' do
        expect { message_params }.to change(Message, :count).by(1)
      end

      it 'increases messages amount for user' do
        expect { message_params }.to change(@user.messages, :count).by(1)
      end
    end
  end
end
