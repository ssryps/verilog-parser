    .org 0x0
    .global _start
    .set noat
    .set noreorder
    .set nomacro
_start:
    lwpc $2, 0  # $2=0xec480000
    lwpc $3, 0  # $3=0xec680000
    lwpc $4, 0  # $4=0xec880000
    lwpc $5, 0  # $5=0xeca80000
    lwpc $6, 0  # $6=0xecc80000
    lwpc $7, 0  # $7=0xece80000
    lwpc $8, 0  # $8=0xed080000
    lwpc $8, -1  # $8=0xed0fffff
    lwpc $8, -3  # $8=0xed0ffffd
    lwpc $8, -5  # $8=0xed0ffffb
    lwpc $8, -7  # $8=0xed0ffff9
    lwpc $8, -9  # $8=0xed0ffff7
    lwpc $8, -11  # $8=0xed0ffff5