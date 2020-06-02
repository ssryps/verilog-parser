onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bootrom_opt

do {wave.do}

view wave
view structure
view signals

do {bootrom.udo}

run -all

quit -force
