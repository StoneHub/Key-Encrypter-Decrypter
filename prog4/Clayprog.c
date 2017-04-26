int prepareKey(char* key)
{

    int i;
    char alpha[27] = "abcdefghijklmnopqrstuvwxyz";

//    printf("key: %s\n", key);
//    printf("alphabet: %s\n",alpha);


    // checks to see if key is empty
    if(key[0] == 0)
    {
        return 0;
    }


    // checks to see if letters are valid
    for(i = 0; key[i] != 0; i++)
    {
        if((0x61 > key[i]) || (key[i] > 0x7a))
        {
            return 0;
        }
    }

    // goes through the alphabet array
    for(i = 0; alpha[i] != 0; i++)
    {

        int j;
        bool found = false;

        // goes through the key array
        for(j = 0; key[j] != 0; j++)
        {
            // if the alpha letter matches the key letter enter the if statement
            if(alpha[i] == key[j])
            {
                // if found is true before this if statement then replace key[j]
                //   with a space
                if(found == true)
                {
                    key[j] = ' ';
                }

                // set found to true because the given character from alpha[]
                //    has been found in key[]
                found = true;
            }

        }

        // if found is true the letter was found before so a space replaces the letter
        //  to keep duplicates from occurring
        if(found == true)
        {
            alpha[i] = ' ';
        }
    }



    char finalKey[27];

    int pos = 0;

    // removes spaces from key
    for(i = 0; key[i] != 0; i++)
    {

        if(key[i] != ' ')
        {
            finalKey[pos] = key[i];
            pos++;
        }
    }

    // stores remaining letters in key
    for(i = 0; alpha[i] != 0; i++)
    {
        if(alpha[i] != ' ')
        {
            finalKey[pos] = alpha[i];
            pos++;

        }
    }

    finalKey[26] = 0;

    // replaces contents of key with contents of finalKey so the correct key gets modified
    for (i=0; finalKey[i] != 0; i++)
    {
        key[i] = finalKey[i];
    }
    key[26] = 0;


    return 1;
}




void encrypt(char *message, char *key, char *encr)
{

    int i = 0;

    // makes sure we have reached the end of the message
    while(message[i] != 0)
    {
        // checks if message[i] is a valid character
        if((0x61 <= message[i]) && (0x7a >= message[i]))
        {
            // message[i] - 0x61 gives us the base 10 number that we can
            //  use to navigate through the key[] and what is stored in
            //  that index will be stored in encr[i]
            encr[i] = key[message[i] - 0x61];
        }
        // if statement was skipped because of invalid character
        //   which is directly placed into encrypted message
        else
        {
            encr[i] = message[i];
        }

        i++;
    }


    // represents the end of the array
    encr[i] = 0;

}




void decrypt(char *message, char *key, char *decr)
{

    int i = 0;

    // executes the loop until the end of the message
    while(message[i] != 0)
    {
        // checks for valid character
        if((0x61 <= message[i]) && (0x7a >= message[i]))
        {
            int j = 0;

            // increments j until key[j] is equal to message[i]
            while(key[j] != message[i])
            {
                j++;
            }
            // j + 0x61 gives us the correct letter to put in decr[i]
            decr[i] = j + 0x61;
        }
        else // inserts invalid character into the decrypted message
        {
            decr[i] = message[i];
        }

        i++;
    }

    // represents the end of the array
    decr[i] = 0;

}