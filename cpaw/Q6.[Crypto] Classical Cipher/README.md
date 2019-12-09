Q6.[Crypto] Classical Cipher
----------------------

問題
----
```
10pt

暗号には大きく分けて、古典暗号と現代暗号の2種類があります。特に古典暗号では、古代ローマの軍事的指導者ガイウス・ユリウス・カエサル（英語読みでシーザー）が初めて使ったことから、名称がついたシーザー暗号が有名です。これは3文字分アルファベットをずらすという単一換字式暗号の一つです。次の暗号文は、このシーザー暗号を用いて暗号化しました。暗号文を解読してフラグを手にいれましょう。

暗号文: fsdz{Fdhvdu_flskhu_lv_fodvvlfdo_flskhu}
```

解き方
-----
シーザー暗号を使ったと書いてあるのでシーザー暗号を実装すれば良いです。


```python:solve.py
#!/usr/bin/env python

org = 'fsdz{Fdhvdu_flskhu_lv_fodvvlfdo_flskhu}'

def caesar(inp, shift=0, mode='az'):
    CHARS = 'abcdefghijklmnopqrstuvwxyz' if mode == 'az' else \
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' if mode == 'aZ' else \
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    inp_list = [CHARS.index(c) if c in CHARS else c for c in org]
    return ''.join([CHARS[i + shift] if isinstance(i, int) else i for i in inp_list])

for i in range(32):
    ans = caesar(org, -i, mode='aZ')
    if ans[:4] == 'cpaw':
        print(ans)

```

FLAG
-----
`cpaw{Caesar_cipher_is_classical_cipher}`
