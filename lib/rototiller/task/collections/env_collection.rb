require 'rototiller/task/collections/param_collection'
require 'rototiller/task/params/env_var'

module Rototiller
  module Task

    class EnvCollection < ParamCollection

      # @return [Type] allowed class for this collection (EnvVar)
      def allowed_class
        EnvVar
      end

      # remove the nils and return the last known value
      # @return [String] last set environment variable or default
      def last
        if self.any?
          last_known_env_var = self.map{|x| x.value}.compact.last
          # ruby converts nil to "", so guard against single non-set env vars here
          last_known_env_var.to_s if last_known_env_var
        end
      end

    end

  end
end
