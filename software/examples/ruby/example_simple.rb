#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_linear_poti_v2'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Linear Poti Bricklet 2.0

ipcon = IPConnection.new # Create IP connection
lp = BrickletLinearPotiV2.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current position
position = lp.get_position
puts "Position: #{position} °"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
