#!/bin/sh

S="0x31"
echo "#include <idc.idc>" > _offs.idc
echo "static main(){" >> _offs.idc

grep "call\|jmp" LOGCPU.TXT | grep "near word"| grep -F "]=" | grep "s:\[" | grep -v "ss:\[" | \
  perl -pe 's!^([0-9A-F]+):[0-9A-F]+.*cs:\[([0-9A-F]+)\].*!MakeWord((0x$1+'$S')*0x10+0x$2);\nOpOffEx((0x$1+'$S')*0x10+0x$2,0,1,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*ds:\[([0-9A-F]+)\].*DS:([0-9A-F]+).*!MakeWord((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,1,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*es:\[([0-9A-F]+)\].*ES:([0-9A-F]+).*!MakeWord((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,1,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*fs:\[([0-9A-F]+)\].*FS:([0-9A-F]+).*!MakeWord((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,1,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*gs:\[([0-9A-F]+)\].*GS:([0-9A-F]+).*!MakeWord((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,1,-1,(0x$1+'$S')*0x10,0);!g' |uniq | sort| uniq  >> _offs.idc

grep "call\|jmp" LOGCPU.TXT | grep "far word"| grep -F "]=" | grep "s:\[" | grep -v "ss:\[" | \
  perl -pe 's!^([0-9A-F]+):[0-9A-F]+.*cs:\[([0-9A-F]+)\].*!MakeDword((0x$1+'$S')*0x10+0x$2);\nOpOffEx((0x$1+'$S')*0x10+0x$2,0,2,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*ds:\[([0-9A-F]+)\].*DS:([0-9A-F]+).*!MakeDword((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,2,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*es:\[([0-9A-F]+)\].*ES:([0-9A-F]+).*!MakeDword((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,2,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*fs:\[([0-9A-F]+)\].*FS:([0-9A-F]+).*!MakeDword((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,2,-1,(0x$1+'$S')*0x10,0);!g; s!^([0-9A-F]+):.*gs:\[([0-9A-F]+)\].*GS:([0-9A-F]+).*!MakeDword((0x$3+'$S')*0x10+0x$2);\nOpOffEx((0x$3+'$S')*0x10+0x$2,0,2,-1,(0x$1+'$S')*0x10,0);!g' |uniq | sort| uniq  >> _offs.idc

echo "}" >> _offs.idc


