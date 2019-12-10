Q18.[Forensic]leaf in forest
---------------------

問題
----
```
100pt

このファイルの中にはフラグがあります。探してください。
フラグはすべて小文字です！

file
```

解き方
------
まずファイルを判別します。

```bash
$ file misc100
misc100: pcap capture file, microsecond ts (little-endian) - version 0.0, capture length 1869357413)
```

pcapなのでwiresharkとかで開けそうです。

パケット解析の前に`strings`をしておきます。

```bash
$ strings misc100
(前略) lovelive!lovelive!lovelive!lovelive!lovelive!lovelive!lovelive!}}}
```

次の2つ理由でパケット解析よりもstringsでの編集を試みます。
 - 最後の文字が`}`であり、いらない文字を削除すればフラグになるかもしれない
 - 同じような文字が連続しているので一気に消せば上手く行くかもしれない

```bash
$ strings misc100 | sed -e's/love//g' -e's/live//g' -e's/!//g'
eCCCelivPPPoveAAAelovWWWve{{{eliMMMelGGGlivRRRovelEEEPPPe}}}
```

大文字と`{``}`を抽出すれば良さそうです。

```bash
$ strings misc100|sed -e 's/[^A-Z{}]//g' -e's/\(.\)\1*/\1/g'| awk '{print tolower($0)}'
cpaw{mgrep}
```


FALG
----
`cpaw{mgrep}`
