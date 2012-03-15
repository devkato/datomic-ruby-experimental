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
    conn = Peer.connect("datomic:mem://localhost:9999/hellodb2")
  end

  # ----------------------------------------------------------------------
  # remove data from databases
  # ----------------------------------------------------------------------
  it "should successfully remove data from a database" do
  end

  # ----------------------------------------------------------------------
  # create new schema
  # ----------------------------------------------------------------------
  it "should successfully create a new schema to a database" do
  end


  # ----------------------------------------------------------------------
  # calculate temporary id
  # ----------------------------------------------------------------------
  it "should successfully get a new uniq id" do
    tempids = []

    1.upto(10000) {|i| tempids << Peer.tempid("db.part/db#{i}") }

    # check uniqueness
    tempids.size.should == tempids.uniq.size
  end

  # ----------------------------------------------------------------------
  # get data from databases
  # ----------------------------------------------------------------------
  it "should successfully find data from a database" do
    conn = Peer.connect("datomic:mem://localhost:9999/hellodb2")

    Peer.q_print({
      :find => [:c],
      :where => [
        {:entity => :c, :attribute => ':community/name'}
    ]}, conn).should == "[ :find ?c :where [ ?c :community/name ] ]"

    Peer.q_print({
      :find => [:c, :n],
      :where => [
        {:entity => :c, :attribute => ':community/name', :value => :n}
    ]}, conn).should == "[ :find ?c ?n :where [ ?c :community/name ?n ] ]"

    Peer.q_print({
      :find => [:n, :u],
      :where => [
        {:entity => :c, :attribute => ':community/name', :value => :n},
        {:entity => :c, :attribute => ':community/url', :value => :u}
    ]}, conn).should == "[ :find ?n ?u :where [ ?c :community/name ?n ] [ ?c :community/url ?u ] ]"

    Peer.q_print({
      :find => [:e, :c],
      :where => [
        {:entity => :e, :attribute => ':community/name', :value => %!"belltown"!},
        {:entity => :e, :attribute => ':community/category', :value => :c}
    ]}, conn).should == %![ :find ?e ?c :where [ ?e :community/name "belltown" ] [ ?e :community/category ?c ] ]!

    Peer.q_print({
      :find => [:n],
      :where => [
        {:entity => :c, :attribute => ':community/name', :value => :n},
        {:entity => :c, :attribute => ':community/type', :value => ':community.type/twitter'}
    ]}, conn).should == "[ :find ?n :where [ ?c :community/name ?n ] [ ?c :community/type :community.type/twitter ] ]"

    Peer.q_print({
      :find => [:c_name],
      :where => [
        {:entity => :c, :attribute => ':community/name', :value => :c_name},
        {:entity => :c, :attribute => ':community/neighborhood', :value => :n},
        {:entity => :n, :attribute => ':neighborhood/district', :value => :d},
        {:entity => :d, :attribute => ':district/region', :value => ':region/ne'},
    ]}, conn).should == "[ :find ?c_name :where" +
                          " [ ?c :community/name ?c_name ]" +
                          " [ ?c :community/neighborhood ?n ]" +
                          " [ ?n :neighborhood/district ?d ]" +
                          " [ ?d :district/region :region/ne ]" +
                        " ]"

    Peer.q_print({
      :find => [:c_name, :r_name],
      :where => [
        {:entity => :c, :attribute => ':community/name', :value => :c_name},
        {:entity => :c, :attribute => ':community/neighborhood', :value => :n},
        {:entity => :n, :attribute => ':neighborhood/district', :value => :d},
        {:entity => :d, :attribute => ':district/region', :value => :r},
        {:entity => :r, :attribute => ':db/ident', :value => :r_name}
    ]}, conn).should == "[ :find ?c_name ?r_name :where" +
                          " [ ?c :community/name ?c_name ]" +
                          " [ ?c :community/neighborhood ?n ]" +
                          " [ ?n :neighborhood/district ?d ]" +
                          " [ ?d :district/region ?r ]" +
                          " [ ?r :db/ident ?r_name ]" +
                        " ]"
  end
end


