#!/bin/sh

base=0x31
echo "#include <idc.idc>" > _segs.idc
echo "static main(){" >> _segs.idc

grep -Pve '^F000:' LOGCPU.TXT | \
perl -pe 's!^([0-9A-F]+):([0-9A-F]+) .* DS:([0-9A-F]+) ES:([0-9A-F]+) FS:([0-9A-F]+) GS:([0-9A-F]+).*!SetRegEx((0x$1+'${base}')*0x10+0x$2,\"DS\",0x$3+'${base}',SR_user);\nSetRegEx((0x$1+'${base}')*0x10+0x$2,\"ES\",0x$4+'${base}',SR_user);\nSetRegEx((0x$1+'${base}')*0x10+0x$2,\"FS\",0x$5+'${base}',SR_user);\nSetRegEx((0x$1+'${base}')*0x10+0x$2,\"GS\",0x$6+'${base}',SR_user);\n!' >> _segs.idc

echo "}" >> _segs.idc

