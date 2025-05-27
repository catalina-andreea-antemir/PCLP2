// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "mirror.h"

int my_strlen(const char *s) {
	int n = 0;
	while (*s != '\0') {
		n++;
		s++;
	}
	return n;
}

void mirror(char *s)
{
	/* TODO */
	char *aux;
	int n = my_strlen(s);
	for (int i = 0; i < n / 2; i++) {
		char tmp = *(s + i);
		*(s + i) = *(s + n - i - 1);
		*(s + n - i - 1) = tmp;
	}
}
