Q9.[Web] HTML Page
----------------------

問題
----
```
10pt

HTML(Hyper Text Markup Language)は、Webサイトを記述するための言語です。
ページに表示されている部分以外にも、ページをより良くみせるためのデータが含まれています。
次のWebサイトからフラグを探して下さい。
http://q9.ctf.cpaw.site

※この問題のサーバへの攻撃はお止めください。
```

解き方
-----

ソース中にflagが含まれています。

```bash
$ curl -Ss http://q9.ctf.cpaw.site/ | grep cpaw | sed -e 's/^.*\(cpaw{.*}\).*$/\1/'
```

ブラウザから探す場合は「開発者ツール」とか「ソースを見る」でも見つかります。

FLAG
-----
`cpaw{9216ddf84851f15a46662eb04759d2bebacac666}`

