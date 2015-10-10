/*
 * =====================================================================================
 *
 *       Filename:  shuffle.c
 *
 *    Description:  shuffle cards (SHCD)(2-10JQKA)
 *
 *        Version:  1.0
 *        Created:  2015/10/10 14时41分21秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  JIN Xiaoyang (jinxiaoyang@jinxiaoyang.cn), 
 *
 * =====================================================================================
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAXLEN 52
#define VALLEN 26
const char OriginArr[MAXLEN]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52};

void print_arr(char* arr)
{
    int i;
    for(i=0; i<VALLEN; i++)
    {
	int val=*arr++;
	int shape_int=(val-1)/13;
	int value_int=(val-1)%13;
	char shape, value;

	switch(shape_int)
	{
	    case 0: shape='S';break;
	    case 1: shape='H';break;
	    case 2: shape='C';break;
	    case 3: shape='D';break;
	    default:break;
	}

	switch(value_int)
	{
	    case 0: value='2';break;
	    case 1: value='3';break;
	    case 2: value='4';break;
	    case 3: value='5';break;
	    case 4: value='6';break;
	    case 5: value='7';break;
	    case 6: value='8';break;
	    case 7: value='9';break;
	    case 8: value='0';break;
	    case 9: value='J';break;
	    case 10: value='Q';break;
	    case 11: value='K';break;
	    case 12: value='A';break;
	    default:break;
	}
	printf("%c%c ", shape, value);
    }
    printf("\n");
}

void shuffle_arr(char* arr)
{
    int i=MAXLEN, j;
    char temp;

    while ( --i ) {
	j = rand() % (i+1);
	temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
    }
}

int main(int argc,char *argv[])
{
    int rep_i, rep;
    char tempArr[MAXLEN]={0};

    if(argc>1)
    {
	rep=atoi(argv[1]);
    }
    else
    {
	rep=10;
    }

    for(rep_i=0; rep_i<rep; rep_i++)
    {
	strncpy(tempArr, OriginArr, MAXLEN);
	shuffle_arr(tempArr);
	print_arr(tempArr);
    }

    return 0;
}
