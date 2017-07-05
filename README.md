# 洗牌算法
从 52 张牌中（13种点数，4种花色）随机抽取 26 张，并输出到屏幕

## C语言版

```bash
make
./bin/shuffle 5
```

## bash 版

```bash
bash shuffle.sh 5
```

# 输出范例

4种花色包括
* S (♠)
* H (♥)
* C (♣)
* D (♦)

13种点数包括 A/2/3/4/5/6/7/8/9/10/J/Q/K

```
H9 HJ H3 D4 S3 S4 HA H7 SQ C2 S2 H0 H2 CJ C8 C6 C9 DQ S7 D2 H6 DK CA C3 S5 DA
C9 D6 CQ D5 H6 D3 S9 SA D9 D0 S0 SK CA SQ S8 H7 H4 C0 D4 S3 H0 HA H8 CK DJ D2
S5 D7 DK DA CA D8 S6 HK SQ D9 C5 H0 S2 S8 SK H8 D6 HQ C3 C7 S3 S4 SJ C8 C4 DJ
DQ DA C9 HK D9 S2 CJ C4 C2 H6 H9 HA C7 H4 D2 H5 C8 C6 SA HJ D0 D3 S7 DJ C5 C3
C0 D3 CA S7 SK H7 S4 H5 DJ H9 C8 H0 D2 SJ DK CQ CK S3 CJ S9 S8 S5 D5 C2 SQ DQ
```
