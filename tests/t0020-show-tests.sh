#!/usr/bin/env bash

test_description='Test show'
cd "$(dirname "$0")"
. ./setup.sh

test_expect_success 'Test "show" command' '
	"$PASS" init $KEY1 &&
	"$PASS" generate cred1 20 &&
	"$PASS" show cred1
'

test_expect_success 'Test "show" command with spaces' '
	"$PASS" insert -e "I am a cred with lots of spaces"<<<"BLAH!!" &&
	[[ $("$PASS" show "I am a cred with lots of spaces") == "BLAH!!" ]]
'

test_expect_success 'Test "show" of nonexistant password' '
	test_must_fail "$PASS" show cred2
'

test_expect_success 'Test "show" command with simple tree' '
	"$PASS" insert -e tree/of/creds1 <<<"blah" &&
	"$PASS" insert -e tree/of/creds2 <<<"blah" &&
	[[ $("$PASS" show | grep "tree.of" | wc -l | sed "s/ *//g") == "2" ]] &&
	"$PASS" rm tree/of/creds1 &&
	"$PASS" rm tree/of/creds2
'

test_done
