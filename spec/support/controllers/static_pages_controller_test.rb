require 'rails_helper'


RSpec.describe StaticPagesController, type: :controller do
  describe 'Get home' do
    get :home
    expect(response).to have_http_status(:ok)
  end
end