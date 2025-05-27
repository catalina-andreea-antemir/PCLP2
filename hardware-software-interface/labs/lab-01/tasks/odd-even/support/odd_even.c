// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>

#include "odd_even.h"

void print_binary(int number, int nr_bits)
{
	/* TODO */
	int i;
	int *bits = malloc(nr_bits * sizeof(int)); 
	for (i = 0; i < nr_bits; i++) {
		*(bits + i) = (number & 1);
		number = number >> 1;
	}
	printf("0b");
	for (i = nr_bits - 1; i >= 0; i--) {
		printf("%d", *(bits + i));
	}
	printf("\n");
	free(bits);
}

void check_parity(int *numbers, int n)
{
	/* TODO */
	int i;
	for (i = 0; i < n; i++) {
		if ((*(numbers + i) & 1) == 0) {
			print_binary(*(numbers + i), 8);
		} else {
			printf("0x%08X\n", *(numbers + i));
		}
	}
}
