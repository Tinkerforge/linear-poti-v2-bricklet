// This example is not self-contained.
// It requires usage of the example driver specific to your platform.
// See the HAL documentation.

#include "src/bindings/hal_common.h"
#include "src/bindings/bricklet_linear_poti_v2.h"

void check(int rc, const char *msg);
void example_setup(TF_HAL *hal);
void example_loop(TF_HAL *hal);

static TF_LinearPotiV2 lp;

void example_setup(TF_HAL *hal) {
	// Create device object
	check(tf_linear_poti_v2_create(&lp, NULL, hal), "create device object");

	// Get current position
	uint8_t position;
	check(tf_linear_poti_v2_get_position(&lp, &position), "get position");

	tf_hal_printf("Position: %I8u %%\n", position);
}

void example_loop(TF_HAL *hal) {
	// Poll for callbacks
	tf_hal_callback_tick(hal, 0);
}
