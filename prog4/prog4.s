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

	cmp key, #0			@ check if arguments are empty or not
	beq prepareDoneNoKey

	ldr alphapointer, =alphabet
	ldr char, [key]

		mov i, #0
	alphabetLoop: 					@ loop though alphabet array
		ldr r0, =charfmt 			@ print out individual chars
		ldmia alphapointer, {r1}	@ load the first letter of alphabet into r1
		bl printf

		mov found, #0				@ set bool found to 0	

			mov j, #0
		keyLoop:				@ loop though key array
			ldr r0, =charfmt
			ldmia char, {r2}


			


		@ continue alphabetLoop
		add alphapointer, alphapointer, #1	@ increment alphabet char
		add i, i, #1
		cmp i, #26
		blt alphabetLoop					@ end alphabet loop

	mov r0, #1							@ return 1 and branch to done
	b prepareDone					
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
fmt: .asciz "%s\n"
decimalfmt: .asciz "%d\n"
charfmt: .asciz "%c\n"
nokey: .asciz "a key was not supplied\n"
alphabet: .asciz "abcdefghijklmnopqrstuvwxyz\n"
end: .asciz "End of prepareKey\n"
