# frozen_string_literal: true

# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  type       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :target do
    type { 1 }
  end
end
