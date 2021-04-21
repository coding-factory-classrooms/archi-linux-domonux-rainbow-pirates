#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main() {
	char buffer[256];
	int nbytes = sizeof(buffer);
	//read(STDIN_FILENO, buffer, nbytes);
	FILE *f = fopen(toto.txt);
	fgets(buffer, nbytes, stdin);
	int i = 0;
	while (buffer[i] != '\0') {
		write(0, &buffer[i], 1);
		i++;
	}
}
