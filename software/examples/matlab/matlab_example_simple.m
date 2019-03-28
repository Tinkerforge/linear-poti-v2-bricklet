function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletLinearPotiV2;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Linear Poti Bricklet 2.0

    ipcon = IPConnection(); % Create IP connection
    lp = handle(BrickletLinearPotiV2(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current position
    position = lp.getPosition();
    fprintf('Position: %i °\n', position);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
