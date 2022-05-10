use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, linear_poti_v2_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Linear Poti Bricklet 2.0.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let lp = LinearPotiV2Bricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    let position_receiver = lp.get_position_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `lp` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for position in position_receiver {
            println!("Position: {} %", position);
        }
    });

    // Set period for position callback to 0.25s (250ms) without a threshold.
    lp.set_position_callback_configuration(250, false, 'x', 0, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
