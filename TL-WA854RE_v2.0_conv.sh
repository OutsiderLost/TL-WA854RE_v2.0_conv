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


dd bs=1 skip=144 if="$varINP" of=strphdr.bin
# dd bs=1 skip=8323072 if=config.bin of=config1.bin

openssl enc -d -des-ecb -nopad -K 478DA50BF9E3D2CF -in strphdr.bin > decrypt.bin  # or 478DA50BF9E3D2CB # 478da50bf9e3d2cf8819839d4c061445

echo " "
if [ -n "$2" ]; then
  varOUT=$2
  echo "(2 values -> custom out filename: '$varOUT')"
  zlib-flate -uncompress < decrypt.bin > "$varOUT"
else
  echo "(1 value -> default out filename: 'config.json')"
  zlib-flate -uncompress < decrypt.bin > config.json
fi

rm strphdr.bin
rm decrypt.bin
