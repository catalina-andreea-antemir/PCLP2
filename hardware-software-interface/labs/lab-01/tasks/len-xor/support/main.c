// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "len_xor.h"

int main(void)
{
	/* TODO: Test functions */
	const char *str = "ababababacccbacbacbacbacbabc";
	printf("length = %d\n", my_strlen(str));
	equality_check(str);

	return 0;
}
