#!/bin/sh

stalks=0
hexagram=""

random () {
  limit=${1-255}
  r=$(od -An -N1 -i /dev/random | tr -d '[:space:]')
  printf "%s" "$((r % limit))"
}

pause () {
  printf "\n[press a key]"
  old_stty_cfg=$(stty -g)
  stty raw -echo
  while ! head -c 1; do true; done
  stty "$old_stty_cfg"
}

phase1 () {
  acc1=0
  stalks=$((stalks - 1))
  pause
  l=$(random $stalks)
  r=$((stalks - l))
  ml1=$((l % 4))
  if [ $ml1 -eq 0 ]; then
    ml1=4
  fi
  mr1=$((r % 4))
  if [ $mr1 -eq 0 ]; then
    mr1=4
  fi
  stalks=$((stalks - ml1))
  stalks=$((stalks - mr1))
  acc1=$((acc1 + ml1))
  acc1=$((acc1 + mr1))
  if [ $acc1 -eq 4 ]; then
    points=$((points + 2))
  else
    points=$((points + 3))
  fi
}

phase2 () {
  acc2=1
  stalks=$((stalks - 1))
  pause
  l=$(random $stalks)
  r=$((stalks - l))
  ml2=$((l % 4))
  if [ $ml2 -eq 0 ]; then
    ml2=4
  fi
  mr2=$((r % 4))
  if [ $mr2 -eq 0 ]; then
    mr2=4
  fi
  stalks=$((stalks - ml2))
  stalks=$((stalks - mr2))
  acc2=$((acc2 + ml2))
  acc2=$((acc2 + mr2))
  if [ $acc2 -eq 4 ]; then
    points=$((points + 2))
  else
    points=$((points + 3))
  fi
}

phase3 () {
  acc3=1
  stalks=$((stalks - 1))
  pause
  l=$(random $stalks)
  r=$((stalks - l))
  ml3=$((l % 4))
  if [ $ml3 -eq 0 ]; then
    ml3=4
  fi
  mr3=$((r % 4))
  if [ $mr3 -eq 0 ]; then
    mr3=4
  fi
  stalks=$((stalks - ml3))
  stalks=$((stalks - mr3))
  acc3=$((acc3 + ml3))
  acc3=$((acc3 + mr3))
  if [ $acc3 -eq 4 ]; then
    points=$((points + 2))
  else
    points=$((points + 3))
  fi
}

phase4 () {
  case $points in
    6)
      hexagram='━━━━━━━━━   ━━━   ━━━\n'"$hexagram"
      return
      ;;
    7)
      hexagram='━━━   ━━━   ━━━   ━━━\n'"$hexagram"
      return
      ;;
    8)
      hexagram='━━━━━━━━━   ━━━━━━━━━\n'"$hexagram"
      return
      ;;
    9)
      hexagram='━━━   ━━━   ━━━━━━━━━\n'"$hexagram"
      return
      ;;
  esac
}

getdigram () {
  printf "moo"
}

printf "Your mind on the question to be posed to the oracle.\n"
i=6
while [ $i -gt 0 ];
do 
  stalks=50
  points=0
  stalks=$((stalks - 1))
  printf "\nGenerating hexagrams line %s" "$(( 7 - i))"
  phase1
  phase2
  phase3
  phase4
  printf "\n\n"
  i=$((i-1))
done

echo "$hexagram"
