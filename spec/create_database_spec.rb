# -*- coding: utf-8 -*-

require './lib/datomic/datomic.rb'

include Datomic

describe Peer, "on handling database" do
  
  before do
    #peer_uri = "datomic:mem://localhost:9999/no-database"
  end

  # ----------------------------------------------------------------------
  # create databases
  # ----------------------------------------------------------------------
  it "should create a new database successfully" do
    res = Peer.create("datomic:mem://localhost:9999/hellodb")
    res.status.should == 0
  end

  it "should raise error on creating duplicated named database" do
    Peer.create("datomic:mem://localhost:9999/duplicated-database")
    res = Peer.create("datomic:mem://localhost:9999/duplicated-database")
    res.status.should == 501
  end

  # ----------------------------------------------------------------------
  # destroy databases
  # ----------------------------------------------------------------------
  it "should destroy the database successfully" do
    res = Peer.destory("datomic:mem://localhost:9999/hellodb")
    res.status.should == 0
  end

  it "should raise error if you try to destory a non-existing database" do
    res = Peer.destory("datomic:mem://localhost:9999/non-existing-database")
    res.status.should == 500
  end

  # ----------------------------------------------------------------------
  # connect to databases
  # ----------------------------------------------------------------------
  it "should be error on accessing non-existing database" do
    conn = Peer.connect("datomic:mem://localhost:9999/no-database")
    conn.connected?.should == false
  end

  it "should successfully connect to a database" do
    Peer.create("datomic:mem://localhost:9999/hellodb2")
    conn = Peer.connect("datomic:mem://localhost:9999/hellodb2")
    conn.connected?.should == true

    conn.db.should == {}
  end

  # ----------------------------------------------------------------------
  # add new data to databases
  # ----------------------------------------------------------------------
  it "should successfully add data to a database" do
  end

  # ----------------------------------------------------------------------
  # remove data from databases
  # ----------------------------------------------------------------------
  it "should successfully remove data from a database" do
  end

  # ----------------------------------------------------------------------
  # get data from databases
  # ----------------------------------------------------------------------
  it "should successfully find data from a database" do
  end
end


