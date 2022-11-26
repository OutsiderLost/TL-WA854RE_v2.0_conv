#!/bin/bash

### WARNING ### Do not use live! Before that, you need to test it on your OWN router! ###
### (Not header, the output file is incomplete!) ###

if [ "$1" = "h" ] || [ "$1" = "-h" ] || [ "$1" = "--h" ] || [ "$1" = "help" ] || [ "$1" = "-help" ] || [ "$1" = "--help" ] || [ -z "$1" ]; then
  echo " "
  echo "use one input  -> ./enc.sh <config.json>"
  echo "+ out filename -> ./enc.sh <config.json> <encrypt.bin>"
  echo " "
  exit
else
  varINP=$1
fi

zlib-flate -compress < "$varINP" > compress.bin

# ----- CHOOSE METHOD: ----------------------------
cat hdrvalue.bin compress.bin finbyte.bin > backhdr.bin
# cat hdrvalue.bin compress.bin > backhdr.bin # Without final byte back method
# -------------------------------------------------

#dd bs=1 skip=144 if="$varINP" of=strphdr.bin
# dd bs=1 skip=8323072 if=config.bin of=config1.bin

echo " "
if [ -n "$2" ]; then
  varOUT=$2
  echo "(2 values -> custom out filename: '$varOUT')"
  openssl enc -e -des-ecb -nopad -K 478DA50BF9E3D2CF -in backhdr.bin > "$varOUT"  # or 478DA50BF9E3D2CB # 478da50bf9e3d2cf8819839d4c061445
else
  echo "(1 value -> default out filename: 'encrypt.bin')"
  openssl enc -e -des-ecb -nopad -K 478DA50BF9E3D2CF -in backhdr.bin > encrypt.bin  # or 478DA50BF9E3D2CB # 478da50bf9e3d2cf8819839d4c061445
fi

[ -f strphdr.bin ] && rm strphdr.bin
[ -f decrypt.bin ] && rm decrypt.bin
[ -f compress.bin ] && rm compress.bin
#[ -f hdrvalue.bin ] && rm hdrvalue.bin
[ -f finbyte.bin ] && rm finbyte.bin
[ -f backhdr.bin ] && rm backhdr.bin
