function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Linear Poti Bricklet 2.0

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    lp = javaObject("com.tinkerforge.BrickletLinearPotiV2", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current position
    position = lp.getPosition();
    fprintf("Position: %d °\n", position);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
