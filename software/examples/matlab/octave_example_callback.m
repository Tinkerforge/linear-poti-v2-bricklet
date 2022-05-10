function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Linear Poti Bricklet 2.0

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    lp = javaObject("com.tinkerforge.BrickletLinearPotiV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register position callback to function cb_position
    lp.addPositionCallback(@cb_position);

    % Set period for position callback to 0.25s (250ms) without a threshold
    lp.setPositionCallbackConfiguration(250, false, "x", 0, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for position callback
function cb_position(e)
    fprintf("Position: %d %%\n", e.position);
end
