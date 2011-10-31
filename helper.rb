require 'rubygems'
require 'bundler/setup'
require 'kuro-rs'
require 'rack'
require 'sinatra/reloader' if development?
require 'mongoid'
require File.dirname(__FILE__)+'/models/ir'
require 'net/http'
require 'haml'
require 'yaml'
require 'json'

begin
  @@conf = YAML::load open(File.dirname(__FILE__)+'/config.yaml').read
  p @@conf
rescue => e
  STDERR.puts 'config.yaml load error!'
  STDERR.puts e
  exit 1
end

@@conf['kuro_rs_server'] += '/' unless @@conf['kuro_rs_server'] =~ /\/$/

Mongoid.configure{|conf|
  conf.master = Mongo::Connection.new(@@conf['mongo_server'], @@conf['mongo_port']).db(@@conf['mongo_dbname'])
}

def kuro_rs_server
  @@conf['kuro_rs_server']
end

def app_root
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
end

