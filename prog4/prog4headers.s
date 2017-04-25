/*
Alexander Monroe Stone (astone8) 
2310-1 
Program 4
4/26/2017
*/


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
     r0 - address of string
  
   return value (if any):
     lrc check character
     
   other output parameters:
     none
  
   effect/output
      none apart from return value 
  
   method / effect:
     the check character is obtained by xor-ing all characters in the string. 
  
   typical calling sequence:
    e.g.
      put address of character block in r0
      put number of characters in r1
      call lrc
  
   local register usage:
     e.g.
       r0 - pointer to string
       r1 - count of characters in string
       r2 - xor of each character 
 */



 /* function name:
    encrypt()

   description:
    uses a key produced by prepareKey(()) to encrypt the 
    characters in str.  Nonalphabetic characters in str 
    are not changed, but alphabetic characters are encrypted using 
    the key provided by replacing the original character with the 
    coded character.  

   input parameter(s):
     r0 - address of string
  
   return value (if any):
     lrc check character
     
   other output parameters:
     none
  
   effect/output
      none apart from return value 
  
   method / effect:
     the check character is obtained by xor-ing all characters in the string. 
  
   typical calling sequence:
    e.g.
      put address of character block in r0
      put number of characters in r1
      call lrc
  
   local register usage:
     e.g.
       r0 - pointer to string
       r1 - count of characters in string
       r2 - xor of each character 
 */




 /* function name:
    decrypt()

   description:
    takes an encrypted string and reconstructs the original message.  
    Except for decrypting, this function should work the same as 
    encrypt. 
  
   input parameter(s):
     r0 - address of string
  
   return value (if any):
     lrc check character
     
   other output parameters:
     none
  
   effect/output
      none apart from return value 
  
   method / effect:
     the check character is obtained by xor-ing all characters in the string. 
  
   typical calling sequence:
    e.g.
      put address of character block in r0
      put number of characters in r1
      call lrc
  
   local register usage:
     e.g.
       r0 - pointer to string
       r1 - count of characters in string
       r2 - xor of each character 
 */