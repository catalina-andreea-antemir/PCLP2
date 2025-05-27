// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "mirror.h"

int main(void)
{
	/* TODO: Test function */
	char *s;
	const char *input;

	input = "LoremIpsum";
	s = malloc(strlen(input) + 1);
	strcpy(s, input);
	mirror(s);
	printf("mirror(%s) = %s\n", input, s);
	free(s);

	// Test 2
	input = "asdfghjl";
	s = malloc(strlen(input) + 1);
	strcpy(s, input);
	mirror(s);
	printf("mirror(%s) = %s\n", input, s);
	free(s);

	// Test 3
	input = "qwerty";
	s = malloc(strlen(input) + 1);
	strcpy(s, input);
	mirror(s);
	printf("mirror(%s) = %s\n", input, s);
	free(s);

	return 0;
}
