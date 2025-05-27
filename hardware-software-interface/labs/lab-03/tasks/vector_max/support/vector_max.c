// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "vector_max.h"

int vector_max(int *v, int len)
{
	int max;
	unsigned int i;

	/**
	 * TODO: Implement finding the maximum value in the vector
	 */

	i = 0;
	max = -1;

label:
	if (i >= len) {
		goto end;
	}
	if (*(v + i) > max) {
		goto update_max;
	} else {
		goto next;
	}

next:
	i++;
	goto label;

update_max:
	max = *(v + i);
	goto next;

end:
	return max;
}
