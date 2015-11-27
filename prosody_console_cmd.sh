#!/usr/bin/expect
set timeout 20
spawn telnet localhost 5582
expect ""
send "c2s:show()\r"
expect ""
send "bye\r"
interact
