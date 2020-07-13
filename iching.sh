#!/bin/sh

stalks=0
hexagram=""
hex1=0
hex2=0
bin2gram="2,24,7,19,15,36,46,11,16,51,40,54,62,55,32,34,8,3,29,60,39,63,48,5,45,17,47,58,31,49,28,43,23,27,4,41,52,22,18,26,35,21,64,38,56,30,50,14,20,42,59,61,53,37,57,9,12,25,6,10,33,13,44,1"

gethex () {
  printf "%s" "$bin2gram" | awk -F "," -v col="$1" '{print $col}'
}

random () {
  limit=${1-255}
  r=$(od -An -N1 -i /dev/random | tr -d '[:space:]')
  printf "%s" "$((r % limit))"
}

pause () {
  printf "%s" "${1:-}"
  (tty_state=$(stty -g)
  stty -icanon
  LC_ALL=C dd bs=1 count=1 >/dev/null 2>&1
  stty "$tty_state"
  ) </dev/tty
}

phase1 () {
  acc1=0
  stalks=$((stalks - 1))
  pause "..."
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
  pause "..."
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
  pause "..."
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
  # build output picture and bitarray of hexagrams
  pow=$(echo "2 ^ $((6 - i))" | bc)
  case $points in
    6)
      hexagram='━━━━━━━━━   ━━━   ━━━\n'"$hexagram"
      hex1=$((hex1 + (1 * pow)))
      hex2=$((hex2 + (0 * pow)))
      return
      ;;
    7)
      hexagram='━━━   ━━━   ━━━   ━━━\n'"$hexagram"
      hex1=$((hex1 + (0 * pow)))
      hex2=$((hex2 + (0 * pow)))
      return
      ;;
    8)
      hexagram='━━━━━━━━━   ━━━━━━━━━\n'"$hexagram"
      hex1=$((hex1 + (1 * pow)))
      hex2=$((hex2 + (1 * pow)))
      return
      ;;
    9)
      hexagram='━━━   ━━━   ━━━━━━━━━\n'"$hexagram"
      hex1=$((hex1 + (0 * pow)))
      hex2=$((hex2 + (1 * pow)))
      return
      ;;
  esac
}

getdigram () {
  printf "moo"
}

# Main block
printf ""
cat << END
 ___    ____ _   _ ___ _   _  ____ 
|_ _|  / ___| | | |_ _| \ | |/ ___|
 | |  | |   | |_| || ||  \| | |  _ 
 | |  | |___|  _  || || |\  | |_| |
|___|  \____|_| |_|___|_| \_|\____|

Focus your mind on the question to be posed to the oracle.
Each line of the hexagram and changed hexagram will be generated in sequence.

 - You should not ask same question many times
 - Do not ask petty questions
 - Do not ask if it could cause harm to others

END

pause "You will be prompted to continue 18 times. Press any key to begin..."

i=6
while [ $i -gt 0 ];
do 
  stalks=50
  points=0
  stalks=$((stalks - 1))
  printf "\nBuilding line %s" "$(( 7 - i))"
  phase1
  phase2
  phase3
  phase4
  i=$((i-1))
done

printf "\n\n"
echo "$hexagram"
printf "Hexagram: https://divination.com/iching/lookup/%s-2/\n" "$(gethex $((hex1 + 1)))"
printf "Changing: https://divination.com/iching/lookup/%s-2\n" "$(gethex $((hex2 + 1)))"
