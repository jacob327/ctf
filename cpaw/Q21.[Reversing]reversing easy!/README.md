Q21.[Reversing]reversing easy!
----------------

問題
----
```
100pt

フラグを出す実行ファイルがあるのだが、プログラム(elfファイル)作成者が出力する関数を書き忘れてしまったらしい…
reverse100
```

解き方
------
まずファイル種別を判別するとLinuxの実行ファイルです。

```bash
$ file rev100
rev100: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.24, BuildID[sha1]=f94360edd84a940de2b74007d4289705601d618d, not stripped
```

実行してみます。

```bash
$ chmod +x rev100 && ./rev100
cpaw{}
```

main関数をダンプしてみます。

```bash
$ objdump -M intel -D ./rev100 | awk -v RS= '/^[[:xdigit:]]+ <main>/'
0804849d <main>:
 804849d:	55                   	push   ebp
 804849e:	89 e5                	mov    ebp,esp
 80484a0:	83 e4 f0             	and    esp,0xfffffff0
 80484a3:	83 ec 50             	sub    esp,0x50
 80484a6:	65 a1 14 00 00 00    	mov    eax,gs:0x14
 80484ac:	89 44 24 4c          	mov    DWORD PTR [esp+0x4c],eax
 80484b0:	31 c0                	xor    eax,eax
 80484b2:	c7 44 24 46 63 70 61 	mov    DWORD PTR [esp+0x46],0x77617063
 80484b9:	77 
 80484ba:	66 c7 44 24 4a 7b 00 	mov    WORD PTR [esp+0x4a],0x7b # ← ここから
 80484c1:	c7 44 24 20 79 00 00 	mov    DWORD PTR [esp+0x20],0x79
 80484c8:	00 
 80484c9:	c7 44 24 24 61 00 00 	mov    DWORD PTR [esp+0x24],0x61
 80484d0:	00 
 80484d1:	c7 44 24 28 6b 00 00 	mov    DWORD PTR [esp+0x28],0x6b
 80484d8:	00 
 80484d9:	c7 44 24 2c 69 00 00 	mov    DWORD PTR [esp+0x2c],0x69
 80484e0:	00 
 80484e1:	c7 44 24 30 6e 00 00 	mov    DWORD PTR [esp+0x30],0x6e
 80484e8:	00 
 80484e9:	c7 44 24 34 69 00 00 	mov    DWORD PTR [esp+0x34],0x69
 80484f0:	00 
 80484f1:	c7 44 24 38 6b 00 00 	mov    DWORD PTR [esp+0x38],0x6b
 80484f8:	00 
 80484f9:	c7 44 24 3c 75 00 00 	mov    DWORD PTR [esp+0x3c],0x75
 8048500:	00 
 8048501:	c7 44 24 40 21 00 00 	mov    DWORD PTR [esp+0x40],0x21
 8048508:	00 
 8048509:	66 c7 44 24 15 7d 0a 	mov    WORD PTR [esp+0x15],0xa7d # ← ここまで
 8048510:	c6 44 24 17 00       	mov    BYTE PTR [esp+0x17],0x0
 8048515:	c7 44 24 1c 05 00 00 	mov    DWORD PTR [esp+0x1c],0x5
 804851c:	00 
 804851d:	8d 44 24 46          	lea    eax,[esp+0x46]
 8048521:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 8048525:	c7 04 24 20 86 04 08 	mov    DWORD PTR [esp],0x8048620
 804852c:	e8 1f fe ff ff       	call   8048350 <printf@plt>
 8048531:	83 7c 24 1c 05       	cmp    DWORD PTR [esp+0x1c],0x5
 8048536:	74 26                	je     804855e <main+0xc1>
 8048538:	c7 44 24 18 00 00 00 	mov    DWORD PTR [esp+0x18],0x0
 804853f:	00 
 8048540:	eb 15                	jmp    8048557 <main+0xba>
 8048542:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
 8048546:	8b 44 84 20          	mov    eax,DWORD PTR [esp+eax*4+0x20]
 804854a:	89 04 24             	mov    DWORD PTR [esp],eax
 804854d:	e8 3e fe ff ff       	call   8048390 <putchar@plt>
 8048552:	83 44 24 18 01       	add    DWORD PTR [esp+0x18],0x1
 8048557:	83 7c 24 18 08       	cmp    DWORD PTR [esp+0x18],0x8
 804855c:	7e e4                	jle    8048542 <main+0xa5>
 804855e:	8d 44 24 15          	lea    eax,[esp+0x15]
 8048562:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 8048566:	c7 04 24 20 86 04 08 	mov    DWORD PTR [esp],0x8048620
 804856d:	e8 de fd ff ff       	call   8048350 <printf@plt>
 8048572:	b8 00 00 00 00       	mov    eax,0x0
 8048577:	8b 54 24 4c          	mov    edx,DWORD PTR [esp+0x4c]
 804857b:	65 33 15 14 00 00 00 	xor    edx,DWORD PTR gs:0x14
 8048582:	74 05                	je     8048589 <main+0xec>
 8048584:	e8 d7 fd ff ff       	call   8048360 <__stack_chk_fail@plt>
 8048589:	c9                   	leave  
 804858a:	c3                   	ret    
 804858b:	66 90                	xchg   ax,ax
 804858d:	66 90                	xchg   ax,ax
 804858f:	90                   	nop
```

「ここから」「ここまで」で代入を行っているので抽出します。

```bash
$ objdump -M intel -D rev100|awk -v RS= '/^[[:xdigit:]]+ <main>/'|grep 'mov.*WORD.*,0x[0-9a-f][0-9a-f]$'
 80484ba:       66 c7 44 24 4a 7b 00    mov    WORD PTR [esp+0x4a],0x7b
 80484c1:       c7 44 24 20 79 00 00    mov    DWORD PTR [esp+0x20],0x79
 80484c9:       c7 44 24 24 61 00 00    mov    DWORD PTR [esp+0x24],0x61
 80484d1:       c7 44 24 28 6b 00 00    mov    DWORD PTR [esp+0x28],0x6b
 80484d9:       c7 44 24 2c 69 00 00    mov    DWORD PTR [esp+0x2c],0x69
 80484e1:       c7 44 24 30 6e 00 00    mov    DWORD PTR [esp+0x30],0x6e
 80484e9:       c7 44 24 34 69 00 00    mov    DWORD PTR [esp+0x34],0x69
 80484f1:       c7 44 24 38 6b 00 00    mov    DWORD PTR [esp+0x38],0x6b
 80484f9:       c7 44 24 3c 75 00 00    mov    DWORD PTR [esp+0x3c],0x75
 8048501:       c7 44 24 40 21 00 00    mov    DWORD PTR [esp+0x40],0x21
```

値を抽出してasciiに変換します。

```bash
$ objdump -M intel -D rev100| awk -v RS= '/^[[:xdigit:]]+ <main>/'|grep 'mov.*WORD.*,0x[0-9a-f][0-9a-f]$'|sed -e's/.*,\(.*\)/\1/g'
0x7b
0x79
0x61
0x6b
0x69
0x6e
0x69
0x6b
0x75
0x21
```

hexをasciiに変換します。

```bash
$ objdump -M intel -D rev100| awk -v RS= '/^[[:xdigit:]]+ <main>/'|grep 'mov.*WORD.*,0x[0-9a-f][0-9a-f]$'|sed -e's/.*,\(.*\)/\1/g'|xxd -r
{yakiniku!
```

FALG
----
`cpaw{yakiniku!}`

