#!/bin/sh
S="0x31"
echo "#include <idc.idc>" > _dword.idc
echo "static main(){" >> _dword.idc
grep -F "]=" LOGCPU.TXT | grep "s:\[" | grep -v "ss:\[" |grep -Pe " dword |e[abcd]x,|ebp,|esi,|edi,|esp,|,e[abcd]x|,ebp|,esi|,edi|,esp|lds|les|lgs|lfs" | \
  perl -pe 's!^([0-9A-F]+):[0-9A-F]+.*cs:\[([0-9A-F]+)\].*!MakeDword((0x$1+'$S')*0x10+0x$2);!g; s!.*ds:\[([0-9A-F]+)\].*DS:([0-9A-F]+).*!MakeDword((0x$2+'$S')*0x10+0x$1);!g; s!.*es:\[([0-9A-F]+)\].*ES:([0-9A-F]+).*!MakeDword((0x$2+'$S')*0x10+0x$1);!g; s!.*fs:\[([0-9A-F]+)\].*FS:([0-9A-F]+).*!MakeDword((0x$2+'$S')*0x10+0x$1);!g; s!.*gs:\[([0-9A-F]+)\].*GS:([0-9A-F]+).*!MakeDword((0x$2+'$S')*0x10+0x$1);!g'   >> _dword.idc
echo "}" >> _dword.idc
