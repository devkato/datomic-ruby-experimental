# -*- coding: utf-8 -*-

require 'logger'
require 'yaml'
require 'digest/sha1'

module Datomic
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::DEBUG
end

require './lib/datomic/datom.rb'
require './lib/datomic/entity.rb'
require './lib/datomic/index.rb'
require './lib/datomic/result.rb'
require './lib/datomic/peer.rb'
require './lib/datomic/peer_cache.rb'
require './lib/datomic/peer_connection.rb'
require './lib/datomic/peer_database.rb'
require './lib/datomic/storage_service.rb'
require './lib/datomic/transactor.rb'
require './lib/datomic/transactor_connection.rb'
