#include <stdio.h>
#include <stdlib.h>

int prepareKey(char *key);
/* accepts a string containing the desired key word / string and 
converts it as described above to the array of encoded characters.Assume the key argument 
is an array of at least 27 characters long, including the null character.Eliminate any
duplicate letters from the word, and then fill in the rest of the alphabet.If the processing
succeeds, the function returns a true result(!= 0).If the key argument is empty or contains
any nonalphabetic characters, the function should return a false result.*/


void encrypt(char *str, char const *key, char *encryp);
/*uses a key produced by prepareKey(()) to encrypt the characters in str.Nonalphabetic 
characters in str are not changed, but alphabetic characters are encrypted using the key
provided by replacing the original character with the coded character.*/

void decrypt(char *str, char const *key, char *decryp);
/*takes an encrypted string and reconstructs the original message.Except for decrypting,
this function should work the same as encrypt.*/

int main(int argc, char *argv[])
{
	char* key = argv[1];
	prepareKey(key);
	return 0;
}

int prepareKey(char* key)
{
	printf(key);
	
	//check for key
	printf("\n");
	if (key == '\0')	//if key is empty
	{
		printf("empty key\n");
		return 0;		//return false for key was not found
	}  

	int keylength = strlen(key);	//get length of key
	char* keycpy = key;
	for (int i = 0; i < keylength; i++)
	{
		printf("%c\n", *keycpy++);	//print out key char by char on a new line
	}

	//elimnate duplicate letters
	if (keylength >= 2)				//if key length is less that 2 move on to building the rest of the alphabet
	{
		for (int i = 0; i < keylength; i++)	//loop though key
		{
			if () ;					//if current keycpy index exist in the key
		}
	}
	
	//fill in rest of alphabet

	return 1;		//return true for key was prepared
}

void encrypt(char *str, char const *key, char *encryp)
{


}

void decrypt(char * str, char const * key, char * decryp)
{

}