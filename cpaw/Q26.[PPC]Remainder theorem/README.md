Q26.[PPC]Remainder theorem
----------------------

問題
----
```
200pt

x ≡ 32134 (mod 1584891)
x ≡ 193127 (mod 3438478)

x = ?


フラグはcpaw{xの値}です！
```

解き方
-----

xは以下を満たす数です。
 - あるn1に対して`1584891 * n1 + 32134`
 - あるn2に対して`3438478 * n2 + 193127`

n2をループさせてn1が見つければ良いです。

```python
#!/usr/bin/env python3

# x = p1 * n1 + q1
# x = p2 * n2 + q2

p1 = 1584891
p2 = 3438478
q1 = 32134
q2 = 193127
ans = 0
for n in range(p2):
    x = p2 * n + q2
    if x % p1 == q1:
        ans = x
        break
print(ans)
```

FLAG
-----
`cpaw{35430270439}`
