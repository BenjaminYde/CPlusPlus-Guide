In C++, the `<<` and `>>` operators are used for output and input operations, respectively. However, when you create a user-defined type (e.g., a class), C++ does not know how to handle input and output operations for this type. To handle this, you can overload the `<<` and `>>` operators for your class.

```c++
#include <iostream>

class Point {
public:
    int x, y;

    Point(int x = 0, int y = 0) : x(x), y(y) {}

    // Overload << operator
    friend std::ostream &operator<<(std::ostream &out, const Point &p);

    // Overload >> operator
    friend std::istream &operator>>(std::istream &in, Point &p);
};

// Overload << operator
std::ostream &operator<<(std::ostream &out, const Point &p) {
    out << "(" << p.x << ", " << p.y << ")";
    return out;
}

// Overload >> operator
std::istream &operator>>(std::istream &in, Point &p) {
    in >> p.x >> p.y;
    return in;
}

int main() 
{
    Point p1, p2(3, 4);

    std::cout << "Enter x and y coordinates for p1: ";
    std::cin >> p1;

    std::cout << "Point p1: " << p1 << std::endl;
    std::cout << "Point p2: " << p2 << std::endl;

    return 0;
}
```