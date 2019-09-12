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

  describe 'GET edit' do
    describe 'user not autoriazation' do 
      it 'return status 302' do
        organization = create(:organization)
        get :edit, params: {id: organization.id}
        expect(response).to have_http_status(302)
      end

      it 'not render edit page' do
        organization = create(:organization)
        get :edit, params: {id: organization.id}
        expect(response).to_not render_template('edit')
      end
    end
    describe 'user not owner' do
      it 'not render edit page' do
        user = create(:user)
        sign_in user
        organization = create(:organization)
        get :edit, params: {id: organization.id}
        expect(response).to_not render_template('edit')
      end
    end
  end
end
