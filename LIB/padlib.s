;written by Doug Fraker 2019
;NES powerpad code


.export _read_powerpad




;from NESDEV WIKI
;7  bit  0
;---- ----
;xxxH Lxxx
;   | |
;   | +---- Serial data from buttons 2, 1, 5, 9, 6, 10, 11, 7
;   +------ Serial data from buttons 4, 3, 12, 8 (following 4 bits read as H=1)



;assumed that dpmc errors won't happen
;usually powerpads are in controller port 2
;but this can do either port
;in value = 0 or 1, which port
;out value = ax = 2 byte read
;a = x 6 x 10 x 11 x 7
;x = 4 2 3 1 12 5 8 9

_read_powerpad:
	tay
	ldx #1
	stx CTRL_PORT1
	dex ;#0
	stx CTRL_PORT1
	
	inx ;x = 1
@loop:
	lda CTRL_PORT1,y
	and #$18
	asl a
	asl a
	sta <TEMP, x ;0110 0000
	
	lda CTRL_PORT1,y
	and #$18
	ora <TEMP, x
	asl a
	sta <TEMP, x ;1111 0000
	
	lda CTRL_PORT1,y
	and #$18
	lsr a
	ora <TEMP, x
	sta <TEMP, x ;1111 1100
	
	lda CTRL_PORT1,y
	and #$18
	lsr a
	lsr a
	lsr a
	ora <TEMP, x
	sta <TEMP, x ;1111 1111
	
	dex
	beq @loop
	
@exit:
	lda <TEMP
	ldx <TEMP+1
	rts
	
	
	

	

	
	
	
	