#!/usr/bin/env ruby

JRUBY = '/usr/local/jruby-1.5.0/bin/jruby'

puts `#{JRUBY} #{File.dirname(__FILE__)}/main.rb`
