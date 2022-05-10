<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLinearPotiV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLinearPotiV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Linear Poti Bricklet 2.0

// Callback function for position callback
function cb_position($position)
{
    echo "Position: $position %\n";
}

$ipcon = new IPConnection(); // Create IP connection
$lp = new BrickletLinearPotiV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register position callback to function cb_position
$lp->registerCallback(BrickletLinearPotiV2::CALLBACK_POSITION, 'cb_position');

// Set period for position callback to 0.25s (250ms) without a threshold
$lp->setPositionCallbackConfiguration(250, FALSE, 'x', 0, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
