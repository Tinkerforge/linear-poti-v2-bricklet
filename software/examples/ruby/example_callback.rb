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

# Register position callback
lp.register_callback(BrickletLinearPotiV2::CALLBACK_POSITION) do |position|
  puts "Position: #{position} °"
end

# Set period for position callback to 0.25s (250ms) without a threshold
lp.set_position_callback_configuration 250, false, 'x', 0, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
