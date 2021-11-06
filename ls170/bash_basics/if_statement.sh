#!/bin/bash

echo output a string \if it is longer than 0
echo

string=Hello

if [[ -n $string ]]
then
  echo $string
fi

echo Compare two integers and output a string \if they\'re equal
echo

integer_1=10
integer_2=10

if [[ $integer_1 -eq $integer_2 ]]
then
  echo $integer_1 and $integer_2 are the same!
fi

echo Output \File Exists\ \if the file \`hello_world.sh\` exists.
echo

if [[ -e ./hello_world.sh ]]
then 
  echo File exists
fi

echo nested if statements
echo

integer=4
if [[ $integer -lt 10 ]]
then 
  echo $integer is less than 10

  if [[ $integer -lt 5 ]]
  then
    echo $integer is also less than 5
  fi
fi

echo two conditional branches with an \if \else
echo

integer=15
if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
else
  echo $integer is not less than 10
fi

echo three conditional branches with \if \elif and \else
echo

if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
elif [[ $integer -gt 20 ]]
then 
  echo $integer is greater than 20
else
  echo $integer is between 10 and 20
fi

echo matching two conditions using \&\&
echo

if [[ $integer -gt 10 ]] && [[ $integer -lt 20 ]]
then
  echo $integer is between 10 and 20
fi

echo matching one of two conditions using \|\|

integer=12

if [ $integer -lt 5 ] || [ $integer -gt 10 ]
then
  echo $integer is less than 5 or greater than 10.
fi

integer=8

if ! ([ $integer -lt 5 ] || [ $integer -gt 10 ] )
then
  echo $integer is between 5 and 10
fi