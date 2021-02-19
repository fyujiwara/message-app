# frozen_string_literal: true

class TargetingService
  module Targeter
    class TeenagerTargeter < TargeterBase
      def call
        User.where(birthday: Time.current.ago(20.years).since(1.days)..Time.current.ago(10.years))
      end

      def self.supports?(context)
        context.teenager?
      end
    end
  end
end
