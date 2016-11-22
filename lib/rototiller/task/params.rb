require 'rototiller/task/hash_handling'

module Rototiller
  module Task

    # The base class for creating rototiller task params (commands, envs, etc)
    # @since v0.1.0
    # @attr [String] name The name of the param
    # @attr [String] message The param message (for debugging/informing/logging)
    class RototillerParam
      include HashHandling

      attr_accessor :name
      attr_accessor :message

      # we must always have a message that can be aggregated via the parent params
      # @return [String] <empty string>
      def message
        return ''
      end
    end

  end
end
