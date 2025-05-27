// SPDX-License-Identifier: BSD-3-Clause

#include <stddef.h>
#include <string.h>

#include "pointers.h"

int my_strcmp(const char *s1, const char *s2)
{
	/**
	 * TODO: implement function
	 */
	int i = 0;
	int j = 0;
	while (i < strlen(s1) && j < strlen(s2)) {
		if (*(s1 + i) < *(s2 + j)) {
			return -1;
		} else if (*(s1 + i) > *(s2 + j)) {
			return 1;
		} else {
			i++;
			j++;
		}
	}
	if (strlen(s1) - strlen(s2) < 0) {
		return -1;
	} else if (strlen(s1) - strlen(s2) > 0) {
		return 1;
	} else return 0;
}

void *my_memcpy(void *dest, const void *src, size_t n)
{
	/**
	 * TODO: implement function
	 */
	int i;
	for (i = 0; i < n; i++) {
		*((char*)dest + i) = *((char*)src + i);
	}
	return dest;
}

char *my_strcpy(char *dest, const char *src)
{
	/**
	 * TODO: implement function
	 */
	for (int i = 0; i <= strlen(src); i++) {
		*((char*)dest + i) = *((char*)src + i);
	}
	return dest;
}
