#include <iostream>

#include "Maths.h"

void Test1();
void Test2();

using namespace liman;

int main()
{
	std::cout << "Tests here" << std::endl;

	Test1();
	Test2();

	system("PAUSE");

	return 0;
}

void Test1()
{
	maths::Vec2f myPoint;
	std::cout << myPoint << std::endl;
}

void Test2()
{
	maths::Vec3f myPoint;
	std::cout << myPoint << std::endl;
}