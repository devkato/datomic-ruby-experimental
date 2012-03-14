# -*- coding: utf-8 -*-

module Datomic
  class Peer

    # ----------------------------------------------------------------------
    # create a new database.
    # ----------------------------------------------------------------------
    def self.create(uri)
      return PeerDatabase.create(uri)
    end

    # ----------------------------------------------------------------------
    # destroy the database.
    # ----------------------------------------------------------------------
    def self.destory(uri)
      return PeerDatabase.destroy(uri)
    end

    # ----------------------------------------------------------------------
    # connect to peer cache
    # ----------------------------------------------------------------------
    def self.connect(uri)
      return PeerConnection.new(uri)
    end

    # ----------------------------------------------------------------------
    # execute query
    # ----------------------------------------------------------------------
    def self.q(query, peer_database)
      result_ids = []

      # @TODO parse query

      # @TODO search ids with index and cache

      return result_ids
    end


    private

    
    def parse_query(query)
      
    end
  end
end
