require 'rototiller/task/collections/param_collection'
require 'rototiller/task/params/command'

module Rototiller
  module Task

    class CommandCollection < ParamCollection
      # @return [Type] allowed class for this collection (Command)
      def allowed_class
        Command
      end
    end

  end
end
