	.text
	;; CODE SECTION
reset:	NIOP 054		; Reset the FPU
start:	NIOS 054		; Set the FPU to busy

	;; Read back the results
	LDA 0,third
	LDA 1,cmd_wtsr
	DOA 1,054
	DOB 0,054

	;; Load address into TMA
	LDA 0,fn_load_tma
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054
	
	;; Dummy Load address into TMA
	LDA 0,fn_load_tma
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	;; Second word
	LDA 0,fn_examine_regtm_o1
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT

	;; Third word
	LDA 0,fn_examine_regtm_o2
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT

	;; Fourth word
	LDA 0,fn_examine_regtm_o3
	LDA 1,cmd_wtfn
	DOA 1,054
	DOB 0,054

	LDA 1,cmd_rdlt
	DOA 1,054
	DIB 0,054
	HALT
	JMP start
	;; DATA SECTION
third:		0004430

fn_load_tma:		0001003
fn_start:		0040000
fn_stop:		0100000

fn_examine_regtm_o1:	0002037
fn_examine_regtm_o2:	0002057
fn_examine_regtm_o3:	0002077

cmd_wtsr:		0021031
cmd_wtfn:		0022031
cmd_rdfn:		0022030
cmd_rdlt:		0023030

