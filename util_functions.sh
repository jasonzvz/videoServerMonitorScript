#!/bin/bash

#Usage: SendMail subject recepients content
function SendMail
{
Whole_Mail="Subject:$1
To: $2
$3"
echo "$Whole_Mail" | /usr/sbin/sendmail -t
}
