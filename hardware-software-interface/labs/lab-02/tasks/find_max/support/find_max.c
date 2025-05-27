// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "find_max.h"

void *find_max(void *arr, int n, size_t element_size,
				int (*compare)(const void *, const void *))
{
	void *max_elem = arr;

	/**
	 * TODO: Implement function
	 */
	for (int i = 0; i < n; i++) {
		int x = compare(max_elem, arr + i);
		if (x <= 0) {
			max_elem = arr + i;
		}
	}

	return max_elem;
}

int compare(const void *a, const void *b)
{
	/**
	 * TODO: Implement function
	 */
	return *(int*)a - *(int*)b;
}
