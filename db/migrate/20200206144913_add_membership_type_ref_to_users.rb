class AddMembershipTypeRefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :membership_type, foreign_key: true
  end
end
