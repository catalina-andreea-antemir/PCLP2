// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "rotate.h"

void rotate_left(unsigned int *number, int bits)
{
	/* TODO */
	bits = bits % (sizeof(*number) * 8);
	*number = (*number << bits) | (*number >> (sizeof(*number) * 8 - bits));
}

void rotate_right(unsigned int *number, int bits)
{
	/* TODO */
	bits = bits % (sizeof(*number) * 8);
	*number = (*number >> bits) | (*number << (sizeof(*number) * 8 - bits));
}
