var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Linear Poti Bricklet 2.0

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var lp = new Tinkerforge.BrickletLinearPotiV2(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for position callback to 0.25s (250ms) without a threshold
        lp.setPositionCallbackConfiguration(250, false, 'x', 0, 0);
    }
);

// Register position callback
lp.on(Tinkerforge.BrickletLinearPotiV2.CALLBACK_POSITION,
    // Callback function for position callback
    function (position) {
        console.log('Position: ' + position + ' °');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
