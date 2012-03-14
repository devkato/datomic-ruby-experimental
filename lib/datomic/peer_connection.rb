# -*- coding: utf-8 -*-

module Datomic
  class PeerConnection

    # ----------------------------------------------------------------------
    # Initialization.
    # connect to the databae.
    # ----------------------------------------------------------------------
    def initialize(uri)
      @uri = uri
      @database = Datomic::PeerDatabase.connect(uri)
    end

    def connected?
      return !@database.nil?
    end

    def reconnect
      @database = Datomic::PeerDatabase.connect(uri)
    end

    # ----------------------------------------------------------------------
    # execute transactional operation
    # ----------------------------------------------------------------------
    def transact(data_tx)
      
    end

    # ----------------------------------------------------------------------
    # return database
    # ----------------------------------------------------------------------
    def db
      return @database
    end
  end
end
