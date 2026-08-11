	org 07600
	JMP reset
program:
//;No-Op
dw 0000000,0000000,0000000,0000000
//;LDTMA;DB=!THIRD ; !THIRD is 04430
dw 0000003,0103000,0002000,0004430
//;LDMA;DB=@077
dw 0000003,0102000,0002000,0000077
//;LDDPA;DB=ZERO
dw 0000003,0104000,0000000,0000000
//;DPX(0)<DB;DB=TM
dw 0000000,0000000,0047444,0100000
//;LDTMA;DB=!SIXTN ; !SIXTN is 4451
dw 0000003,0103000,0002000,0004451
//;No-Op
dw 0000000,0000000,0000000,0000000
//;DPY(0)<DB;DB=TM
dw 0000000,0000000,0017444,0100000
//;FADD DPX,DPY
dw 0000001,0123000,0000444,0100000
//;FADD
dw 0000001,0100000,0000000,0000000
//;MI<FA;INCMA
dw 0000000,0000000,0000000,0000120
//;No-Op
dw 0000000,0000000,0000000,0000000
//;No-Op
dw 0000000,0000000,0000000,0000000
//;Halt
dw 0000003,0170000,0000000,0000000
program_end:
memory_begin:
// 3.0
dw 0001002,0003000,000000
// 4.0
dw 0001003,0002000,0000000
// 5.0
dw 0001003,0002400,0000000
// 6.0
dw 0001003,0003000,0000000
// 7.0
dw 0001003,0003400,0000000
memory_end:
load_addr_ps:
dw 0000200
load_addr_md:
dw 0000000
program_ptr:
dw program
program_end_ptr:
dw program_end
memory_ptr:
dw memory_begin
memory_end_ptr:
dw memory_end
dev FPU = 054
	//; CODE SECTION
reset:
	NIOP FPU		//; Reset the FPU
start:
	NIOS FPU		//; Set the FPU to busy

	//; First, set the switches to the address in question
	LDA 0,load_addr_ps,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	//; Load address into TMA
	LDA 0,fn_load_tma,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 2,program_ptr,1
	LDA 3,program_end_ptr,1

	//;  Load the program onto the FPU
loadpg:
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_ps_0,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_ps_1,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_ps_2,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_ps_3,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	SUB# 2,3,SZR
	JMP loadpg

	//; First, set the switches to the address in question
	LDA 0,load_addr_md,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	//; Load address into MA
	LDA 0,fn_load_ma,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 2,program_ptr,1
	LDA 3,program_end_ptr,1

	//;  Load the program onto the FPU
loadmd:
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_md_1,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_md_2,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	
	LDA 0,0,2		//; Indirectly load from the pointer in AC2,1
	LDA 1,cmd_wtsr,1
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_load_md_3,1
	LDA 1,cmd_wtfn,1
	DOA 1,FPU
	DOB 0,FPU

	INC 2,2
	SUB# 2,3,SZR
	JMP loadmd
  
                    //;; Start the FPU, at the address in SR
	LDA 0,load_addr_ps
	LDA 1,cmd_wtsr
	DOA 1,FPU
	DOB 0,FPU

	LDA 0,fn_start
	LDA 1,cmd_wtfn
	DOA 1,FPU
	DOB 0,FPU
  
	JMP read_back

fn_load_tma:
dw 0001003
fn_load_ps_0:
dw 0001010
fn_load_ps_1:
dw 0001030
fn_load_ps_2:
dw 0001050
fn_load_ps_3:
dw 0001370
fn_start:
dw 0040000
fn_stop:
dw 0100000

fn_load_ma:
dw 0001002
fn_load_md_1:
dw 0001035
fn_load_md_2:
dw 0001055
fn_load_md_3:
dw 0001175

fn_examine_regmd_o1:	0002035
fn_examine_regmd_o2:	0002055
fn_examine_regmd_o3:	0002075

cmd_wtsr:
dw 0021031
cmd_wtfn:
dw 0022031
cmd_rdfn:
dw 0022030
cmd_rdlt:
dw 0023030
results_addr:
dw 0000004

read_back:
	;; Read back the results
	LDA 0,results_addr
	LDA 1,cmd_wtsr
	DOA 1,FPU
	DOB 0,FPU

	;; Load address into MA
	LDA 0,fn_load_ma
	LDA 1,cmd_wtfn
	DOA 1,FPU
	DOB 0,FPU

	;; Second word
	LDA 0,fn_examine_regmd_o1
	LDA 1,cmd_wtfn
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,cmd_rdlt
	DOA 1,FPU
	DIB 0,FPU
	HALT

	;; Third word
	LDA 0,fn_examine_regmd_o2
	LDA 1,cmd_wtfn
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,cmd_rdlt
	DOA 1,FPU
	DIB 0,FPU
	HALT

	;; Fourth word
	LDA 0,fn_examine_regmd_o3
	LDA 1,cmd_wtfn
	DOA 1,FPU
	DOB 0,FPU

	LDA 1,cmd_rdlt
	DOA 1,FPU
	DIB 0,FPU
	HALT

	JMP @start_ptr

start_ptr: start
