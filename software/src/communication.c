/* linear-poti-v2-bricklet
 * Copyright (C) 2019 Olaf Lüke <olaf@tinkerforge.com>
 *
 * communication.c: TFP protocol message handling
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "communication.h"

#include "bricklib2/utility/communication_callback.h"
#include "bricklib2/protocols/tfp/tfp.h"

#include "poti.h"


#define CALLBACK_VALUE_TYPE CALLBACK_VALUE_TYPE_UINT8
#include "bricklib2/utility/callback_value.h"
CallbackValue_uint8_t callback_value_position;


BootloaderHandleMessageResponse handle_message(const void *message, void *response) {
	switch(tfp_get_fid_from_message(message)) {
		case FID_GET_POSITION: return get_callback_value_uint8_t(message, response, &callback_value_position);
		case FID_SET_POSITION_CALLBACK_CONFIGURATION: return set_callback_value_callback_configuration_uint8_t(message, &callback_value_position);
		case FID_GET_POSITION_CALLBACK_CONFIGURATION: return get_callback_value_callback_configuration_uint8_t(message, response, &callback_value_position);
		default: return HANDLE_MESSAGE_RESPONSE_NOT_SUPPORTED;
	}
}


bool handle_position_callback(void) {
	return handle_callback_value_callback_uint8_t(&callback_value_position, FID_CALLBACK_POSITION);
}

void communication_tick(void) {
	communication_callback_tick();
}

void communication_init(void) {
	callback_value_init_uint8_t(&callback_value_position, poti_get_value);

	communication_callback_init();
}
