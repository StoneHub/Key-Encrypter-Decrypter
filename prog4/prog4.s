		.file "prog4.s"
		.section .text
		.align 2
		.global prepareKey
		.type prepareKey, %function
@______________________________________________________________________________
@ register renaming 
key .req r4
char .req r5

@______________________________________________________________________________
prepareKey:
	push {r4, r5, lr}
	mov key, r0

	cmp key, #0
	beq prepareDoneNoKey

	ldr r0, =fmt
	mov r1, key
	bl printf

	b prepareDoneNoKey



prepareDoneNoKey:
	ldr r0, =fmt
	ldr r1, =nokey
	bl printf
	pop {r4, r5, pc}

prepareDone:
	ldr r0, =fmt
	ldr r1, =end

fmt: .asciz "%s\n"

nokey: .ascii "a key was not supplied"
end: .ascii "End of prepareKey"