# frozen_string_literal: true

class TargetingService
  module Targeter
    class TargeterBase
      def self.inherited(base)
        super
        TargeterResolver.add(base)
      end

      def call
        raise NotImplementedError
      end

      def self.supports?(*)
        raise NotImplementedError
      end
    end
  end
end
