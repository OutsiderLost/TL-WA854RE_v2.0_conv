# TL-WA854RE_v2.0_conv
TP-Link TL-WA854RE v2.0 (and other version) config.bin converted to .json readable file.
========================================================================================
(-h, --help)

use one input  -> ./TL-WA854RE_v2.0_conv.sh <config.bin>
+ out filename -> ./TL-WA854RE_v2.0_conv.sh <config.bin> <config.json>

use one input  -> ./enc.sh <config.json>"
+ out filename -> ./enc.sh <config.json> <encrypt.bin>"
---------------------------------------
### WARNING ### Do not use live! Before that, you need to test it on your OWN router! ###

### SET BEFORE USE:
# Editing by cleaning the binaries in the config.json file.  =>> 7 
# Binaries left in place (editing mostly done with command). =>> 5 (default)

=================================
Dependencies install:

echo "Y" | zlib-flate
(or)
apt install qpdf -y

[offline method]

tar -xvzf zlib-flate.tar.gz && chmod +x zlib-flate && sed 's/zlib-flate/.\/zlib-flate/g' -i *.sh
(or)
tar -xvzf zlib-flate.tar.gz -C /usr/bin && chmod +x /usr/bin/zlib-flate

