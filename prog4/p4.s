		.file "p4.s"
		.section .text
		.global prepareKey
@_____________________________________________________________________________

@r4 = key
@r5 = char 
@r6 = alphapointer, pointer to the address of my aphlabet array
@r7 = i
@r8 = j
@r10 = found

@____________________________________________________________________________


prepareKey:
	push {r4, r5, r6, r7, r8, r10, r11, lr}
	mov r4, r0

    ldrb r11, [r4, #0]
	cmp r11, #0					@ check if arguments are empty or not
	beq prepareDoneNoKey

		mov r7, #0
		mov r8, #1




    alphaCheckLoop:                 @ loop checks if letters are valid
    
        ldrb r5, [r4,r7]
        cmp r5, #0
        beq prepareDoneNoKey
 
        cmp r5, #0x61
        blt prepareDoneNoKey

        cmp r5, #0x7a
        bgt prepareDoneNoKey
        
        add r7, #1
        b alphaCheckLoop
              
    	ldr r6, =alphabet
	   	
	   	mov r7, #0
	alphabetLoop: 					@ loop though alphabet array
	    ldrb r11, [r6, r7]          @ load alpha[i] into r11
	    cmp r11, #0                 @ checks if alpha[] is empty
	    beq alphabetLoopEnd         @ ends loop if equal
	    
	    mov r10, #0                 @ found = false
	    
	    mov r8, #0                  @ j = 0
	keyLoop:
	    ldrb r5, [r4, r8]           @ loads key[j] into r5
	    cmp r5, #0                  @ checks if key[] is empty
	    beq keyLoopEnd
	    
	    cmp r11, r5                 @ if r11 and r5 != then continue in loop
	    bne keyLoopCont
	    
	    cmp r10, #1                 @ if found = true then branch to found true 
	    beq foundTrue
	    
	    mov r10, #1                 @ set found = true and continue in loop
	    b keyLoopCont 	    
	    
	foundTrue:
	    mov r5, #0x20               @ replace key[j] with a space
	    strb r5, [r4, r8]           @ store space bac into key[]
	    
    keyLoopCont:
	    add r8, #1                  @ j++
	    b keyLoop
	keyLoopEnd:
	    
	    cmp r10, #1                 @ if found != true continue in loop
	    bne alphabetLoopCont
	    
	    mov r11, #0x20              @ replace alpha[i] with space
	    strb r11, [r6, r7]          @ store space in alpha[]
	    
	alphabetLoopCont:    
	    add r7, #1                  @i++
	    b alphabetLoop
	    
	alphabetLoopEnd:
	
	    mov r7, #0
	    mov r8, #0
	    
	fixKeyLoop:
	    ldrb r5, [r4, r7]        @ r5 = key[i]
	    cmp r5, #0
	    beq fixKeyLoopDone
	    
	    cmp r5, #0x20
	    beq fixKeyLoopCont       @ doesnt allow j++ so the alpha[] index is correct
	    strb r5, [r4, r8]
	    add r8, #1
	    
	fixKeyLoopCont:
	    add r7, #1
	    b fixKeyLoop
	fixKeyLoopDone:
	
	
        mov r7, #0
        ldrb r11, [r6, r7]
        
        add r0, r7, #0x61
        mov r11, r7
        
        strb r11, [r6, r0]
	
	 mov r0, #1						@ return 1 and branch to done

	
@_____________________________________________________________________________
prepareDoneNoKey:
	ldr r0, =fmt
	ldr r1, =nokey
	bl printf
	mov r0, #0
	pop {r4,r5,r6,r7,r8,r10,r11,pc}
@_____________________________________________________________________________
prepareDone:
	ldr r0, =end
	bl printf
	pop {r4,r5,r6,r7,r8,r10,r11,pc}
@_____________________________________________________________________________
fmt: .asciz "%s\n"
decimalfmt: .asciz "%d\n"
charfmt: .asciz "%c"
keycharfmt: .asciz "key char: %c\n"
nokey: .asciz "a key was not valid\n"
alphabet: .asciz "abcdefghijklmnopqrstuvwxyz"
end: .asciz "\nEnd of prepareKey\n"
