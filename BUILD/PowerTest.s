;
; File generated by cc65 v 2.15
;
	.fopt		compiler,"cc65 v 2.15"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_bg
	.import		_pal_spr
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_oam_clear
	.import		_oam_spr
	.import		_bank_spr
	.import		_vram_adr
	.import		_vram_unrle
	.import		_read_powerpad
	.export		_PowerBG
	.export		_powerpad_cur
	.export		_powerpad_old
	.export		_powerpad_new
	.export		_pal1
	.export		_pal2
	.export		_process_powerpad
	.export		_main

.segment	"RODATA"

_PowerBG:
	.byte	$01
	.byte	$00
	.byte	$01
	.byte	$41
	.byte	$50
	.byte	$6F
	.byte	$77
	.byte	$65
	.byte	$72
	.byte	$70
	.byte	$61
	.byte	$64
	.byte	$00
	.byte	$00
	.byte	$54
	.byte	$65
	.byte	$73
	.byte	$74
	.byte	$00
	.byte	$01
	.byte	$31
	.byte	$50
	.byte	$6F
	.byte	$72
	.byte	$74
	.byte	$00
	.byte	$32
	.byte	$00
	.byte	$01
	.byte	$63
	.byte	$A7
	.byte	$A8
	.byte	$A8
	.byte	$A9
	.byte	$00
	.byte	$01
	.byte	$18
	.byte	$90
	.byte	$91
	.byte	$91
	.byte	$97
	.byte	$98
	.byte	$98
	.byte	$99
	.byte	$91
	.byte	$91
	.byte	$92
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$91
	.byte	$01
	.byte	$09
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$96
	.byte	$A0
	.byte	$A1
	.byte	$A0
	.byte	$A1
	.byte	$A2
	.byte	$A3
	.byte	$A2
	.byte	$A3
	.byte	$96
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$91
	.byte	$B0
	.byte	$B1
	.byte	$B0
	.byte	$B1
	.byte	$B2
	.byte	$B3
	.byte	$B2
	.byte	$B3
	.byte	$91
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$95
	.byte	$01
	.byte	$09
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$96
	.byte	$A0
	.byte	$A1
	.byte	$A0
	.byte	$A1
	.byte	$A2
	.byte	$A3
	.byte	$A2
	.byte	$A3
	.byte	$96
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$91
	.byte	$B0
	.byte	$B1
	.byte	$B0
	.byte	$B1
	.byte	$B2
	.byte	$B3
	.byte	$B2
	.byte	$B3
	.byte	$91
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$95
	.byte	$01
	.byte	$09
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$96
	.byte	$A0
	.byte	$A1
	.byte	$A0
	.byte	$A1
	.byte	$A2
	.byte	$A3
	.byte	$A2
	.byte	$A3
	.byte	$96
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$91
	.byte	$B0
	.byte	$B1
	.byte	$B0
	.byte	$B1
	.byte	$B2
	.byte	$B3
	.byte	$B2
	.byte	$B3
	.byte	$91
	.byte	$00
	.byte	$01
	.byte	$15
	.byte	$93
	.byte	$91
	.byte	$01
	.byte	$07
	.byte	$94
	.byte	$00
	.byte	$01
	.byte	$FE
	.byte	$00
	.byte	$01
	.byte	$78
	.byte	$50
	.byte	$00
	.byte	$01
	.byte	$06
	.byte	$05
	.byte	$00
	.byte	$01
	.byte	$2A
	.byte	$00
	.byte	$01
	.byte	$00
_pal1:
	.byte	$0F
	.byte	$11
	.byte	$16
	.byte	$30
	.byte	$0F
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_pal2:
	.byte	$0F
	.byte	$0F
	.byte	$0F
	.byte	$0F
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00

.segment	"BSS"

.segment	"ZEROPAGE"
_powerpad_cur:
	.res	2,$00
_powerpad_old:
	.res	2,$00
_powerpad_new:
	.res	2,$00

; ---------------------------------------------------------------
; void __near__ process_powerpad (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_process_powerpad: near

.segment	"CODE"

;
; powerpad_new = (powerpad_cur^powerpad_old)&powerpad_cur;
;
	lda     _powerpad_old
	eor     _powerpad_cur
	sta     ptr1
	lda     _powerpad_old+1
	eor     _powerpad_cur+1
	sta     ptr1+1
	lda     _powerpad_cur
	and     ptr1
	sta     _powerpad_new
	lda     _powerpad_cur+1
	and     ptr1+1
	sta     _powerpad_new+1
;
; powerpad_old = powerpad_cur;
;
	lda     _powerpad_cur
	sta     _powerpad_old
	lda     _powerpad_cur+1
	sta     _powerpad_old+1
;
; } 
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(pal1);
;
	lda     #<(_pal1)
	ldx     #>(_pal1)
	jsr     _pal_bg
