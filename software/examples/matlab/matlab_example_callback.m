function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLinearPotiV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Linear Poti Bricklet 2.0

    ipcon = IPConnection(); % Create IP connection
    lp = handle(BrickletLinearPotiV2(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register position callback to function cb_position
    set(lp, 'PositionCallback', @(h, e) cb_position(e));

    % Set period for position callback to 0.25s (250ms) without a threshold
    lp.setPositionCallbackConfiguration(250, false, 'x', 0, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for position callback
function cb_position(e)
    fprintf('Position: %i %%\n', e.position);
end
