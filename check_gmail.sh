#!/bin/bash

## EXIT CODE 0, SHOW CODE 1; EMAIL VAILD.
## EXIT CODE 1, SHOW CODE 0; EMAIL INVAILD.

EMAIL="$1";

EXIT0(){
  echo "1";
  exit 0;
}

EXIT1(){
  echo "0";
  exit 1;
}

EMAIL="$(echo "$EMAIL" |sed 's/\ //g')";
if [ -z "$EMAIL" ]; then
  EXIT1;
fi

RESPOND="$(curl -sS -I "https://mail.google.com/mail/gxlu?email=$EMAIL")";

if [ -n "$RESPOND" ]; then
  echo "$RESPOND" |grep -q 'Set-Cookie:';
  if [ $? == '0' ]; then
    EXIT0;
  else
    EXIT1;
  fi
else
  EXIT1;
fi

 