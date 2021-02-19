# frozen_string_literal: true

class TargetingService
  module Targeter
    class MaleTargeter
      TargeterResolver.add(self)

      def call
        User.where(gender: :male)
      end

      def self.supports?(context)
        context.male?
      end
    end
  end
end
