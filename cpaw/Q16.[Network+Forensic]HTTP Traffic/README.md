Q16.[Network+Forensic]HTTP Traffic
---------------------

問題
----
```
100pt

HTTPはWebページを閲覧する時に使われるネットワークプロトコルである。
ここに、とあるWebページを見た時のパケットキャプチャファイルがある。
このファイルから、見ていたページを復元して欲しい。
http_traffic.pcap
```

解き方
-----

http文書を抽出したいのでエクスポートしてみます。

```bash
tshark -r http_traffic.pcap --export-objects 'http,out'
```

outディレクトリに`network(1)`(HTMLファイル)が出現します。

この状態では呼び出すべきjs, css, imgのパスが通っていないので

ディレクトリを作るなりhtmlを編集するなりしてパスを通せば良いです。

FLAG
-----
`cpaw{Y0u_r3st0r3d_7his_p4ge}`

