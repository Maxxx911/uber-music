require 'rails_helper'

RSpec.describe Organization do 
  describe 'valid attribute' do
    it 'create object' do
      organization = Organization.new(name: 'Name', description: 'Description')
      expect(organization).to be_valid
    end
  end

  describe 'invalid attribute' do
    it 'create object' do
      organization = Organization.new()
      expect(organization).to_not be_valid
    end
    it 'update object' do
      organization = create(:organization)
      organization.update(name: 'Updated name')
      expect(organization).to_not be_valid
    end
  end
end
