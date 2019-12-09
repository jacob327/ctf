#!/usr/bin/env python

org = 'fsdz{Fdhvdu_flskhu_lv_fodvvlfdo_flskhu}'

def caesar(inp, shift=0, mode='az'):
    CHARS = 'abcdefghijklmnopqrstuvwxyz' if mode == 'az' else \
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' if mode == 'aZ' else \
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    inp_list = [CHARS.index(c) if c in CHARS else c for c in org]
    return ''.join([CHARS[i + shift] if isinstance(i, int) else i for i in inp_list])

for i in range(32):
    ans = caesar(org, -i, mode='aZ')
    if ans[:4] == 'cpaw':
        print(ans)

