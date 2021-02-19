# frozen_string_literal: true

class TargetingService
  class TargeterResolver
    class << self
      def resolve(context)
        targeter = targeters.find { |t| t.supports?(context) }
        raise NotImplementedError, "#{context.type} targeting is not supported" if targeter.nil?

        targeter
      end

      def add(context)
        targeters << context
      end

      def targeters
        @targeters ||= Set.new
      end
    end
  end
end
