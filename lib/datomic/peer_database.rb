# -*- coding: utf-8 -*-

module Datomic
  class PeerDatabase
    @@databases = {}

    # ----------------------------------------------------------------------
    # create a new database.
    # ----------------------------------------------------------------------
    def self.create(uri)
      if @@databases.has_key?(uri)
        return Datomic::TxResult.new(:status => 501, :message => "database #{uri} already exits")
      else
        @@databases[uri] = {}
        return Datomic::TxResult.new(:status => 0, :message => "successfully created a new database of #{uri}")
      end
    end

    # ----------------------------------------------------------------------
    # destroy the database.
    # ----------------------------------------------------------------------
    def self.destroy(uri)
      begin
        raise "no database found for #{uri}" unless @@databases.has_key?(uri)

        @@databases.delete(uri)

        return Datomic::TxResult.new(:status => 0, :message => "successfully destroyed the database of #{uri}")
      rescue => e
        return Datomic::TxResult.new(:status => 500, :message => e.message)
      end
    end

    # ----------------------------------------------------------------------
    # connect to the databae.
    # ----------------------------------------------------------------------
    def self.connect(uri)

      if @@databases.has_key?(uri)
        return @@databases[uri]
      else
        return nil
      end
    end

    # ----------------------------------------------------------------------
    # get entitiy
    # ----------------------------------------------------------------------
    def entity(id)
      return Entity.get(id)
    end


    private


    def self.parse_uri(uri)
      uri = URI.parse(uri.gsub(/^datomic:/, ''))

      return {
        :scheme   => uri.scheme, # mem or disk,
        :host     => (uri.host || '127.0.0.1'),
        :port     => (uri.port || '9999'),
        :database => uri.path
      }
    end
  end
end
