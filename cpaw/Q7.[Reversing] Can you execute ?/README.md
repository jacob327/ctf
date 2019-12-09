Q7.[Reversing] Can you execute ?
----------------------

問題
----
```
10pt

拡張子がないファイルを貰ってこのファイルを実行しろと言われたが、どうしたら実行出来るのだろうか。
この場合、UnixやLinuxのとあるコマンドを使ってファイルの種類を調べて、適切なOSで実行するのが一般的らしいが…
問題ファイル： exec_me
```

解き方
-----
ファイルの種類を判別して実行すれば良いです。

ファイルの判別は`file`コマンドを使います。

```bash
$ file exec_me
exec_me: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.24, BuildID[sha1]=663a3e0e5a079fddd0de92474688cd6812d3b550, not stripped
```

64-bit のLinuxで実行可能そうなので、Linux上で実行すれば良いです。

```bash
$ chmod +x exec_me
$ ./exec_me
```

FLAG
-----
`cpaw{Do_you_know_ELF_file?}`

