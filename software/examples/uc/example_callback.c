// This example is not self-contained.
// It requires usage of the example driver specific to your platform.
// See the HAL documentation.

#include "src/bindings/hal_common.h"
#include "src/bindings/bricklet_linear_poti_v2.h"

void check(int rc, const char *msg);
void example_setup(TF_HAL *hal);
void example_loop(TF_HAL *hal);

// Callback function for position callback
static void position_handler(TF_LinearPotiV2 *device, uint8_t position, void *user_data) {
	(void)device; (void)user_data; // avoid unused parameter warning

	tf_hal_printf("Position: %I8u %%\n", position);
}

static TF_LinearPotiV2 lp;

void example_setup(TF_HAL *hal) {
	// Create device object
	check(tf_linear_poti_v2_create(&lp, NULL, hal), "create device object");

	// Register position callback to function position_handler
	tf_linear_poti_v2_register_position_callback(&lp,
	                                             position_handler,
	                                             NULL);

	// Set period for position callback to 0.25s (250ms) without a threshold
	tf_linear_poti_v2_set_position_callback_configuration(&lp, 250, false, 'x', 0, 0);
}

void example_loop(TF_HAL *hal) {
	// Poll for callbacks
	tf_hal_callback_tick(hal, 0);
}
