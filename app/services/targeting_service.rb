# frozen_string_literal: true

require 'targeting_service/targeter'
require 'targeting_service/targeter_resolver'

class TargetingService
  def initialize(context)
    @context = context
    @targeter = TargeterResolver.resolve(context).new
  end

  def call
    @targeter.call
  end
end
