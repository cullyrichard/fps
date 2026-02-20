	JMP reset

	;; DATA SECTION
results_addr:		0000100
load_addr:		0000200
program_ptr:		program
program_end_ptr:	program_end
stop_bit:		FN_STOP

fn_load_tma:		0001003
fn_load_ps_0:		0001010
fn_load_ps_1:		0001030
fn_load_ps_2:		0001050
fn_load_ps_3:		0001170
fn_start:		0040000
fn_stop:		0100000

fn_load_ma:		0001002
fn_examine_regmd:	0002015
fn_examine_regmd_o1:	0002035
fn_examine_regmd_o2:	0002055
fn_examine_regmd_o3:	0002075

cmd_wtsr:		0021031
cmd_wtfn:		0022031
cmd_rdfn:		0022030
cmd_rdlt:		0023030

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
reset:	NIOP 054		; Reset the FPU
start:	NIOS 054		; Set the FPU to busy

	;; First, set the switches to the address in question
	LDA 0,load_addr
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	;; Load address into TMA
	LDA 0,fn_load_tma
	LRA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 2,program_ptr
	LDA 3,program_end_ptr

	;;  Load the program onto the FPU
loadpg:	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	LDA 0,fn_load_ps_0
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	INC 2,2
	
	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	LDA 0,fn_load_ps_1
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	INC 2,2
	
	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	LDA 0,fn_load_ps_2
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	INC 2,2
	
	LDA 0,0,2		; Indirectly load from the pointer in AC2
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	LDA 0,fn_load_ps_3
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	INC 2,2
	SUB# 2,3,SZR
	JMP loadpg

	;; Start the FPU, at the address in SR
	LDA 0,load_addr
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	LDA 0,fn_start
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	;; Wait until the FPU is finished
waitstop:
	LDA 1,cmd_rdfn
	DOA 1,054
	DIB 0,054

	LDA 1,fn_stop
	AND# 0,1,SNR
	JMP waitstop

	;; Read back the results
	LDA 0,results_addr
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	;; Load address into MMA
	LDA 0,fn_load_ma
	LRA 1,cmd_rtfn
	DOA 1,054
	DOB 0,054

	;; First word
	LDA 0,fn_examine_regmd
	LRA 1,cmd_rtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT

	;; Second word
	LDA 0,fn_examine_regmd_o1
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT

	;; Third word
	LDA 0,fn_examine_regmd_o2
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT

	;; Fourth word
	LDA 0,fn_examine_regmd_o3
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT
