#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletLinearPotiV2;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Linear Poti Bricklet 2.0

# Callback subroutine for position callback
sub cb_position
{
    my ($position) = @_;

    print "Position: $position °\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $lp = Tinkerforge::BrickletLinearPotiV2->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register position callback to subroutine cb_position
$lp->register_callback($lp->CALLBACK_POSITION, 'cb_position');

# Set period for position callback to 0.25s (250ms) without a threshold
$lp->set_position_callback_configuration(250, 0, 'x', 0, 0);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
