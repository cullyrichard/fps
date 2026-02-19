SOURCE ?= $(wildcard *.asm)         #overidable source
INCLUDES ?= lib/FPS_lib.asm         #overitable includes
DGASM = ../dgnsdk/dgnasm_old/dgnasm

.PHONY: txt bin all clean           #list fileless make entry

txt: $(SOURCE:.asm=.txt)
bin: $(SOURCE:.asm=.bin)
all: txt bin

%.txt : %.asm $(INCLUDES)
	$(DGASM) -mv $^ 
	mv a.out $@

%.bin : %.asm $(INCLUDES)
	$(DGASM) -ma $^
	mv a.out $@

clean:
	rm $(SOURCE:.asm=.txt) $(SOURCE:.asm=.bin)
