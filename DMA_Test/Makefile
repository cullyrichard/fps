
.PHONY: monitor dma load

monitor: monitor.txt monitor.sim
monitor.txt: monitor.s
monitor.sim: monitor.s

dma: DMA.txt DMA.sim
DMA.txt:DMA.s
DMA.sim:DMA.s

load: load.txt load.sim
load.txt:load.s
load.sim:load.s

%.txt:%.s
	../dgasm/dgasm -t eclipse_s140 -f eclipse -o $@ $^
%.sim:%.s
	../dgasm/dgasm -t eclipse_s140 -f simh -o $@ $^
