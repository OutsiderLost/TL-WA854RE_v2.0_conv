# TL-WA854RE_v2.0_conv
TP-Link TL-WA854RE v2.0 (and other version) config.bin converted to .json readable file.
========================================================================================
(-h, --help)

use one input  -> ./TL-WA854RE_v2.0_conv.sh <config.bin>
+ out filename -> ./TL-WA854RE_v2.0_conv.sh <config.bin> <config.json>

---------------------------------------
enc.sh !!!
### WARNING ### Do not use live! Before that, you need to test it on your OWN router! ###
### Not header, the output file is incomplete! ###

use one input  -> ./enc.sh <config.json>"
+ out filename -> ./enc.sh <config.json> <encrypt.bin>"

=================================
Dependencies install:

echo "Y" | zlib-flate
(or)
apt install qpdf -y

[or offline method]

tar -xvzf zlib-flate.tar.gz && chmod +x zlib-flate && sed 's/zlib-flate/.\/zlib-flate/g' -i *.sh
(or)
tar -xvzf zlib-flate.tar.gz -C /usr/bin/zlib-flate && chmod +x /usr/bin/zlib-flate

