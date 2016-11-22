require 'rototiller/task/params/argument'
require 'rototiller/task/collections/switch_collection'

module Rototiller
  module Task

    class ArgumentCollection < SwitchCollection
      # @return [Type] allowed class for this collection (Argument)
      def allowed_class
        Argument
      end
    end

  end
end
