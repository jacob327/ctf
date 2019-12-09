Q8.[Misc] Can you open this file ?
----------------------

問題
----
```
10pt

このファイルを開きたいが拡張子がないので、どのような種類のファイルで、どのアプリケーションで開けば良いかわからない。
どうにかして、この拡張子がないこのファイルの種類を特定し、どのアプリケーションで開くか調べてくれ。
問題ファイル： open_me
```

解き方
-----
ファイルの種類を判別して実行すれば良いです。

ファイルの判別は`file`コマンドを使います。

```bash
$ file open_me
open_me: Composite Document File V2 Document, Little Endian, Os: Windows, Version 10.0, Code page: 932, Author: v, Template: Normal.dotm, Last Saved By: v, Revision Number: 1, Name of Creating Application: Microsoft Office Word, Total Editing Time: 28:00, Create Time/Date: Mon Oct 12 04:27:00 2015, Last Saved Time/Date: Mon Oct 12 04:55:00 2015, Number of Pages: 1, Number of Words: 3, Number of Characters: 23, Security: 0
```

Document ファイルなのでWordとかで開けば良いです。 Linux環境のフリーソフトだとLibreofficeとかでも開けます。

```bash
$ libreoffice open_me
```

開くとleetcodeな画像が見えるので文字を書き写せば良いです(画像なのでコピペはできません)。

FLAG
-----
`cpaw{Th1s_f1le_c0uld_be_0p3n3d}`

