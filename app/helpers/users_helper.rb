# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    user.name.initials
  end

  def user_roles_select
    User.roles.keys.map { |role| [role.humanize, role] }
  end

  def membership_type_select
    MembershipType.all.distinct.pluck(:name)
  end
end
