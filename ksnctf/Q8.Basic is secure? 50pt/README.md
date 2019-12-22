Q8.Basic is secure? 50pt
------------------------

問題
----
> http://ksnctf.sweetduet.info/q/8/q8.pcap

解き方
-----

pcap問題ですね。

wiresharkしても良いですが、この程度の量ならstringsして様子を見るのもありです。

```bash
$ wget http://ksnctf.sweetduet.info/q/8/q8.pcap
$ strings q8.pcap
)7j3
4j{@
)7j3
4j|@
'`R,
)7j3
)7j3
(j}@
)7j3
)7j3
(j~@
'`R,
)7j3
GET /~q8/ HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3
)7j3
gW~P
)7j3
gW~P
HTTP/1.1 401 Authorization Required
Date: Sat, 26 May 2012 20:54:01 GMT
Server: Apache/2.2.15 (CentOS)
WWW-Authenticate: Basic realm="Secret"
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
)7j3
gW~P
)7j3
gW~rhG
)7j3
gW~rhG
)7j3
'`R,
GET /~q8/ HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
Authorization: Basic cTg6RkxBR181dXg3eksyTktTSDhmU0dB # ここ
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3
)7j3
)7j3
)7j3
HTTP/1.1 200 OK
Date: Sat, 26 May 2012 20:54:05 GMT
Server: Apache/2.2.15 (CentOS)
Last-Modified: Sat, 26 May 2012 12:24:46 GMT
ETag: "422da-b8-4c0ef920b3f8e"
Accept-Ranges: bytes
Content-Length: 184
Connection: close
Content-Type: text/html; charset=UTF-8
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Q8</title>
  </head>
  <body>
    <p>Congratulations!</p>
    <p>The flag is q8's password.</p>
  </body>
</html>
)7j3
'`R,
)7j3
TvR,
)7j3
'`R,
)7j3
TwR,
)7j3
'`JG
)7j3
N#JG
)7j3
'`JG
)7j3
'`JG
GET /favicon.ico HTTP/1.1
Host: ctfq.sweetduet.info:10080
Connection: keep-alive
Accept: */*
User-Agent: Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19
Accept-Encoding: gzip,deflate,sdch
Accept-Language: ja,en-US;q=0.8,en;q=0.6
Accept-Charset: Shift_JIS,utf-8;q=0.7,*;q=0.3
)7j3
N$JG
)7j3
N$JG
HTTP/1.1 404 Not Found
Date: Sat, 26 May 2012 20:54:05 GMT
Server: Apache/2.2.15 (CentOS)
Content-Length: 297
Connection: close
Content-Type: text/html; charset=iso-8859-1
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL /favicon.ico was not found on this server.</p>
<hr>
<address>Apache/2.2.15 (CentOS) Server at ctfq.sweetduet.info Port 10080</address>
</body></html>
)7j3
'`JG
)7j3
)7j3
)7j3
'`JG
```

問題文からもBasic認証と分かるので`cTg6RkxBR181dXg3eksyTktTSDhmU0dB`をデコードすれば良いです。

```bash
$ echo -n 'cTg6RkxBR181dXg3eksyTktTSDhmU0dB'|base64 -d
q8:FLAG_5ux7zK2NKSH8fSGA
```

FLAG
-----
`FLAG_5ux7zK2NKSH8fSGA`

