		.file "prog4.s"
		.section .text
		.global prepareKey
@_____________________________________________________________________________
@ register renaming 
key .req r4
char .req r5			@ 
alphapointer .req r6	@ pointer to the address of my aphlabet array
i .req r7				@ itterator for alphabetLoop
j .req r8				@ itterator for keyLoop
found .req r10			@ boolean for if char is already found or not

@____________________________________________________________________________
prepareKey:
	push {r4, r5, r6, r7, r8, r10, r11, lr}
	mov key, r0

	cmp key, #00					@ check if arguments are empty or not
	beq prepareDoneNoKey

	ldr alphapointer, =alphabet		@ create pointer to the alphabet string

		mov i, #0
	alphabetLoop: 					@ loop though alphabet array
		mov found, #0				@ set bool found to 0	
		mov j, #1					@ initalize j to #1 for starting the keyLoop over 

		@ ldr r0, =charfmt 			@ print out individual chars
		@ ldmia alphapointer, {r1}	@ load the first letter of alphabet into r1
		@ bl printf

		ldr char, [key]				@ create pointer to address of key
		keyLoop:					@ loop though key array
			@ ldr r0, =keycharfmt	@ set r0 to fmt string for printing key char
			@ mov r1, char			@ put the address for the keychar into r1 for printing
			@ bl printf

			mov r0, char 
			ldmia alphapointer, {r1}
			cmp r0, r0			@ if (char == alphabetchar)
			@ bleq ifequal				 
			
			ldr char, [key,j]		@ move char pointer to j'ith location on key string
			add j, j, #1			@ increment j +1
			cmp char, #00			@ loop back to keyLoop if current char is not null "#00"
			bne keyLoop

		@ continue alphabetLoop
		add alphapointer, alphapointer, #1	@ increment alphabet char
		add i, i, #1				@ increment i +1
		cmp i, #26					@ compare i to lenght of alphabet (26)
		blt alphabetLoop			@ end alphabet loop

	mov r0, #1						@ return 1 and branch to done
	b prepareDone					@ branch to end of prepareKey function

@_____________________________________________________________________________
ifequal:
	ldr r0, =foundmatch
	ldmia alphapointer, {r1}
	bl printf
	bx lr
@_____________________________________________________________________________
prepareDoneNoKey:
	ldr r0, =fmt
	ldr r1, =nokey
	bl printf
	mov r0, #0
	pop {r4, r5, pc}
@_____________________________________________________________________________
prepareDone:
	ldr r0, =end
	bl printf
	pop {r4,r5,r6,r7,r8,r10,r11,pc}
@_____________________________________________________________________________

fmt: .asciz "%c\n"
decimalfmt: .asciz "%d\n"
charfmt: .asciz "%c\n"
keycharfmt: .asciz "key char: %c\n"
foundmatch: .asciz "found match: %c\n"
nokey: .asciz "a key was not supplied\n"
alphabet: .asciz "abcdefghijklmnopqrstuvwxyz\n"
end: .asciz "End of prepareKey\n"
