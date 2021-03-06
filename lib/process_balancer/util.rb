# frozen_string_literal: true

require 'English'

module ProcessBalancer
  module Util # :nodoc:
    def logger
      ProcessBalancer.logger
    end

    def hostname
      ProcessBalancer.hostname
    end

    def identity
      ProcessBalancer.identity
    end

    def redis(&block)
      ProcessBalancer.redis(&block)
    end

    def start_thread(name, &block)
      Thread.new do
        Thread.current.name = name
        watchdog(&block)
      end
    end

    def watchdog
      yield
    rescue Exception => e # rubocop: disable Lint/RescueException
      logger.error("#{Thread.current.name} :: #{e.message}")
      raise e
    end
  end
end
