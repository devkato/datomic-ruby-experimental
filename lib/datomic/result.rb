# -*- coding: utf-8 -*-

module Datomic
  class TxResult

    attr_accessor :status
    attr_accessor :message

    def initialize(obj)
      self.status = obj[:status]
      self.message = obj[:message]
    end
  end
end
