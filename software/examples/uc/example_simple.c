#include "bindings/hal_common.h"
#include "bindings/bricklet_linear_poti_v2.h"

#define UID "XYZ" // Change XYZ to the UID of your Linear Poti Bricklet 2.0

void check(int rc, const char* msg);

TF_LinearPotiV2 lp;

void example_setup(TF_HalContext *hal) {
	// Create device object
	check(tf_linear_poti_v2_create(&lp, UID, hal), "create device object");

	// Get current position
	uint8_t position;
	check(tf_linear_poti_v2_get_position(&lp, &position), "get position");

	tf_hal_printf("Position: %u °\n", position);
}

void example_loop(TF_HalContext *hal) {
	// Poll for callbacks
	tf_hal_callback_tick(hal, 0);
}
