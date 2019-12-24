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

