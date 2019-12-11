Q23.[Reversing]またやらかした！
-------------------------------

問題
----
```
200pt

またprintf（）をし忘れたプログラムが見つかった。
とある暗号を解くプログラムらしい…
reversing200
```

解き方
------

main関数の中身を見ます。

```bash
$ objdump -M intel -D rev200|awk -v RS= '/^[[:xdigit:]]+ <main>/'
080483ed <main>:
 80483ed:       55                      push   ebp
 80483ee:       89 e5                   mov    ebp,esp
 80483f0:       57                      push   edi
 80483f1:       53                      push   ebx
 80483f2:       83 c4 80                add    esp,0xffffff80
 80483f5:       c7 45 88 7a 00 00 00    mov    DWORD PTR [ebp-0x78],0x7a # ※1 ここから
 80483fc:       c7 45 8c 69 00 00 00    mov    DWORD PTR [ebp-0x74],0x69
 8048403:       c7 45 90 78 00 00 00    mov    DWORD PTR [ebp-0x70],0x78
 804840a:       c7 45 94 6e 00 00 00    mov    DWORD PTR [ebp-0x6c],0x6e
 8048411:       c7 45 98 62 00 00 00    mov    DWORD PTR [ebp-0x68],0x62
 8048418:       c7 45 9c 6f 00 00 00    mov    DWORD PTR [ebp-0x64],0x6f
 804841f:       c7 45 a0 7c 00 00 00    mov    DWORD PTR [ebp-0x60],0x7c
 8048426:       c7 45 a4 6b 00 00 00    mov    DWORD PTR [ebp-0x5c],0x6b
 804842d:       c7 45 a8 77 00 00 00    mov    DWORD PTR [ebp-0x58],0x77
 8048434:       c7 45 ac 78 00 00 00    mov    DWORD PTR [ebp-0x54],0x78
 804843b:       c7 45 b0 74 00 00 00    mov    DWORD PTR [ebp-0x50],0x74
 8048442:       c7 45 b4 38 00 00 00    mov    DWORD PTR [ebp-0x4c],0x38
 8048449:       c7 45 b8 38 00 00 00    mov    DWORD PTR [ebp-0x48],0x38
 8048450:       c7 45 bc 64 00 00 00    mov    DWORD PTR [ebp-0x44],0x64 # ※1 ここまで
 8048457:       c7 45 84 19 00 00 00    mov    DWORD PTR [ebp-0x7c],0x19 # ※2
 804845e:       8d 5d c0                lea    ebx,[ebp-0x40]
 8048461:       b8 00 00 00 00          mov    eax,0x0
 8048466:       ba 0e 00 00 00          mov    edx,0xe
 804846b:       89 df                   mov    edi,ebx
 804846d:       89 d1                   mov    ecx,edx
 804846f:       f3 ab                   rep stos DWORD PTR es:[edi],eax
 8048471:       c7 45 80 00 00 00 00    mov    DWORD PTR [ebp-0x80],0x0
 8048478:       eb 17                   jmp    8048491 <main+0xa4>
 804847a:       8b 45 80                mov    eax,DWORD PTR [ebp-0x80]
 804847d:       8b 44 85 88             mov    eax,DWORD PTR [ebp+eax*4-0x78]
 8048481:       33 45 84                xor    eax,DWORD PTR [ebp-0x7c] # ※3
 8048484:       89 c2                   mov    edx,eax
 8048486:       8b 45 80                mov    eax,DWORD PTR [ebp-0x80]
 8048489:       89 54 85 c0             mov    DWORD PTR [ebp+eax*4-0x40],edx
 804848d:       83 45 80 01             add    DWORD PTR [ebp-0x80],0x1
 8048491:       83 7d 80 0d             cmp    DWORD PTR [ebp-0x80],0xd
 8048495:       7e e3                   jle    804847a <main+0x8d>
 8048497:       b8 00 00 00 00          mov    eax,0x0
 804849c:       83 ec 80                sub    esp,0xffffff80
 804849f:       5b                      pop    ebx
 80484a0:       5f                      pop    edi
 80484a1:       5d                      pop    ebp
 80484a2:       c3                      ret    
 80484a3:       66 90                   xchg   ax,ax
 80484a5:       66 90                   xchg   ax,ax
 80484a7:       66 90                   xchg   ax,ax
 80484a9:       66 90                   xchg   ax,ax
 80484ab:       66 90                   xchg   ax,ax
 80484ad:       66 90                   xchg   ax,ax
 80484af:       90                      nop
```

※1 では`[ebp-0x78]`から`[ebp-0x44]`にそれぞれ代入を行っていて

※3 でそれらの値と※2の値をxorしています。
xorをshellでやるのは難儀なのでPythonに書き出します。

```bash
$ objdump -M intel -D rev200|awk -v RS= '/^[[:xdigit:]]+ <main>/'|grep 'mov.*WORD.*,0x[0-9a-f][0-9a-f]$'|sed -e's/.*,\(.*\)/\1/'
0x7a
0x69
0x78
0x6e
0x62
0x6f
0x7c
0x6b
0x77
0x78
0x74
0x38
0x38
0x64
0x19
$ !! >> solve.py # 「!!」は直前のコマンドの再実行。Pythonファイルにhexの値だけ書き出しておくと編集が楽
```

solve.py を整形して、それぞれの値と0x19のxorをとってasciiにしてやれば良いです。

```python
#!/usr/bin/env python
inp = [ 0x7a, 0x69, 0x78, 0x6e, 0x62, 0x6f, 0x7c, 0x6b, 0x77, 0x78, 0x74, 0x38, 0x38, 0x64, ]
ans = ''.join([ chr(0x19 ^ i) for i in inp])
print(ans)
```

FALG
----
`cpaw{vernam!!}`

