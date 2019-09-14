class OrganizationInviteUsers
  def self.invite_users(organization_id, users_id)
    organization = Organization.find(organization_id)
    if users_id
      users_id.split(',').each do |id|
        UserMailer.with(user: User.find(id), organization: organization).invite_email.deliver_later
      end
    end
  end
end
