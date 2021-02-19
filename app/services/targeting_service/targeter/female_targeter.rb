# frozen_string_literal: true

class TargetingService
  module Targeter
    class FemaleTargeter
      TargeterResolver.add(self)

      def call
        User.where(gender: :female)
      end

      def self.supports?(context)
        context.female?
      end
    end
  end
end
