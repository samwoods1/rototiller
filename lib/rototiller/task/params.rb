require 'rototiller/task/hash_handling'

module Rototiller
  module Task

    class RototillerParam
      #include BlockHandling
      include HashHandling

      attr_accessor :name
      attr_accessor :message

      def message
        return ''
      end
    end

  end
end
