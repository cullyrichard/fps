	;; DEFINES SECTION
	#define FPU 054

	#define FN_STOP		0100000
	#define FN_START 	0040000
	#define FN_CONT		0020000
	#define FN_STEP		0010000
	#define FN_RESET	0004000
	#define FN_EXAM		0002000
	#define FN_DEP		0001000
	#define FN_BREAK	0000400

	#define FN_INC3		0000300
	#define FN_INC2		0000200
	#define FN_INC1		0000100
	#define FN_NOINC	0000000

	#define FN_OFFS3	0000060
	#define FN_OFFS2	0000040
	#define FN_OFFS1	0000020
	#define FN_OFFS0	0000000

	#define FN_REGPS	0000000
	#define FN_REGMA	0000002
	#define FN_REGTMA	0000003
	#define FN_REGMD	0000005

	#define CMD_WTSR	0021031
	#define CMD_WTFN	0022031
	#define CMD_RDFN	0022030
	#define CMD_LTRD	0023030

	JMP reset

	;; DATA SECTION
results_addr:		0000100
load_addr:		0000200
program_ptr:		program
program_end_ptr:	program_end
stop_bit:		FN_STOP

program:
	000003
	102000
	002000
	000100

	000003
	106000
	002000
	004430

	000001
	145000
	000000
	000000

	000003
	106000
	002000
	004451

	000001
	141000
	000000
	000000

	000001
	100000
	000000
	000000

	000000
	000000
	000000
	000240

	000003
	170000
	000000
	000000
program_end:
	
	;; CODE SECTION
reset:	NIOP FPU		; Reset the FPU
start:	NIOS FPU		; Set the FPU to busy

	;; First, set the switches to the address in question
	LDA 0,load_addr
	LDA 1,CMD_WTSR
	DOA 1,FPU
	DOB 0,FPU

	;; Load address into TMA
	LDA 0,FN_DEP|FN_REGTMA
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	LDA 2,program_ptr
	LDA 3,program_end_ptr

	;; Prime the pump - initial deposit must be without increment
	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,CMD_WTSR
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,FN_DEP|FN_INC0|FN_OFFS0|FN_REGPS
	LDA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2

	;;  Load the program onto the FPU
loadpg:	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,CMD_WTSR
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,FN_DEP|FN_INC1|FN_OFFS0|FN_REGPS
	LDA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	SUB# 2,3,SZR
	JMP loadpg

	;; Start the FPU, at the address in SR
	LDA 0,load_addr
	LDA 1,CMD_WTSR
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,FN_START
	LDA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	;; Wait until the FPU is finished
waitstop:
	LDA 1,CMD_RDFN
	DOA 1,FPU
	DIB 0,FPU

	LDA 1,FN_STOP
	AND# 0,1,SNR
	JMP waitstop

	;; Read back the results
	LDA 0,results_addr
	LRA 1,CMD_WTSR
	DOA 1,FPU
	DOB 0,FPU

	;; Load address into TMA
	LDA 0,FN_DEP|FN_REGTMA
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	;; First word
	LDA 0,FN_EXAM|FN_REGPS
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,CMD_RDLT
	DOA 1,FPU
	DIB 0,FPU
	HALT

	;; Second word
	LDA 0,FN_EXAM|FN_REGPS|FN_OFFS1
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,CMD_RDLT
	DOA 1,FPU
	DIB 0,FPU
	HALT

	;; Third word
	LDA 0,FN_EXAM|FN_REGPS|FN_OFFS2
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,CMD_RDLT
	DOA 1,FPU
	DIB 0,FPU
	HALT

	;; Fourth word
	LDA 0,FN_EXAM|FN_REGPS|FN_OFFS3
	LRA 1,CMD_WTFN
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,CMD_RDLT
	DOA 1,FPU
	DIB 0,FPU
	HALT
