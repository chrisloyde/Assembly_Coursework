#include <iostream>

//prototype for COPYSTR extern function (in this case in asm file)
extern "C" int _stdcall PROCEDURE1(int);

int main()
{
	char dest[100] = { 0 };
	char* source = "Enter a number";
	char* source1 = "The number is prime";
	char* source2 = "Tne number is not prime";

	// wrote my own simple tester for my own sake
	int prime = -1;
	for (int i = 2; i <= 200; i++) {
		prime = PROCEDURE1(i);
		if (prime == 1) {
			printf("%d %s\n", i, source1);
		}
		else {
			printf("%d %s\n", i, source2);
		}
	}
	return 0;

	/*
	int test1 = 4;
	int prime = PROCEDURE1(test1);

	if (prime == 1)
	{
		printf("%s\n", source1);
	}
	else
	{
		printf("%s\n", source2);
	}
	*/
}