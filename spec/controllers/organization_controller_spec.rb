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

    describe 'user organization owner' do
      it 'return status 200' do
        user = create(:user)
        sign_in(user)
        organization = create(:organization)
        get :edit, params: {id: organization.id}
        expect(response).to have_http_status(200)
      end

      it 'render edit page' do
        user = create(:user)
        sign_in(user)
        organization = create(:organization)
        organization.users << user
        get :edit, params: {id: organization.id}
        expect(response).to render_template('edit')
      end
    end

    describe 'PATCH update' do
      it 'update name and description' do
        user = create(:user)
        sign_in(user)
        organization = create(:organization)
        organization.users << user
        patch :update, params: {id: organization.id,
                                organization: { name: 'New name', description: 'New description'}}
        expect(Organization.find(organization.id).name).to eql('New name')
        expect(Organization.find(organization.id).description).to eql('New description')
      end

      it 'add image withoud delete image' do
        user = create(:user)
        sign_in(user)
        organization = create(:organization)
        organization.users << user
        patch :update, params: {id: organization.id,
                                organization: { image: [fixture_file_upload("public/seeds_image/grups/01.jpg", 'image/jpeg')],
                                                description: 'Description',
                                                name: 'Name',
                                                id: organization.id}}
        expect(Organization.find(organization.id).images.count).to_not eql(0)
      end

      it 'delete image and set default image' do
        user = create(:user)
        sign_in(user)
        organization = create(:organization)
        organization.users << user
        patch :update, params: {id: organization.id,
                                organization: { image: [fixture_file_upload("public/seeds_image/grups/01.jpg", 'image/jpeg')],
                                                description: 'Description',
                                                name: 'Name',
                                                id: organization.id}}
        patch :update, params: {id: organization.id,
                                organization: { delete_img: ",#{Organization.find(organization.id).images.first.id}",
                                                description: 'Description',
                                                name: 'Name',
                                                id: organization.id}}
        expect(Organization.find(organization.id).images.first.url.url).to eql('/uploads/images/default_organization.jpg')
      end
    end
  end
  
  describe 'PATCH leave' do
    it 'leave current user' do
      user = create(:user)
      sign_in(user)
      organization = create(:organization)
      organization.users << user
      patch :leave, params: {id: organization.id}
      expect(Organization.find(organization.id).users.count).to eql(0)
    end
  end
end
