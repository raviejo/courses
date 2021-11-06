#!/bin/bash

function server () {
  while true
  do
    check=true
    messages=()
    while $check
    do
      read line
      messages+=($line)
      if [[ "${#line}" -eq 1 ]]
      then
        check=false
      fi
    done
    method=${messages[0]}
    path=${messages[1]}
    if [[ $method = "GET" ]]
    then
      if [[ -f ./www$path ]]
      byte_length=$(wc -c < ./www$path)
      then
        echo -ne "HTTP/1.1 200 OK\r\n"
        echo -ne "Content-Type: text/html; charset=utf-8\r\n"
        echo -ne "Content-Length: $byte_length\r\n\r\n"
        cat "./www$path"
      else
        echo -ne "HTTP/1.1 404 Not Found\r\n\r\n"; echo "Content-Length=0"
      fi
    else
      echo -ne "HTTP/1.1 400 Bad Request\r\n\r\n"; echo "Content-Length=0"
    fi
  done
    
}

coproc SERVER_PROCESS { server; }

nc -lkv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}