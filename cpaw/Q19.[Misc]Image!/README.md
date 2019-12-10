Q19.[Misc]Image!
----------------

問題
----
```
100pt

Find the flag in this zip file.
file
```

解き方
------
まずファイルを判別します。

```bash
$ file misc100.zip
misc100.zip: OpenDocument Drawing
```

ドキュメントファイルなのでoffice系ソフトで開けば良いです。

```bash
$ libreoffice misc100.zip
```


FALG
----
`cpaw{It_is_fun__isn't_it?}`

