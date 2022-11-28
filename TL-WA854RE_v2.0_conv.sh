#!/bin/bash

if [ "$1" = "h" ] || [ "$1" = "-h" ] || [ "$1" = "--h" ] || [ "$1" = "help" ] || [ "$1" = "-help" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
  echo " "
  echo "use one input  -> ./TL-WA854RE_v2.0_conv.sh <config.bin>"
  echo "+ out filename -> ./TL-WA854RE_v2.0_conv.sh <config.bin> <config.json>"
  echo " "
  exit
else
  varINP=$1
fi

[ "$(sed '/TL-WA8.*R/!d' "$varINP" | wc -l)" != 0 ] && echo -e '\ndevice OK -> TL-WA8xxxRE ! ;-)\n'
[ "$(sed '/TL-WA8.*R/!d' "$varINP" | wc -l)" != 0 ] || echo -e '\ndevice NOT -> TL-WA8xxxRE ! (exit)\n'
[ "$(sed '/TL-WA8.*R/!d' "$varINP" | wc -l)" != 0 ] || exit

openssl enc -d -des-ecb -nopad -K 478DA50BF9E3D2CF -in "$varINP" > decrypt.bin  # or 478DA50BF9E3D2CB # 478da50bf9e3d2cf8819839d4c061445

#dd bs=1 skip=144 if="$varINP" of=strphdr.bin
# dd bs=1 skip=8323072 if=config.bin of=config1.bin


# ============ v_end: SET BEFORE USE ============
# DELETE BYTE BYNARY -> sed 's/<val>/<val>/g;s/[[:cntrl:]]//g' -i config.json =>> 7
# RAWMODY IN LEAVE DEFAULT BINARY   ->   sed 's/<val>/<val>/g' -i config.json =>> 5
#v_end=7 # CLEAN BINARY
v_end=5 # RAWMODY
dd bs=1 if=decrypt.bin of=hdrvalue.bin count=144
dd bs=1 if=decrypt.bin of=finbyte.bin skip="$(expr $(stat -c '%s' decrypt.bin) - "$v_end")"
#dd bs=1 if=decrypt.bin of=nohdrnofin.bin skip=144 count="$(expr $(stat -c '%s' decrypt.bin) - $(expr 144 + "$v_end"))"
dd bs=1 if=decrypt.bin of=strphdr.bin skip=144 #count="$(expr $(stat -c '%s' decrypt.bin) - $(expr 144 + "$v_end"))"


echo " "
if [ -n "$2" ]; then
  varOUT=$2
  echo "(2 values -> custom out filename: '$varOUT')"
  zlib-flate -uncompress < strphdr.bin > "$varOUT"
else
  echo "(1 value -> default out filename: 'config.json')"
  zlib-flate -uncompress < strphdr.bin > config.json
fi

rm strphdr.bin
rm decrypt.bin
