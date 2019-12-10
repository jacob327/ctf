Q20.[Crypto]Block Cipher
----------------

問題
----
```
100pt

与えられたC言語のソースコードを読み解いて復号してフラグを手にれましょう。

暗号文：cpaw{ruoYced_ehpigniriks_i_llrg_stae}

crypto100.c
```

解き方
------
まずファイルを読みます。

`$ cat crypto100.c`

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char* argv[]){
  int i;
  int j;
  int key = atoi(argv[2]);
  const char* flag = argv[1];
  printf("cpaw{");
  for(i = key - 1; i <= strlen(flag); i+=key) for(j = i; j>= i - key + 1; j--) printf("%c", flag[j]);
  printf("}");
  return 0;
}
```

第一引数にflag, 第二引数にkey(数値)を指定して暗号化したようです。

コードを読み込む前に、共通鍵暗号である可能性を考慮して(※)試しにいくつか試してみます。

※共通鍵暗号の場合、同じkeyで暗号⇔復号が可能です。

```bash
$ gcc crypto100.c # コンパイル
$ for i in $(seq 10);do ./a.out ruoYced_ehpigniriks_i_llrg_stae $i; echo ''; done
cpaw{ruoYced_ehpigniriks_i_llrg_stae}
cpaw{urYoec_dheipngriki_s_illgrs_ate}
cpaw{ourecYe_diphingkiri_sll__grats}
cpaw{Your_deciphering_skill_is_great}
cpaw{cYourhe_deingip_skirrll_iats_g}
cpaw{ecYouriphe_dkiringll_i_sats_gr}
cpaw{decYourngiphe_i_skiris_grll_}
cpaw{_decYourringiphell_i_skieats_gr}
cpaw{e_decYourkiringiph_grll_i_s}
cpaw{he_decYour_skiringipats_grll_i}
```

FALG
----
`cpaw{Your_deciphering_skill_is_great}`

