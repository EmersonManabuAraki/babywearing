# frozen_string_literal: true

class MembershipType < ApplicationRecord
  belongs_to :user

  validates :name, :short_name, :fee_cents, :duration_days, :number_of_items, :description, presence: true
end
