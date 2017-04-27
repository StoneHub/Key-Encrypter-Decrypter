	.text
	.global encode
	.type encode, %function

input	.req r0					@register renaming
output	.req r1
key		.req r2
switch	.req r3

char	.req r4
k_orig	.req r5
value	.req r6
kvalue	.req r7

encode:
	mov 	k_orig, key			@saves original key
	cmp		switch, #1			@checks for decoding
	beq		decode

loop:
	ldrb	char, [key], #1		@loads individual characters from key
	
	cmp		char, #0			@resets key if null character is reached
	beq		key_reset
	
	mov		kvalue, char		@holds key character in kvalue

	ldrb	char, [input], #1	@loads individual characters from input
	mov		value, char			@holds input character in value

	cmp		kvalue, #32			@checks for space
	beq		space

	cmp		value, #32			@checks for space
	beq		space
	
	add		value, value, kvalue
	sub		value, value, #96	@encode math application
	
	cmp		value, #122
	bge		overflow			@checks for overflow

continue:
	strb	value, [output], #1	@places new character in output
	cmp		char, #0			@loop condition
	bne		loop

done:							@stops encoding
	bx		lr

space:							@skips in case of spaces, etc.
	strb	value, [output], #1
	b		loop

key_reset:						@resets key to original value
	mov		key, k_orig
	b		loop

overflow:
	sub		value, value, #26	@subtracts 26 to account for overflow
	b		continue

decode:							@start of decoding
	ldrb	char, [key], #1		@loads individual characters from key
			
	cmp		char, #0			@resets key if null character is reached
	beq		decode_reset
	
	mov		kvalue, char		@holds key character in kvalue

	ldrb	char, [input], #1	@loads individual characters from input
	mov		value, char			@holds input character in value

	cmp		kvalue, #32			@checks for space
	beq		decode_space		
		
	cmp		value, #32			@checks for space
	beq		decode_space
	
	sub		value, value, kvalue
	add		value, value, #96	@decode math application
	
	cmp		value, #97
	blt		decode_overflow		@checks for overflow

continue_decode:
	strb	value, [output], #1	@places new character in output
	cmp		char, #0			@loop condition
	bne		decode	

done_decoding:					@stops decoding
	bx		lr

decode_space:
	strb	value, [output], #1	@skips in case of spaces, etc.
	b		decode

decode_reset:
	mov		key, k_orig			@resets key to original value
	b		decode

decode_overflow:	
	add		value, value, #26	@adds 26 to account for overflow
	b		continue_decode
