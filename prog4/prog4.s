/*
Alexander Monroe Stone (astone8) 
Clay Blankenship (cjblank)
2310-1 
Program 4
4/25/2017
*/
        
        .file "p4.s"
		.section .text
		.global prepareKey
@_____________________________________________________________________________
/* function name:
    prepareKey()

   description:
    accepts a string containing the desired key word/string and 
    converts it as described above to the array of encoded 
    characters.  Assume the key argument is an array of at 
    least 27 characters long, including the null character.  
    Eliminate any duplicate letters from the word, and then 
    fill in the rest of the alphabet.  If the processing 
    succeeds, the function returns a true result (!= 0).  If 
    the key argument is empty or contains any nonalphabetic 
    characters, the function should return a false result. 

   input parameter(s):
    r0 - address of the key string to use
    
   return value (if any):
     r0 - the resulting key created
     
   other output parameters:
     returning int # 
     # = 0 for failure to make key or no proper string supplied as input
     # = 1/char for successfully making a key. 
  
   effect/output
     the key string is converted to an encryption key string 
     #key = key + dekeyed alphabet

   method / effect:
    changes the char string supplied from r0 into a key used to encrypt messages
    by appending a duplicate free alphabet to the end of key

   typical calling sequence:
    for int prepareKey(char* key);
    put given key in r0

   local register usage:
    r4 = key
    r5 = char
    r6 = alphapointer, pointer to the address of my aphlabet array
    r7 = i
    r8 = j
    r10 = found
    r11 = character for alphabet
 */
@____________________________________________________________________________

