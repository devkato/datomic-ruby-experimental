# -*- coding: utf-8 -*-

module Datomic
  class Datom
    attr_accessor :entity, :attribute, :value, :transaction_time
  end
end
