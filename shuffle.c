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

// 对应52张牌打乱前的状态
const char OriginArr[MAXLEN]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52};
// 当 i 取2:52，而 X 是一个随机的两位数时，为了使 X%i 的值均匀分布，
// 则当 X 超过某个数字时应该被跳过，这里的某个数字的计算方法为：
// i*floor(100/i)-1
const char RandomIntCeiling[MAXLEN-1]={99,98,99,99,95,97,95,98,99,98,95,90,97,89,95,84,89,94,99,83,87,91,95,99,77,80,83,86,89,92,95,98,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,50,51};

// 根据数字序列打印具体的牌局序列
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

// 从文件中获取随机数，生成随机牌局
int shuffle_arr_fp(char* arr, FILE *fp)
{
    int i=MAXLEN, j;
    char temp;

    while ( --i ) {
	char randomChar[2]={0};
	int randomInt=0;

	// 从文件中依次获取的是两位数的序列，这个序列本身可以看成是随机的，
	// 然而取模之后则未必；为使 j 的取值真正无偏，一些数字需要被跳过；
	// 所以加上一个循环；具体哪些数字被跳过取决于模是哪个数字。
	while(1)
	{
	    if(!fread(randomChar, sizeof(char), 2, fp))
	    {
		return 0;
	    }

	    randomInt=atoi(randomChar);
	    if(randomInt<=RandomIntCeiling[i-1])
	    {
		break;
	    }
	}
	/* printf("%d\n", atoi(randomChar)); */

	j = randomInt % (i+1);
	temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
    }

    return 1;
}

// 从随机数发生器中获取随机数，生成随机牌局
void shuffle_arr(char* arr)
{
    int i=MAXLEN, j;
    char temp;

    while ( --i ) {
	// 洗牌方法参考：http://coolshell.cn/articles/8593.html
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

    if(argc==1)
    {
	printf("Usage: %s [NUMBER]|[FILE]\n", argv[0]);
	return 0;
    }

    FILE *fp_r;
    /* printf("%s\n", argv[1]); */
    // 当参数为文件时，根据随机数文件中生成随机牌局
    // 否则使用系统的随机数发生器
    if(fp_r = fopen(argv[1],"r"))
    {
	while(fp_r)
	{
	    strncpy(tempArr, OriginArr, MAXLEN);
	    if(!shuffle_arr_fp(tempArr, fp_r))
	    {
		break;
	    }
	    print_arr(tempArr);
	}
	fclose(fp_r);
    }
    else
    {
	rep=atoi(argv[1]);

	for(rep_i=0; rep_i<rep; rep_i++)
	{
	    strncpy(tempArr, OriginArr, MAXLEN);
	    shuffle_arr(tempArr);
	    print_arr(tempArr);
	}
    }

    return 0;
}
