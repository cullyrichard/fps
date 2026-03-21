ASM=dgasm

.PHONY: all dma load

all: dma load

dma: DMA.txt DMA.sim
DMA.txt:DMA.s
DMA.sim:DMA.s

load: load.txt load.sim
load.txt:load.s
load.sim:load.s

%.txt:%.s
	$(ASM) -t eclipse_s140 -f eclipse -o $@ $^
%.sim:%.s
	$(ASM) -t eclipse_s140 -f simh -o $@ $^
