# frozen_string_literal: true

module RuboCop
  module Cop
    module Betterment
      class Timeout < Base
        MSG = 'Using Timeout.timeout without a custom exception can prevent rescue blocks from executing'

        def_node_matcher :timeout_call?, <<-PATTERN
          (send (const nil? :Timeout) :timeout _)
        PATTERN

        def on_send(node)
          return unless timeout_call?(node)

          add_offense(node)
        end
        alias on_csend on_send
      end
    end
  end
end
