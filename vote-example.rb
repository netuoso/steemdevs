#!/usr/bin/env ruby

require 'radiator'

class Bot

  attr_reader :author, :permlink, :weight

  STEEMUSER, STEEMKEY, STEEMRPC = ['STEEMUSERHERE', 'STEEMKEYHERE', 'https://steemd.steemit.com']

  def initialize(options)
    @options = JSON.parse(options)
    @author = @options['author']
    @permlink = @options['permlink']
    @weight = @options['weight']
  end

  def vote
    tx = Radiator::Transaction.new(url:STEEMRPC, wif: STEEMKEY)
    Radiator::Operation
    vote_tx = {
      type: :vote,
      voter: STEEMUSER,
      author: author,
      permlink: permlink,
      weight: weight.to_i*100
    }
    tx.operations << vote_tx
    puts tx.process(true)
  end

end

Bot.new(ARGV[0]).vote
