## Copy constructor (Recap)

A copy constructor is a special constructor that is used to initialize a new object as a copy of an existing object. The copy constructor is called whenever a new object is created as a copy of an existing object, which happens in the following scenarios:

1. When an object is created and initialized with another object: `MyClass obj2(obj1);`
2. When an object is passed by value to a function: `foo(obj1)`
3. When an object is returned by value from a function 

Syntax:
```c++
MyClass(const MyClass &obj);
```

Example:
```c++
class MyClass {
public:
    int x;
    
    MyClass(int val) : x(val) {}
    
    // Copy constructor
    MyClass(const MyClass &obj) : x(obj.x) {
        std::cout << "Copy constructor called" << std::endl;
    }
};

int main() {
    MyClass obj1(10);
    MyClass obj2(obj1);  // Copy constructor is called
    return 0;
}
```

## Assignment operator (=)

A copy constructor and an assignment operator are two different ways to create a new object as a copy of an existing object, or to copy the contents of one object to another, respectively.

The assignment operator (`=`) is used to copy the contents of one object to another existing object. The assignment operator is called whenever an already initialized object is assigned a new value from another existing object.

Here is the syntax for overloading the assignment operator:

```c++
MyClass &operator=(const MyClass &obj);
```

Example:
```c++
class MyClass {
public:
    int x;
    
    MyClass(int val) : x(val) {}
    
    // Assignment operator
    MyClass &operator=(const MyClass &obj) {
        x = obj.x;
        std::cout << "Assignment operator called" << std::endl;
        return *this;
    }
};

int main() {
    MyClass obj1(10);
    MyClass obj2(20);
    obj2 = obj1;  // Assignment operator is called
    return 0;
}
```