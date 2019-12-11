Q28.[Network] Can you login？
----------------

問題
----
```
100pt

古くから存在するネットワークプロトコルを使った通信では、セキュリティを意識していなかったこともあり、様々な情報が暗号化されていないことが多い。そのため、パケットキャプチャをすることでその情報が簡単に見られてしまう可能性がある。
次のパケットを読んで、FLAGを探せ！
network100.pcap
```

解き方
------

とりあえずstringsしてみる
```bash
$ strings network100.pcap
cpaw
site
cpaw
site
host1
cpaw
site
IV]Z
@W=N
220 Welcome to Cpaw CTF FTP service. # FTP接続
USER anonymous
IVoS
IV(\
331 Please specify the password.
IVs\
PASS anoymous
530 Login incorrect.
FQUIT
s221 Goodbye.
220 Welcome to Cpaw CTF FTP service.
4i=@
IVB:
USER cpaw_user # user
IVgw
IVnz
+[331 Please specify the password.
DPASS 5f4dcc3b5aa765d61d8327deb882cf99 # password
IVIR
230 Login successful.
SYST
215 UNIX Type: L8
:h+@
FEAT
211-Features:
 EPRT
 EPSV
@E\~
 MDTM
 PASV
 REST STREAM
 SIZE
 TVFS
@D\x
@C\r
@A\f
@@\`
@?\Z
 UTF8
211 End
4X(@
@?\S
@=\L
257 "/"
@<\ 
EPSV
229 Entering Extended Passive Mode (|||60012|).
@6,c
lO$_e
O$_f
IVvG
lO$_f
LIST
150 Here comes the directory listing.
IV]x
O$_f
-rw-r--r--    1 0        0              36 Nov 16 14:12 dummy
lO$_f
6O$_f
4I:@
lO$_f
lO$_f
226 Directory send OK.
7O$_g
@.B'
TYPE I
200 Switching to Binary mode.
4~&@
@*><
SIZE dummy
213 36
@)VK
EPSV
229 Entering Extended Passive Mode (|||60009|).
RETR dummy
150 Opening BINARY mode data connection for dummy (36 bytes).
FLAG file exists in this directory.
@W@}
@R@G
@R@F
226 Transfer complete.
@m      @
`%MDTM dummy
2213 20151116141244
`4QUIT
221 Goodbye.
IVlA
```

FTPで(username, password) = (cpaw_user, 5f4dcc3b5aa765d61d8327deb882cf99) でログインしている。

宛先が分からないのでwiresharkで開いてみる。

```bash
wireshark network100.pcap
```

`192.168.x.x`は自アドレスなので`157.7.52.186`が宛先アドレスと分かる。

ftpソフトでログインすれば良い。

```bash
$ lftp 157.7.52.186 -ucpaw_user,5f4dcc3b5aa765d61d8327deb882cf99
lftp cpaw_user@157.7.52.186:~> ls
-rw-r--r--    1 ftp      ftp            36 Sep 01  2017 dummy
lftp cpaw_user@157.7.52.186:/> cat dummy 
FLAG file exists in this directory.     
36 bytes transferred
lftp cpaw_user@157.7.52.186:/> ls -a
drwxr-xr-x    2 ftp      ftp            42 Jun 18 00:25 .
drwxr-xr-x    2 ftp      ftp            42 Jun 18 00:25 ..
-rw-r--r--    1 ftp      ftp            39 Sep 01  2017 .hidden_flag_file
-rw-r--r--    1 ftp      ftp            36 Sep 01  2017 dummy
lftp cpaw_user@157.7.52.186:/> cat .hidden_flag_file
cpaw{f4p_sh0u1d_b3_us3d_in_3ncryp4i0n}
39 bytes transferred
lftp cpaw_user@157.7.52.186:/> exit
```

FALG
----
`cpaw{f4p_sh0u1d_b3_us3d_in_3ncryp4i0n}`
