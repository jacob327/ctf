Easy Cipher 50pt
----------------

問題
----
> EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.

解き方
-----

次の理由で英語っぽいです。
 - ピリオド, カンマがある。
 - 適度にスペースがある。

次の理由で単一換字式っぽいです。
 - `KVVV`が3回出現している。

`EBG KVVV`は固有名詞っぽいです。

英語だとすると
 - 3回出現する`vf`は`is`の可能性が高い
 - 3回出現する`gur`は`the`の可能性が高い
 - 単独で2回出現する`n`は`a`の可能性が高い
     - `n->a`の場合、`na`は`an`の可能性が高い

これらの情報を組んでみます。
```python
#!/usr/bin/env python3
org = 'EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.'
print(f'orginal: {org}')
# orginal: EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.

ans = ''
for c in org:
    c = c.lower()
    if c in (' ', ',', '.'): ans += c
    elif c == 'v': ans += 'i'
    elif c == 'f': ans += 's'
    elif c == 'g': ans += 't'
    elif c == 'u': ans += 'h'
    elif c == 'r': ans += 'e'
    elif c == 'n': ans += 'a'
    elif c == 'a': ans += 'n'
    else: ans += f'[{c}]'
print(ans)
# [e][b]t [k]iii is a si[z][c][y]e [y]ette[e] s[h][o]stit[h]ti[b]n [p]i[c]he[e] that [e]e[c][y]a[p]es a [y]ette[e] [j]ith the [y]ette[e] [k]iii [y]ette[e]s a[s]te[e] it in the a[y][c]ha[o]et. [e][b]t [k]iii is an e[k]a[z][c][y]e [b][s] the [p]aesa[e] [p]i[c]he[e], [q]e[i]e[y][b][c]e[q] in an[p]ient [e][b][z]e. [s][y]a[t] is [s][y]a[t]s[j][m][t][k][o][w]sa[z][d][j][k][k]a[h]. inse[e]t an [h]n[q]e[e]s[p][b][e]e i[z][z]e[q]iate[y][l] a[s]te[e] [s][y]a[t].
```

それっぽいです。

それぞれの単語に注目すると
 - `[y]ette[e]`が複数形含めて4回出現しています。
     - `letter`でしょうか
     - この場合 `a[y][c]ha[o]et`は`alphabet`ぽいです。

```python
#!/usr/bin/env python3
org = 'EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.'
print(f'orginal: {org}')
# orginal: EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.

ans = ''
for c in org:
    c = c.lower()
    if c in (' ', ',', '.'): ans += c
    elif c == 'v': ans += 'i'
    elif c == 'f': ans += 's'
    elif c == 'g': ans += 't'
    elif c == 'u': ans += 'h'
    elif c == 'r': ans += 'e'
    elif c == 'n': ans += 'a'
    elif c == 'a': ans += 'n'
    elif c == 'y': ans += 'l'
    elif c == 'e': ans += 'r'
    elif c == 'c': ans += 'p'
    elif c == 'o': ans += 'b'
    else: ans += f'[{c}]'
print(ans)
# r[b]t [k]iii is a si[z]ple letter s[h]bstit[h]ti[b]n [p]ipher that repla[p]es a letter [j]ith the letter [k]iii letters a[s]ter it in the alphabet. r[b]t [k]iii is an e[k]a[z]ple [b][s] the [p]aesar [p]ipher, [q]e[i]el[b]pe[q] in an[p]ient r[b][z]e. [s]la[t] is [s]la[t]s[j][m][t][k]b[w]sa[z][d][j][k][k]a[h]. insert an [h]n[q]ers[p][b]re i[z][z]e[q]iatel[l] a[s]ter [s]la[t].
```

ここまで来ると、単語の推測からも解けそうですが、次の2つがそれぞれ入れ替わっていることに気づきます。
 - `a`と`n`
 - `e`と`r`

またalphabetの順序を考えると次のように13進めたものが変換後になっています。

 - `a = 0番目, n = 13番目`
 - `e = 4番目, r = 17番目`

ROT13ですね。

```python
#!/usr/bin/env python3
import codecs

org = 'EBG KVVV vf n fvzcyr yrggre fhofgvghgvba pvcure gung ercynprf n yrggre jvgu gur yrggre KVVV yrggref nsgre vg va gur nycunorg. EBG KVVV vf na rknzcyr bs gur Pnrfne pvcure, qrirybcrq va napvrag Ebzr. Synt vf SYNTFjmtkOWFNZdjkkNH. Vafreg na haqrefpber vzzrqvngryl nsgre SYNT.'
ans = codecs.encode(org, 'rot-13')
print(ans)
# ROT XIII is a simple letter substitution cipher that replaces a letter with the letter XIII letters after it in the alphabet. ROT XIII is an example of the Caesar cipher, developed in ancient Rome. Flag is FLAGSwzgxBJSAMqwxxAU. Insert an underscore immediately after FLAG.
```


FLAG
-----
`FLAG_SwzgxBJSAMqwxxAU`

