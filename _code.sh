#!/bin/sh
S="0x31"
echo "#include <idc.idc>" > _code.idc
echo "static main(){" >> _code.idc
grep -vF "F000:" LOGCPU.txt | perl -pe 's!^([0-9A-F]+):([0-9A-F]+).*!MakeCode((0x$1+'$S')*0x10+0x$2);!g' >> _code.idc
echo "}" >> _code.idc
