## Shallow copy

Because C++ does not know much about your class, the default copy constructor and default assignment operators it provides use a copying method known as a memberwise copy (also known as a **shallow copy**). This means that C++ copies each member of the class individually (using the assignment operator for overloaded operator=, and direct initialization for the copy constructor). 

When classes are simple (e.g. do not contain any dynamically allocated memory), this works very well. A shallow copy means creating a new object that shares the same memory location or references as the original object. In the context of C++, a shallow copy typically involves copying the member values of one object to another, without allocating separate memory for any pointer members. This means that the pointer members of the new object will point to the same memory location as the pointer members of the original object.

Shallow copying is the default behavior of the copy constructor and assignment operator if you do not provide your own implementation.

### Deep Copy

A deep copy means creating a new object that has its own copy of the data of the original object. In the context of C++, a deep copy involves not only copying the values of the members of the original object to the new object, but also allocating separate memory for the pointer members of the new object and copying the data pointed to by the original object. This means that the pointer members of the new object will point to new memory locations.

### Example

Let's consider a simple example to illustrate the difference between shallow copy and deep copy.

```c++
#include <iostream>

class MyClass {
public:
    int *data;

    MyClass(int val) {
        data = new int;
        *data = val;
    }

    // Shallow copy constructor
    MyClass(const MyClass &obj) : data(obj.data) {
        std::cout << "Shallow copy constructor called" << std::endl;
    }

    // Deep copy constructor
    // MyClass(const MyClass &obj) {
    //     data = new int;
    //     *data = *obj.data;
    //     std::cout << "Deep copy constructor called" << std::endl;
    // }

    ~MyClass() {
        delete data;
    }
};

int main() {
    MyClass obj1(10);
    MyClass obj2 = obj1;  // Calls the copy constructor

    std::cout << "obj1 data: " << *obj1.data << std::endl;
    std::cout << "obj2 data: " << *obj2.data << std::endl;

    *obj1.data = 20;

    std::cout << "obj1 data: " << *obj1.data << std::endl;
    std::cout << "obj2 data: " << *obj2.data << std::endl;

    return 0;
}

```

In this example, the `MyClass` class has a pointer member `data`. The `MyClass` class has a copy constructor that performs a shallow copy of the `data` member. Therefore, when the `obj2` object is created as a copy of the `obj1` object, the `data` member of `obj2` will point to the same memory location as the `data` member of `obj1`.

As a result, modifying the `data` member of `obj1` will also modify the `data` member of `obj2`, and vice versa.
### Problems with Shallow Copy

Using shallow copy can lead to problems in some situations. For example, in the above example, when the `obj1` and `obj2` objects are destroyed, their destructors will both try to delete the same memory location, which leads to undefined behavior.
### When to Use Deep Copy

In general, you should use deep copy when your class has pointer members that own the memory they point to. This ensures that each object has its own copy of the data and prevents problems like double deletion of memory.
### Implementing Deep Copy

To implement deep copy, you need to provide your own implementation of the copy constructor and assignment operator that allocates separate memory for the pointer members of the new object and copies the data pointed to by the original object.

In the above example, you can uncomment the deep copy constructor and comment the shallow copy constructor to see how the deep copy works.
### Classes in the Standard Library

The C++ standard library provides a wide range of classes and functions, including those for dealing with dynamic memory, such as `std::string` and `std::vector`.

```c++
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec1 = {1, 2, 3};
    std::vector<int> vec2 = vec1;  // Calls the copy constructor

    vec1[0] = 10;

    std::cout << "vec1: " << vec1[0] << " " << vec1[1] << " " << vec1[2] << std::endl;
    std::cout << "vec2: " << vec2[0] << " " << vec2[1] << " " << vec2[2] << std::endl;

    return 0;
}
```

Output:
```c++
vec1: 10 2 3
vec2: 1 2 3
```