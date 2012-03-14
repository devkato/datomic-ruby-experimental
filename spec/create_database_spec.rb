# -*- coding: utf-8 -*-

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

include Datomic

describe Peer, "on handling database" do
  
  before do
    #peer_uri = "datomic:mem://localhost:9999/no-database"
  end

  it "should be error on accessing non-existing database" do
    conn = Peer.connect("datomic:mem://localhost:9999/no-database")
    conn.connected?.should == false
  end

  it "should create a new database successfully" do
    res = Peer.create("datomic:mem://localhost:9999/hellodb")
    res.status.should == 0
  end

  it "should raise error on creating duplicated named database" do
    Peer.create("datomic:mem://localhost:9999/duplicated-database")
    res = Peer.create("datomic:mem://localhost:9999/duplicated-database")
    res.status.should == 501
  end

  it "should destroy the database successfully" do
    res = Peer.destory("datomic:mem://localhost:9999/hellodb")
    res.status.should == 0
  end

  it "should raise error if you try to destory a non-existing database" do
    res = Peer.destory("datomic:mem://localhost:9999/non-existing-database")
    res.status.should == 500
  end
end


