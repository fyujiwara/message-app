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
class Target < ApplicationRecord
  enum type: { male: 0, female: 1, teenager: 2 }
end
