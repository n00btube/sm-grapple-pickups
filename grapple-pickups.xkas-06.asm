; Copyright 2016 Adam <https://github.com/n00btube>
; MIT license.
; There _could_ be newer versions available on GitHub.

lorom

; item pickups set themselves as crumble blocks with BTS $45
; therefore, hijack the grapple beam H-collision with crumble blocks.
org $94A851
	DW pickup ; entry in table at $A83B
; TODO: find the V-collision table (or understand why it's unneeded?)

; can be placed anywhere in bank $94 free space
org $94B400
pickup:
	LDX $0DC4  ; reload block index
	LDA $7F6402,X ; load BTS (current + next block)
	AND #$00FF ; isolate our own BTS
	CMP #$0045 ; is it an item pickup, in particular?
	BNE no_collect ; if not, just report "is solid"

	ASL A      ; expand BTS to use as index into table of words
	TAX        ; store in X (preserved by JSL) for item pickup
	JSR $90DA  ; do the item pickup
no_collect:
	SEC        ; always report "is solid"
	RTS        ; return to caller
