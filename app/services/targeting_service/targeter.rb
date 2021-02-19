# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), 'targeter', '*.rb')]
  .each { |resource| require resource }

class TargetingService
  module Targeter
  end
end
