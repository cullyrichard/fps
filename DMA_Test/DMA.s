	dev TTI = 010
	dev TTO = 011
	dev FPU = 054

	const FN_STOP    = 0100000
	const FN_START   = 0040000
	const FN_CONT    = 0020000
	const FN_STEP    = 0010000
	const FN_RESET   = 0004000
	const FN_EXAM    = 0002000
	const FN_DEP     = 0001000
	const FN_BREAK   = 0000400
	const FN_INC_TMA = 0000300
	const FN_INC_DPA = 0000200
	const FN_INC_MA  = 0000100
	const FN_WORD3   = 0000060
	const FN_WORD2   = 0000040
	const FN_WORD1   = 0000020

	const FN_REG_PSA      = 00
	const FN_REG_SPD      = 01
	const FN_REG_MA       = 02
	const FN_REG_TMA      = 03
	const FN_REG_DPA      = 04
	const FN_REG_SPFN     = 05
	const FN_REG_APSTATUS = 06
	const FN_REG_DA       = 07

	const FN_MEM_SP   = 005
	const FN_MEM_PS   = 010
	const FN_MEM_INBS = 011
	const FN_MEM_DPX  = 013
	const FN_MEM_DPY  = 014
	const FN_MEM_MD   = 015
	const FN_MEM_TM   = 017

	const CMD_REG_SR = 0021000
	const CMD_REG_FN = 0022000
	const CMD_REG_LT = 0023000
	const CMD_PIO    = 0000030
	const CMD_WR     = 0000001
	const CMD_RSU    = 0100000

	const CMD_DMA_HMAH  = 0002030
	const CMD_DMA_HMAL  = 0001010
	const CMD_DMA_WC    = 0005050
	const CMD_DMA_APDMA = 0000030
	const CMD_DMA_CTL   = 0024060
	
	const CTL_INTRQ_AP = 0040000
	const CTL_IAPWC    = 0020000
	const CTL_IHALT    = 0010000
	const CTL_IHWC     = 0004000
	const CTL_IHENB    = 0002000
	const CTL_CC       = 0000200
	const CTL_APDMA    = 0000100
	const CTL_WRTHOST  = 0000040
	const CTL_DECAPMA  = 0000020
	const CTL_FMT_1    = 0000002
	const CTL_FMT_2    = 0000004
	const CTL_FMT_3    = 0000006
	const CTL_HDMA     = 0000001

	org 07400
start:
	NIOP FPU
	NIOS FPU
	
	LDA 0, dma_hmah, 1
	DOA 0, FPU
	LDA 1, hmah, 1
	DOB 1, FPU
	
	LDA 0, dma_hmal, 1
	DOA 0, FPU
	LDA 1, hmal, 1
	DOB 1, FPU
	
	LDA 0, dma_wc, 1
	DOA 0, FPU
	LDA 1, wc, 1
	DOB 1, FPU
	
	LDA 0, dma_apdma, 1
	DOA 0, FPU
	LDA 1, apdma, 1
	DOB 1, FPU
	
	LDA 0, dma_ctl, 1
	DOA 0, FPU
	LDA 1, ctl_dma, 1
	DOB 1, FPU
	
	LDA 0, dma_ctl, 1
	DOA 0, FPU
	LDA 1, clt_hma, 1
	DOB 1, FPU
	
//	LDA 0, release_pio,1
//	DOA 0, FPU
	
	HALT
	JMP start
dma_hmah: 
	dw CMD_DMA_HMAH | CMD_WR
hmah: 
	dw 0
dma_hmal: 
	dw CMD_DMA_HMAL | CMD_WR
hmal: 
	dw data
dma_wc: 
	dw CMD_DMA_WC | CMD_WR
wc: 
	dw 7
dma_apdma: 
	dw CMD_DMA_APDMA | CMD_WR
apdma: 
	dw 0
dma_ctl: 
	dw  CMD_DMA_CTL | CMD_WR
ctl_dma:
	dw CTL_CC | CTL_APDMA
clt_hma:
	dw CTL_CC | CTL_APDMA | CTL_HDMA
dma_ctl_release: 
	dw CMD_DMA_CTL | CMD_WR | CMD_RSU
release_pio:
	dw CMD_RSU

	org 07500
data: 
	dw 0100120, 0000000
	dw 0100040, 0000000
	dw 0100050, 0100000
	dw 0100020, 0100000

