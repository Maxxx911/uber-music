class OrganizationDeleteImagesService
  def self.delete_images(images_id, organization_id)
    organization = Organization.find(organization_id)
    if images_id
      images_id.split(',').each do |image_id|
        images = organization.images.where(id: image_id.to_i)
        images.first.destroy unless images.empty?
      end
    end
    install_default_image(organization_id) if organization.images.empty?
  end

  def self.install_default_image(organization_id)
    ImageService.add_image(organization_id, 'Organization',
                           File.open('app/assets/images/default_organization.jpg'))
  end

  private_class_method :install_default_image
end
