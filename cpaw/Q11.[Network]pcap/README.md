Q11.[Network]pcap
---------------------

問題
----
```
10pt

ネットワークを流れているデータはパケットというデータの塊です。
それを保存したのがpcapファイルです。
pcapファイルを開いて、ネットワークにふれてみましょう！
pcapファイル
```

解き方
-----

パケット解析の問題です。

wiresharkとかで開けばよいです。

もしくはバイナリファイルの文字列を出力するstringコマンドで

```bash
$ strings network10.pcap
Qcpaw{gochi_usa_kami}
Qcpaw{gochi_usa_kami}
```

FLAG
-----
`cpaw{gochi_usa_kami}`

