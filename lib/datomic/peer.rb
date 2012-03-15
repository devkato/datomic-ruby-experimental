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

    def self.tempid(k)
      return Digest::SHA1.hexdigest("#{k}.#{Time.now.to_f}")
    end

    # ----------------------------------------------------------------------
    # execute query
    # query = {
    #   :find => [
    #     (entitiy_name),
    #     ...
    #   ],
    #   :in => [
    #     (entity_name),
    #   ],
    #   :where => [
    #     {
    #       :entity => (entity_name), 
    #       :target => [
    #         (target_name),
    #         ...
    #       ],
    #       :alias => (alias_name)
    #     },
    #     ...
    #   ],
    #   :params => [
    #     (parameter),
    #     ...
    #   ]
    # }
    # ----------------------------------------------------------------------
    def self.q(query, peer_database)
      result_ids = []

      # @TODO parse query

      # @TODO search ids with index and cache

      return result_ids
    end

    def self.q_print(query, database)
      res = parse_query(query)

      $logger.debug res

      return res
    end


    private

    
    # ----------------------------------------------------------------------
    # parse query
    # ----------------------------------------------------------------------
    def self.parse_query(query)
      raw_query = [%![!] 

      # :find
      if !query[:find].nil? && query[:find].size > 0
        raw_query << ":find"
        query[:find].each {|k| raw_query << %!?#{k.to_sym}! }
      end

      # :in
      unless query[:in].nil?
        raw_query << ":in $ [["
        query[:in].each {|pt| raw_query << pt}
        raw_query << "]]"
      end

      # :where
      unless query[:where].nil?
        raw_query << ":where"
        query[:where].each do |cnd|
          raw_query << "["
          raw_query << %!?#{cnd[:entity]}!
          raw_query << cnd[:attribute]

          unless cnd[:value].nil?
            if cnd[:value].is_a?(Symbol)
              raw_query << %!?#{cnd[:value]}!
            elsif 
              raw_query << cnd[:value]
            end
          end

          raw_query << "]"
        end
      end

      raw_query << ']'

      return raw_query.join(' ')
    end
  end
end
