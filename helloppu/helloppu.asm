.include "consts.inc"
.include "header.inc"
.include "reset.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM code located at $8000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets/powers-on)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Reset:
	INIT_NES

Main:
	ldx #$3F
	stx PPU_ADDR			; Set hi-byte of PPU_ADDR to $3F
	ldx #$00
	stx PPU_ADDR			; Set lo-byte of PPU_ADDR to $00

	lda #$2A
	sta PPU_DATA			; Send $2A (lime-green color code) to PPU_DATA
	lda #%00011110
	sta PPU_MASK			; Set PPU_MASK bits to show background

LoopForever:
	jmp LoopForever			; Forces an infinite loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NMI interrupt handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NMI:
	rti						; Return from interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IRQ interrupt handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IRQ:
	rti						; Return from interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vectors with the addresses of the handlers that we always add at $FFFA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.word NMI					; address (2 bytes) of the NMI handler
.word Reset					; address (2 bytes) of the RESET handler
.word IRQ					; address (2 bytes) of the IRQ handler
