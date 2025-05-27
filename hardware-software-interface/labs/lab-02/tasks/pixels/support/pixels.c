// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

#include "pixel.h"
#include "pixels.h"

void reverse_pic(struct picture *pic)
{
	int i, j;
	for (j = 0; j < pic->width; j++) {
		for (i = 0; i < pic->height / 2; i++) {
			struct pixel tmp = pic->pix_array[i][j];
			pic->pix_array[i][j] = pic->pix_array[pic->height - i - 1][j];
			pic->pix_array[pic->height - i - 1][j] = tmp;
		}
	}
}

void color_to_gray(struct picture *pic)
{
	int i, j;
	for (i = 0; i < pic->height; i++) {
		for (j = 0; j < pic->width; j++) {
			pic->pix_array[i][j].R = 0.3 * pic->pix_array[i][j].R;
			pic->pix_array[i][j].G = 0.59 * pic->pix_array[i][j].G;
			pic->pix_array[i][j].B = 0.11 * pic->pix_array[i][j].B;
		}
	}
}
