#!/bin/bash

#array=( $(eval echo $(cat words_2ch.txt)) )
#array=( $(cat words_2ch.txt) )

#for e in "${array[@]}"; do
#  echo "#exp(/^$e /i) |" >> compiled.txt
#  echo "#exp(/ $e /i) |" >> compiled.txt
#  echo "#exp(/ $e$/i) |" >> compiled.txt
#done
######rm compiled_final.txt

#while read -r char; do
#  echo "#exp(/^$char[,.?!]? /im) |" >> compiled.txt
#  echo "#exp(/ $char[,.?!]? /im) |" >> compiled.txt
#  echo "#exp(/ $char[,.?!]?$/im) |" >> compiled.txt
#done < words_2ch.txt

# shellcheck disable=SC1087
compile() {
while read -r char; do
   {
    echo "#exp(/^$char[,.?!]? /im) |"
    echo "#exp(/ $char[,.?!]? /im) |"
    echo "#exp(/ $char[,.?!]?$/im) |"
    echo "#exp(/^$char[,.?!]?$/im) |"
   } >> compiled.txt
  done < "words_${1}.txt"

  cat "other_${1}.txt" >> compiled.txt
  head -c-2 > compiled_final.txt < compiled.txt
  rm compiled.txt
  xsel -ib < compiled_final.txt
}
# shellcheck disable=SC1087
compile1() {
  #local rules
  if [[ -e "words_${1}.txt" ]]; then

    while read -r char; do
     {
      echo "#exp(/^$char[,.?!]? /im) |"
      echo "#exp(/ $char[,.?!]? /im) |"
      echo "#exp(/ $char[,.?!]?$/im) |"
      echo "#exp(/^$char[,.?!]?$/im) |"
     } >> compiled.txt
    done < "words_${1}.txt"
  fi
  cat "other_${1}.txt" compiled.txt | head -c-2 | xsel -ib
  rm compiled.txt
}

compile1 "${1}"
