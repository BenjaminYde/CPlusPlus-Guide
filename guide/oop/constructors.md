# Constructors

Constructors are special member functions in C++ that are called when objects of a class are created. They typically perform initialization and allocation tasks.

## Default Constructor

To create objects in a default, predictable state when no initial values are provided.

- It takes no parameters.
- Called when objects are declared but not initialized.
- A compiler provides a default constructor if none is defined.

```c++
class MyClass {
public:
  MyClass() {
    // Initialization code
  }
};
```

When it's called:

```c++
MyClass obj; // Calls default constructor
MyClass* ptr = new MyClass(); // Calls default constructor
MyClass arr[10]; // When creating an array of objects
```

Example:

```c++
#include <iostream>

class Box {
private:
    double length;
    double width;
    double height;

public:
    // User-defined default constructor
    Box() {
        std::cout << "Default constructor called." << std::endl;
        length = 1.0;
        width = 1.0;
        height = 1.0;
    }

    void display() const {
        std::cout << "Dimensions: " << length << " x " << width << " x " << height << std::endl;
    }
};

int main() {
    Box myBox; // Calls the default constructor
    myBox.display(); // Output: Dimensions: 1.0 x 1.0 x 1.0
}
```

## Parameterized Constructor

A parameterized constructor accepts one or more arguments to initialize the object's members with specific, user-provided values.

```c++
class Box {
private:
    double length;
    double width;
    double height;

public:
    // Parameterized constructor
    Box(double l, double w, double h) {
        std::cout << "Parameterized constructor called." << std::endl;
        length = l;
        width = w;
        height = h;
    }
    
    // ... other members like display()
};

// Usage
int main() {
  Box myBox(10.0, 5.0, 2.0); // Calls parameterized constructor
}
```

### Default Arguments in Constructors

You can provide default values for constructor parameters.

```c++
class MyClass {
public:
  MyClass(int x = 0) {
    // Initialization code
  }
};
```

Usage: 
```c++
MyClass obj; // Calls default constructor
```

### Constructor Initialization Lists

A member initializer list is the preferred way to initialize class members. The list comes after the constructor's parameter list, separated by a colon (`:`).

```c++
class Box {
private:
    double length;
    double width;
    double height;
    const int id; // A const member

public:
    // Using a member initializer list
    Box(double l, double w, double h, int boxId) 
        : length(l), width(w), height(h), id(boxId) // Direct initialization
    {
        std::cout << "Initializer list constructor for Box ID: " << id << std::endl;
        // The constructor body can be empty or used for other setup tasks.
    }

    void display() const {
        std::cout << "Box ID " << id << " -> Dimensions: " << length << " x " << width << " x " << height << std::endl;
    }
};

int main() {
    Box myBox(10.0, 5.0, 2.0, 101);
    myBox.display();
}
```

## Constructor Overloading

Just like functions, constructors can be overloaded. This means you can define multiple constructors in the same class, as long as they have different parameter lists (either by number of arguments or by type). The compiler will choose the correct constructor based on the arguments provided during object creation.

```c++
#include <iostream>

class Box {
private:
    double length;
    double width;
    double height;

public:
    // 1. Default constructor (creates a unit cube)
    Box() : length(1.0), width(1.0), height(1.0) {
        std::cout << "Default constructor (unit cube)." << std::endl;
    }

    // 2. Parameterized constructor for a cube
    Box(double side) : length(side), width(side), height(side) {
        std::cout << "Cube constructor." << std::endl;
    }

    // 3. Parameterized constructor for a general box
    Box(double l, double w, double h) : length(l), width(w), height(h) {
        std::cout << "General box constructor." << std::endl;
    }

    void display() const {
        // ...
    }
};

int main() {
    Box b1;            // Calls Box()
    Box b2(5.0);       // Calls Box(double)
    Box b3(7.0, 8.0, 9.0); // Calls Box(double, double, double)
}
```

## Delegate Constructors

A delegating constructor allows one constructor to call another constructor from the same class in its member initializer list.

**Purpose**: to reduce code duplication and centralize initialization logic.

```c++
class Box {
private:
    double length, width, height;
public:
    // 1. The ultimate "target" constructor with all the logic
    Box(double l, double w, double h) : length(l), width(w), height(h) {
        std::cout << "Target constructor." << std::endl;
    }

    // 2. Default constructor delegates to the target constructor
    Box() : Box(1.0, 1.0, 1.0) { }

    // 3. Cube constructor delegates to the target constructor
    Box(double side) : Box(side, side, side) { }
};
```

## Explicit Constructors

By default, a constructor with a single parameter can be used for implicit type conversions. This can sometimes lead to surprising and undesirable behavior. The `explicit` keyword prevents the compiler from using a constructor for such implicit conversions.

**Purpose**: to prevent unintended type conversions and make code safer and more readable.

```c++
#include <vector>
#include <iostream>

class Buffer {
public:
    // By marking this explicit, we prevent implicit conversions from int to Buffer.
    explicit Buffer(size_t size) {
        std::cout << "Buffer created with size: " << size << std::endl;
    }
};

void processBuffer(const Buffer& buf) {
    // ... process the buffer
}

int main() {
    // This is clear and explicit. It is always allowed.
    Buffer b1(1024);
    processBuffer(b1);
    
    // This is an implicit conversion. It is now a COMPILE ERROR
    // because the constructor is explicit.
    // processBuffer(2048); // ERROR!

    // To make it work, you must be explicit:
    processBuffer(Buffer(2048)); // OK
}
```