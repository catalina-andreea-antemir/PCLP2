// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "len_xor.h"

int my_strlen(const char *str)
{
	/* TODO */

	/**
	 * The cast to (void) is used to avoid a compiler warning. Remove the line
	 * below to find out what the warning is.
	 *
	 * Remove this cast when implementing the function.
	 */
	int length = 0;
	while (*str != '\0') {
		length++;
		str++;
	}
	return length;
}

void equality_check(const char *str)
{
	/* TODO */
	int length = my_strlen(str);
	for (int i = 0; i < length; i++) {
		int nr = 1;
		for (int j = 0; j < i; j++) {
			nr = nr * 2;
		}
		if ((*(str + i) ^ *(str + ((i + nr) % length))) == 0) {
			printf("Address of %c: %p\n", *(str + i), str + i);
		}
	}
}
