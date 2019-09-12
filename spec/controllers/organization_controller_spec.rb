require 'rails_helper'

RSpec.describe OrganizationsController do 
  describe 'GET index' do
    it 'return status 200' do
      get :index
      expect(response).to have_http_status(200)
    end
    it 'render index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'assigns serializeration @organizations' do
      organization = create(:organization)
      get :index
      expect(assigns(:organizations)).to eq([ActiveModelSerializers::SerializableResource.new(organization).serializable_hash])
    end
  end
end
