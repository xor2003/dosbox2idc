#!/bin/sh
S="0x31"
echo "#include <idc.idc>" > _word.idc
echo "static main(){" >> _word.idc
grep -F "]=" LOGCPU.TXT | grep "s:\[" | grep -v "ss:\[" | grep -wv -Pe "lds|les|lgs|lfs" |grep -Pe " word |[abcd]x,|bp,|si,|di,|sp,|cs,|ds,|es,|fs,|gs,|,[abcd]x|,bp|,si|,di|,sp|,cs|,ds|,es|,fs|,gs" | \
  perl -pe 's!^([0-9A-F]+):[0-9A-F]+.*cs:\[([0-9A-F]+)\].*!MakeWord((0x$1+'$S')*0x10+0x$2);!g; s!.*ds:\[([0-9A-F]+)\].*DS:([0-9A-F]+).*!MakeWord((0x$2+'$S')*0x10+0x$1);!g; s!.*es:\[([0-9A-F]+)\].*ES:([0-9A-F]+).*!MakeWord((0x$2+'$S')*0x10+0x$1);!g; s!.*fs:\[([0-9A-F]+)\].*FS:([0-9A-F]+).*!MakeWord((0x$2+'$S')*0x10+0x$1);!g; s!.*gs:\[([0-9A-F]+)\].*GS:([0-9A-F]+).*!MakeWord((0x$2+'$S')*0x10+0x$1);!g'   >> _word.idc
echo "}" >> _word.idc
