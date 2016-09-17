require_relative './app.rb'

require 'stackprof'

Dir.mkdir('/tmp/stackprof') unless File.exist?('/tmp/stackprof')
use StackProf::Middleware, enabled: ENV['ISUPROFILE'] == ?1, mode: :cpu, interval: 1000, save_every: 100, path: '/tmp/stackprof'

run Isuconp::App
