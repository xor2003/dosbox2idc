# dosbox2idc

Use dosbox debugger to generate real-time traces to populate IDA with run-time information (segments, full offsets, easier disassembly)
Useful for 16 bit DOS apps.

. Better apply trace filter patch to dosbox debugger
. Run dosbox debuger
. execute "heavylog" and log 100000>, wait, play all possible code branches
. stop dosbox
. execute attached scripts (on LOGCPU.txt)
. fix IDA base inside scripts
. load scripts to IDA
. continue disasm/debug
