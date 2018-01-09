require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before { get :index }

    it 'fills an array of all users' do
      expect(assigns(:users)).to eq([user])
    end

    it 'renders an index template' do
      expect(response).to render_template :index
    end
  end
end
