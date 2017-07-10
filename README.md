# 洗牌算法

从 52 张牌中（13种点数，4种花色）随机抽取 26 张，并输出到屏幕

## C语言版

### 生成可执行文件

```bash
make
```

### 使用方法

> Usage: ./bin/shuffle [-e `RUN_NUM`] [-f `FILE`] [`NUMBER`]

* -e 参数：表示从固定的牌顺序开始，随机交换其中的两张牌并重复 `RUN_NUM` 次

* -f 参数：表示文件 `FILE` 中获取随机数，根据获取到的随机数对牌进行打乱。文件中
  应包含不循环的数字序列，参考文件 `pi/pi-10k.txt`

* `NUMBER`: 需要生成的牌局数量

注意
1. -e 参数和 -f 参数不同时生效，-f 参数具有更高的优先级
2. 如果 -e 参数和 -f 参数均不使用，则按照随机抽取牌的方法对牌进行打乱
3. 使用 -f 参数时，如果不指定需要生成的牌局数量，则程序将会用完文件中的随机数，
   生成尽可能多的牌局

示例：
```bash
./bin/shuffle 5
./bin/shuffle -e 500 5
./bin/shuffle -f pi/pi-10k.txt
```

## bash 版

### 使用方法

> Usage: bash shuffle.sh [`NUMBER`]

* `NUMBER`: 需要生成的牌局数量

示例：
```bash
bash shuffle.sh 5
```

# 输出范例

4种花色包括
* S (♠) (黑桃)
* H (♥) (红桃)
* C (♣) (梅花)
* D (♦) (方片)

13种点数包括 A/2/3/4/5/6/7/8/9/10/J/Q/K

```
H9 HJ H3 D4 S3 S4 HA H7 SQ C2 S2 H0 H2 CJ C8 C6 C9 DQ S7 D2 H6 DK CA C3 S5 DA
C9 D6 CQ D5 H6 D3 S9 SA D9 D0 S0 SK CA SQ S8 H7 H4 C0 D4 S3 H0 HA H8 CK DJ D2
S5 D7 DK DA CA D8 S6 HK SQ D9 C5 H0 S2 S8 SK H8 D6 HQ C3 C7 S3 S4 SJ C8 C4 DJ
DQ DA C9 HK D9 S2 CJ C4 C2 H6 H9 HA C7 H4 D2 H5 C8 C6 SA HJ D0 D3 S7 DJ C5 C3
C0 D3 CA S7 SK H7 S4 H5 DJ H9 C8 H0 D2 SJ DK CQ CK S3 CJ S9 S8 S5 D5 C2 SQ DQ
```
