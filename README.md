# dosbox2idc

Use dosbox debugger to generate real-time traces to populate IDA with run-time information (segments, full offsets, easier disassembly)
Useful for 16 bit DOS apps.

1. Better apply trace filter patch to dosbox debugger
2. Run dosbox debuger
3. execute "heavylog" and log 100000>, wait, play all possible code branches
4. stop dosbox
5. execute attached scripts (on LOGCPU.txt)
6. fix IDA base inside scripts
7. load scripts to IDA
8. continue disasm/debug
