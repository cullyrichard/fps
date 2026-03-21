ASM=dgasm

.PHONY: all dma load bin sim txt

all: dma load
txt: DMA.txt load.txt
bin: DMA.bin load.bin
sim: DMA.sim load.sim

dma: DMA.txt DMA.sim DMA.bin
DMA.txt:DMA.s
DMA.sim:DMA.s
DMA.bin:DMA.s

load: load.txt load.sim load.bin
load.txt:load.s
load.sim:load.s
load.bin:load.s

%.bin:%.s
	$(ASM) -t eclipse_s140 -f bin -o $@ $^
%.txt:%.s
	$(ASM) -t eclipse_s140 -f eclipse -o $@ $^
%.sim:%.s
	$(ASM) -t eclipse_s140 -f simh -o $@ $^
