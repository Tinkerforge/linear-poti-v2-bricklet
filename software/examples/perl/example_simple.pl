#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLinearPotiV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Linear Poti Bricklet 2.0

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $lp = Tinkerforge::BrickletLinearPotiV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current position
my $position = $lp->get_position();
print "Position: $position °\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