prepareKey:
	push {r4-r11, lr}
	mov r4, r0

    ldrb r11, [r4, #0]
	cmp r4, #0					@ check if arguments are empty or not
	beq prepareDoneNoKey

		mov r7, #0

    alphaCheckLoop:                 @ loop checks if letters are valid

        ldrb r5, [r4,r7]

        cmp r5, #0
        beq alphaCheckDone

        cmp r5, #0x61
        blt prepareDoneNoKey

        cmp r5, #0x7a
        bgt prepareDoneNoKey

        add r7, #1
        b alphaCheckLoop

	alphaCheckDone:
    	ldr r6, =alphabet

	   	mov r7, #0
	alphabetLoop: 					@ loop though alphabet array
	    ldrb r11, [r6, r7]          @ load alpha[i] into r11
	    cmp r11, #0                 @ checks if alpha[] is empty
	    beq alphabetLoopEnd        

	    mov r10, #0                 @ found = false

	    mov r8, #0                  @ j = 0
	keyLoop:
	    ldrb r5, [r4, r8]           @ loads key[j] into r5
	    cmp r5, #0                  @ checks if key[] is empty
	    beq keyLoopEnd

	    cmp r11, r5                
	    bne keyLoopCont

	    cmp r10, #1                
	    beq foundTrue

	    mov r10, #1                
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

fixAlphaLoop:
    ldrb r5, [r6, r7]        @ r5 = key[i]
    cmp r5, #0
    beq fixAlphaLoopDone

    cmp r5, #0x20
    beq fixAlphaLoopCont       @ doesnt allow j++ so the alpha[] index is correct
    strb r5, [r4, r8]
    add r8, #1

fixAlphaLoopCont:
    add r7, r7, #1
    b fixAlphaLoop

fixAlphaLoopDone:

        mov r5, #0
        strb r5, [r4, r8]

        mov r7, #0
        mov r10, #0

changeAlphaToOrignalLoop:
        ldrb r11, [r6, r7]
        cmp r11, #0
        beq changeAlphaToOrignalLoopDone

        add r10, r7, #0x61
        strb r10, [r6, r7]

        add r7, r7, #1
        b changeAlphaToOrignalLoop

changeAlphaToOrignalLoopDone:

	 mov r0, #1						@ return 1 and branch to done
     b prepareDone

@_____________________________________________________________________________
prepareDoneNoKey:
	ldr r0, =fmt
	ldr r1, =nokey
	bl printf
	mov r0, #0
	pop {r4-r11,pc}
@_____________________________________________________________________________
prepareDone:

	pop {r4-r11,pc}
@_____________________________________________________________________________
/* function name:
    encrypt()

   description:
    uses a key produced by prepareKey(()) to encrypt the 
    characters in str.  Nonalphabetic characters in str 
    are not changed, but alphabetic characters are encrypted using 
    the key provided by replacing the original character with the 
    coded character.  

   input parameter(s):
     r0 - char array for storing un-encrypted string 
     r1 - key string
     r2 - char array for storing the encrypted string
  
   return value (if any):
     none
     
   other output parameters:
     none
  
   effect/output
    fixes parameter d/r2 to be the encrypted string from parameter e/r0
    using key#/r1 for the encryption key 
  
   method / effect:
    compares key to the message string, and puts converted char into 
    the encrypted string array

   typical calling sequence:
    encrypt(char *message, char *key, char *encr);
    put address of the un-encrypted array in r0
    put the key in r1
    leave an address for returning the encrypted value in r2
  
   local register usage:
    r4 = key
    r5 = message
    r6 = character for key
    r7 = character for message
    r8 = i
 */
@_____________________________________________________________________________

.global encrypt

encrypt:
    push {r4-r8, lr}

    mov r4, r1                    @ r4 = key
    mov r5, r0                    @ r5 = message

    mov r8, #0                    @ i = 0

    encryptLoop:
        ldrb r7, [r5, r8]         @ r7 = message[i]
        cmp r7, #0
        beq encryptDone           @ ends loop if r7 == 0

        cmp r7, #0x61             @ lns 193-197 checks for valid character
        blt invalidChar

        cmp r7, #0x7a
        bgt invalidChar

        sub r7, r7, #0x61         @ ex. - 'a' - 0x61 = 0, 'z' - 0x61 = 25
        ldrb r7, [r4,r7]          @ stores key[i] into r7

        invalidChar:
            strb r7, [r2, r8]     @ stores message[i] into r7

        add r8, r8, #1            @ i++
        b encryptLoop

@_____________________________________________________________________________
encryptDone:

    mov r6, #0
    strb r6, [r2, r8]
    pop {r4-r8, pc}
@_____________________________________________________________________________
/* function name:
    decrypt()

   description:
    takes an encrypted string and reconstructs the original message.  
    Except for decrypting, this function should work the same as 
    encrypt. 
  
   input parameter(s):
     r0 - char array for storing the encrypted string 
     r1 - key string
     r2 - char array for storing the decrypted string
  
   return value (if any):
     none
     
   other output parameters:
     none
  
   effect/output
      fixes parameter d/r2 to be the decrypted string from parameter e/r0
      using key#/r1 for the decryption key 
  
   method / effect:
     compares encrypted string to key, and puts converted char into 
     the decrypted array 
  
   typical calling sequence:
      decrypt(char *message, char *key, char *encr);
      put address of the encrypted array in r0
      put the key in r1
      leave an address for returning the decrypeted value in r2

   local register usage:
      r4 = message
      r5 = key
      r6 = character for message
      r7 = character for key
      r8 = i    
      r9 = j
 */

@_____________________________________________________________________________
.global decrypt

decrypt:
    push {r4-r9, lr}

    mov r4, r0                     @ r4 = message
    mov r5, r1                     @ r5 = key

    mov r8, #0                     @ i = 0

decryptLoop:

    ldrb r6, [r4,r8]               @ character for message[]
    cmp r6, #0                     @ check to see if array is at end
    beq decryptDone

    cmp r6, #0x61                  @ line 241-45: checks for invalid char
    blt invalidDecrChar

    cmp r6, #0x7a
    bgt invalidDecrChar

    mov r9, #0                     @ j = 0

    checkKeyLoop:
        ldrb r7, [r5,r9]           @ r7 = key[j]

        cmp r7, r6                 @ checks if message[i] == key[j]
        beq checkKeyLoopTrue
        add r9, r9, #1             @ j++
        b checkKeyLoop

        checkKeyLoopTrue:
            add r9, r9, #0x61      @ gets the letter back
            strb r9, [r2, r8]      @ stores letter in decr[i]
            add r8, r8, #1         @ i++
            b decryptLoop

    invalidDecrChar:
        strb r6, [r2, r8]          @ stores invalid char in decr[i]

        add r8, r8, #1             @ i++
        b decryptLoop
@_____________________________________________________________________________
decryptDone:
    mov r6, #0                     @ represents end of array
    strb r6, [r2,r8]
    pop {r4-r9, pc}

        .section .data             @ allows writing of data
@_____________________________________________________________________________
fmt: .asciz "%c\n"
decimalfmt: .asciz "%d\n"
charfmt: .asciz "%c"
keycharfmt: .asciz "key char: %c\n"
nokey: .asciz "a key was not valid\n"
alphabet: .asciz "abcdefghijklmnopqrstuvwxyz"
end: .asciz "\nEnd of prepareKey\n"
