// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "iterate.h"
#include "array.h"

void print_chars(void)
{
	/**
	 * TODO: Implement function
	 */
	unsigned char *char_ptr = (unsigned char*)&v;
	for (unsigned int i = 0; i < (sizeof(v) / sizeof(*char_ptr)); i++) {
		printf("%p -> 0x%x\n", char_ptr, *char_ptr);
		char_ptr++;
	}

	printf("-------------------------------\n");
}

void print_shorts(void)
{
	/**
	 * TODO: Implement function
	 */
	unsigned short *short_ptr = (unsigned short*)&v;
	for (unsigned short i = 0; i < (sizeof(v) / sizeof(*short_ptr)); i++) {
		printf("%p -> 0x%x\n", short_ptr, *short_ptr);
		short_ptr++;
	}

	printf("-------------------------------\n");
}

void print_ints(void)
{
	/**
	 * TODO: Implement function
	 */
	unsigned int *int_ptr = (unsigned int*)&v;
	for (unsigned int i = 0; i < (sizeof(v) / sizeof(*int_ptr)); i++) {
		printf("%p -> 0x%x\n", int_ptr, *int_ptr);
		int_ptr++;
	}

	printf("-------------------------------\n");
}