;
; pal_spr(pal2);
;
	lda     #<(_pal2)
	ldx     #>(_pal2)
	jsr     _pal_spr
;
; bank_spr(1);
;
	lda     #$01
	jsr     _bank_spr
;
; vram_adr(NAMETABLE_A); // set a start position for the text
;
	ldx     #$20
	lda     #$00
	jsr     _vram_adr
;
; vram_unrle(PowerBG);
;
	lda     #<(_PowerBG)
	ldx     #>(_PowerBG)
	jsr     _vram_unrle
;
; ppu_on_all(); // turn on screen
;
	jsr     _ppu_on_all
;
; ppu_wait_nmi(); // wait till beginning of the frame
;
L00DE:	jsr     _ppu_wait_nmi
;
; oam_clear();
;
	jsr     _oam_clear
;
; powerpad_cur = read_powerpad(1);
;
	lda     #$01
	jsr     _read_powerpad
	sta     _powerpad_cur
	stx     _powerpad_cur+1
;
; process_powerpad(); // goes after the read
;
	jsr     _process_powerpad
;
; if(powerpad_cur & POWERPAD_1){
;
	lda     _powerpad_cur+1
	and     #$10
	beq     L00E8
;
; oam_spr(84, 83, 0, 0);
;
	jsr     decsp3
	lda     #$54
	ldy     #$02
	sta     (sp),y
	lda     #$53
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_2){
;
L00E8:	lda     _powerpad_cur+1
	and     #$40
	beq     L00EF
;
; oam_spr(100, 83, 0, 0);
;
	jsr     decsp3
	lda     #$64
	ldy     #$02
	sta     (sp),y
	lda     #$53
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_3){
;
L00EF:	lda     _powerpad_cur+1
	and     #$20
	beq     L00F6
;
; oam_spr(116, 83, 0, 0);
;
	jsr     decsp3
	lda     #$74
	ldy     #$02
	sta     (sp),y
	lda     #$53
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_4){
;
L00F6:	lda     _powerpad_cur+1
	and     #$80
	beq     L00FD
;
; oam_spr(132, 83, 0, 0);
;
	jsr     decsp3
	lda     #$84
	ldy     #$02
	sta     (sp),y
	lda     #$53
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_5){
;
L00FD:	lda     _powerpad_cur+1
	and     #$04
	beq     L0104
;
; oam_spr(84, 107, 0, 0);
;
	jsr     decsp3
	lda     #$54
	ldy     #$02
	sta     (sp),y
	lda     #$6B
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_6){
;
L0104:	lda     _powerpad_cur
	and     #$40
	beq     L010B
;
; oam_spr(100, 107, 0, 0);
;
	jsr     decsp3
	lda     #$64
	ldy     #$02
	sta     (sp),y
	lda     #$6B
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_7){
;
L010B:	lda     _powerpad_cur
	and     #$01
	beq     L0112
;
; oam_spr(116, 107, 0, 0);
;
	jsr     decsp3
	lda     #$74
	ldy     #$02
	sta     (sp),y
	lda     #$6B
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_8){
;
L0112:	lda     _powerpad_cur+1
	and     #$02
	beq     L0119
;
; oam_spr(132, 107, 0, 0);
;
	jsr     decsp3
	lda     #$84
	ldy     #$02
	sta     (sp),y
	lda     #$6B
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_9){
;
L0119:	lda     _powerpad_cur+1
	and     #$01
	beq     L0120
;
; oam_spr(84, 131, 0, 0);
;
	jsr     decsp3
	lda     #$54
	ldy     #$02
	sta     (sp),y
	lda     #$83
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_10){
;
L0120:	lda     _powerpad_cur
	and     #$10
	beq     L0127
;
; oam_spr(100, 131, 0, 0);
;
	jsr     decsp3
	lda     #$64
	ldy     #$02
	sta     (sp),y
	lda     #$83
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_11){
;
L0127:	lda     _powerpad_cur
	and     #$04
	beq     L012E
;
; oam_spr(116, 131, 0, 0);
;
	jsr     decsp3
	lda     #$74
	ldy     #$02
	sta     (sp),y
	lda     #$83
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; if(powerpad_cur & POWERPAD_12){
;
L012E:	lda     _powerpad_cur+1
	and     #$08
	jeq     L00DE
;
; oam_spr(132, 131, 0, 0);
;
	jsr     decsp3
	lda     #$84
	ldy     #$02
	sta     (sp),y
	lda     #$83
	dey
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	jsr     _oam_spr
;
; while (1){
;
	jmp     L00DE

.endproc

