require 'pipey/core'

module Pipey
  class Line
    include Core

    def self.call(initial, **opts)
      new.call!(initial, **opts)
    end

    def call!(initial, **opts)
      self.class.steps_for(**opts).reduce(initial) do |value, name|
        result = send(name, value, **opts)

        if self.class.valid_pipe_result?(result)
          result
        else
          value
        end
      end
    end
  end
end
