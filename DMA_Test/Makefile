ASM=dgasm

.PHONY: all dma load load_mul bin sim txt

all: dma load load_mul
txt: DMA.txt load.txt load_mul.txt
bin: DMA.bin load.bin load_mul.sim
sim: DMA.sim load.sim load_mul.bin

dma: DMA.txt DMA.sim DMA.bin
DMA.txt:DMA.s
DMA.sim:DMA.s
DMA.bin:DMA.s

load: load.txt load.sim load.bin
load.txt:load.s
load.sim:load.s
load.bin:load.s

load_mul: load_mul.txt load_mul.sim load_mul.bin
load_mul.txt:load_mul.s
load_mul.sim:load_mul.s
load_mul.bin:load_mul.s

%.bin:%.s
	$(ASM) -t eclipse_s140 -f bin -o $@ $^
%.txt:%.s
	$(ASM) -t eclipse_s140 -f eclipse -o $@ $^
%.sim:%.s
	$(ASM) -t eclipse_s140 -f simh -o $@ $^
