import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletLinearPotiV2;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Linear Poti Bricklet 2.0
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletLinearPotiV2 lp = new BrickletLinearPotiV2(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Add position listener
		lp.addPositionListener(new BrickletLinearPotiV2.PositionListener() {
			public void position(int position) {
				System.out.println("Position: " + position + " °");
			}
		});

		// Set period for position callback to 0.25s (250ms) without a threshold
		lp.setPositionCallbackConfiguration(250, false, 'x', 0, 0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
