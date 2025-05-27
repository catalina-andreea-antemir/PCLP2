// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "delete_first.h"

char *delete_first(char *s, char *pattern)
{
	/**
	 * TODO: Implement this function
	 */

	if (strstr(s, pattern) == NULL) {
		return s;
	} else {
		int poz = strstr(s, pattern) - s;
		strcpy(s + poz, s + poz + strlen(pattern));
		return s;
	}

	return NULL;
}
