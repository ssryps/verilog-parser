onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib vgamem_opt

do {wave.do}

view wave
view structure
view signals

do {vgamem.udo}

run -all

quit -force
