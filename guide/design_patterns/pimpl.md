# PIMPL (Pointer to IMPLementation)

The PIMPL Idiom (short for Pointer to IMPLementation) is a design pattern in C++ used to achieve encapsulation, binary compatibility, and reduced compilation dependencies. It is widely used in large-scale projects where decoupling implementation details from interface declarations is crucial.

## Key Concepts of PIMPL:

1. **Encapsulation**:
   - The implementation details of a class are hidden in a separate class (the "implementation class"), and the public-facing class holds a pointer to an instance of this implementation class.
2. **Binary Compatibility**:
   - Changes in the implementation class do not require recompilation of the code that depends on the public-facing class, improving modularity.
3. **Reduced Compile-Time Dependencies**:
   - By hiding implementation details, you reduce the need for header files to include other dependencies. This minimizes compilation times and reduces coupling between modules.

## How PIMPL Works:

1. **Public Interface (MyClass)**: Contains only the declarations and a pointer to the private implementation.
2. **Private Implementation (MyClassImpl)**: Contains all the actual data members and methods.

Here’s an example of the PIMPL idiom:

**Entry point**: `main.cpp`'

```c++
#include "MyClass.h"

int main() {
    MyClass obj;
    obj.doSomething();
    return 0;
}
```

**Header File**: `MyClass.h`

```c++
#ifndef MYCLASS_H
#define MYCLASS_H

#include <memory> // For std::unique_ptr

class MyClass {
public:
    MyClass();              // Constructor
    ~MyClass();             // Destructor
    void doSomething();     // Public method

private:
    class Impl;             // Forward declaration of implementation
    std::unique_ptr<Impl> pImpl; // Pointer to the implementation
};

#endif // MYCLASS_H

```

**Source File**: `MyClass.cpp`

```c++
#include "MyClass.h"
#include <iostream>

// Definition of the implementation class
class MyClass::Impl {
public:
    void doSomethingImpl() {
        std::cout << "Doing something in the implementation!" << std::endl;
    }
};

// Constructor
MyClass::MyClass() : pImpl(std::make_unique<Impl>()) {}

// Destructor
MyClass::~MyClass() = default;

// Public method
void MyClass::doSomething() {
    pImpl->doSomethingImpl();
}
```