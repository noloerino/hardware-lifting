#include <iostream>

int main(int argc, char *argv[]){
	// int a, b;
	// std::cin >> a >> b;
	// if (atoi(argv[0]) == 0) {
	// 	if (atoi(argv[1]) == 0) {
	// 		printf("(_ bv%d 8)\n", atoi(argv[2]) - atoi(argv[2]));
	// 	}
	// 	if (atoi(argv[1]) == 0) {
	// 		printf("(_ bv%d 8)\n", atoi(argv[2]) - atoi(argv[2]));
	// 	}

	// }
	// printf("(_ bv%d 8)\n", atoi(argv[1]) + atoi(argv[2]));
	printf("(_ bv%d 8)\n", atoi(argv[3+atoi(argv[1])]) - atoi(argv[3+atoi(argv[2])]));
}