using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Linear Poti Bricklet 2.0

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLinearPotiV2 lp = new BrickletLinearPotiV2(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current position
		byte position = lp.GetPosition();
		Console.WriteLine("Position: " + position + " %");

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
