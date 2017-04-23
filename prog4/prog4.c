#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
	printf(key);
	printf("\n");
	return 0;
}

int prepareKey(char* key)
{
	printf(key);
	printf("\n");
	//check for key
	if (key == '\0')	//if key is empty
	{
		printf("empty key\n");
		return 0;		//return false for key was not found
	}  

	int keylength = strlen(key);	//get length of key
	char* keycpy = malloc(1 + keylength);
	strcpy(keycpy, key);
	char* keycpy2 = malloc(1 + keylength);
	strcpy(keycpy2, key);
	char* keyhead = keycpy2;
	char* keycpy3 = malloc(1 + keylength);
	
	//elimnate duplicate letters
	*keycpy2++;
	for (int i = 0; i < keylength; i++)	//loop through keyA
	{
		for (int j = i+1; j < keylength; j++)	//loop through keyB to the right of current position in keyA[i]
		{
			if (*keycpy2 == *keycpy)			//if it finds duplicate letter
			{
				*keycpy2 = ' ';				//keyB gets current index value changed to null
			}
			*keycpy2++;
		}
		*keycpy3 = *keycpy;

		*keycpy++;															
		keycpy2 = keycpy;					
		*keycpy2++;

		*keycpy3++;
	}
	int ifcounter = 0;
	*keycpy3++ = '\0';
	keycpy3 = keycpy3 - (keylength + 1);
	int keylength2 = keylength;
	for (int i = 0; i < keylength2; i++)
	{
		int counter = 0;
		if (*keycpy3 == ' ')
		{
			ifcounter++;
			while (*keycpy3 != '\0')
			{
				*keycpy3 = *(keycpy3 + 1);
				*keycpy3++;
				counter++;
			}
			keycpy3 = keycpy3 - counter;
			keylength--;
		}
		else
		{
			*keycpy3++;
		}
	}
	keycpy3 = keycpy3 - (keylength2 - ifcounter);

	//fill in rest of alphabet

	while (keycpy3 != '\0')
	{
		*key
	}
	return 1;		//return true for key was prepared
}

void encrypt(char *str, char const *key, char *encryp)
{


}

void decrypt(char * str, char const * key, char * decryp)
{

}