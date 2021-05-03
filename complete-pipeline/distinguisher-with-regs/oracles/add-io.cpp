#include <iostream>

int main(int argc, char *argv[]){
	// int a, b;
	// std::cin >> a >> b;
	// printf("(_ bv%d 8)\n", atoi(argv[1]) + atoi(argv[2]));
	printf("(_ bv%d 8)\n", atoi(argv[3+atoi(argv[1])]) + atoi(argv[3+atoi(argv[2])]));
}