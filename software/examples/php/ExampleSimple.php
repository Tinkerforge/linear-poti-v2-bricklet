<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletLinearPotiV2.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletLinearPotiV2;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Linear Poti Bricklet 2.0

$ipcon = new IPConnection(); // Create IP connection
$lp = new BrickletLinearPotiV2(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current position
$position = $lp->getPosition();
echo "Position: $position °\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
