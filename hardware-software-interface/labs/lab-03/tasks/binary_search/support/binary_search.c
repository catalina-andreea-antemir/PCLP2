// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#include "binary_search.h"

int binary_search(int *v, int len, int dest)
{
	int start = 0;
	int end = len - 1;
	int middle;

	/**
	 * TODO: Implement binary search
	 */

label_start:
	if (start > end) {
		goto end;
	}
	middle = (start + end) / 2;
	if (*(v + middle) == dest) {
		goto found;
	}
	if (*(v + middle) > dest) {
		goto update_end;
	}
	if (*(v + middle) < dest) {
		goto update_start;
	}

update_start:
	start = middle + 1;
	goto label_start;

update_end:
	end = middle - 1;
	goto label_start;

found:
	return middle;	

end:
	return -1;
}
