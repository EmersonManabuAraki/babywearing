class AddUserToMembershipTypes < ActiveRecord::Migration[5.2]
  def change
    add_reference(:membership_types, :user)
  end
end
