Constructors are special member functions in C++ that are called when objects of a class are created. They typically perform initialization and allocation tasks.

# Constructor Types
## Default Constructor

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

Usage: 
```c++
MyClass obj; // Calls default constructor
```
## Parameterized Constructor

- Takes one or more parameters.
- Used to initialize objects with specific values.

```c++
class MyClass {
public:
  MyClass(int x) {
    // Initialization code
  }
};
```

Usage: 
```c++
MyClass obj(42); // Calls constructor
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
## Copy Constructor

- Takes a reference to an object of the same class as itself as a parameter.
- Used to create a new object as a copy of an existing object.

```c++
class MyClass {
public:
  int value;

  MyClass(int x) : value(x) { } // Parameterized constructor
  MyClass(const MyClass &obj) : value(obj.value) { } // Copy constructor
};
```

Usage: 
```c++
MyClass original(42); // Calls constructor

# When initializing an object and it's passed by value
MyClass copy = original; // Calls copy constructor

# When passed by by value to a function
foo(original);

# When passed by value via a constructor initialization
MyClass copy(original);

# When returning from a function by value
MyClass copy = foo();
```

It is a requirement that the parameter of a copy constructor be a (const) reference. This makes sense: if the argument were passed by value, then we’d need the copy constructor to copy the argument into the parameter of the copy constructor (which would result in an infinite recursion).
### Constructor Overloading

You can have multiple constructors in a class with different parameters, known as constructor overloading. The compiler will choose the appropriate one based on the arguments when the object is created.
### Constructor Initialization Lists

Initialization lists provide a way to initialize data members when an object is created.

```c++
class MyClass {
public:
  int x;
  MyClass(int a) : x(a) { }
};
```
### Delegate Constructors

A constructor can call another constructor in the same class to share initialization code.

```c++
class MyClass {
public:
  MyClass() : MyClass(0) { }
  MyClass(int x) {
    // Initialization code
  }
};
```

Usage: 
```c++
MyClass obj; // Calls default constructor, which delegates to parameterized constructor return 0;
```
### Explicit Constructors

By marking a constructor with the `explicit` keyword, you prevent it from being used for implicit conversions.

```c++
class MyClass {
public:
  explicit MyClass(int x) {
    // Initialization code
  }
};
```
## Move Constructor

The move constructor is used to "move" resources from one object to another, rather than copying them. This is often more efficient than copying, especially for objects that manage dynamic resources like memory, file handles, etc.

Here's how a move constructor typically behaves:

- **Steals the Resources**: It takes the resources from the source object (the object being moved from) and transfers them to the new object (the object being moved to).

- **Leaves the Source in a Valid State**: It should leave the source object in a valid but unspecified state. For example, if the object manages a dynamically allocated array, the move constructor might set the pointer in the source object to `nullptr`.

- **Doesn't Throw Exceptions**: Ideally, it should not throw exceptions, as indicated by the `noexcept` keyword.

```c++
class MyClass {
public:
  MyClass(MyClass &&obj) noexcept {
    // Transfer ownership code
  }
};
```

```c++
#include <iostream>
#include <utility> // Required for std::move

class MyString {
public:
  MyString(const char* str) {
    length = strlen(str);
    data = new char[length + 1];
    strcpy(data, str);
  }

  MyString(MyString&& other) noexcept // Move constructor
    : length(other.length), data(other.data) {
      other.length = 0;
      other.data = nullptr; // Ensuring that 'other' doesn't delete 'data'
  }

  ~MyString() { delete[] data; }

private:
  size_t length;
  char* data;
};

int main() {
  MyString str1("Hello, World!");
  MyString str2 = std::move(str1); // Calls move constructor

  // str1 is now in a valid but unspecified state
  // str2 has taken ownership of the resources originally owned by str1

  return 0;
}
```

- The move constructor transfers ownership of the `data` pointer from `other` to the new object.
- It sets `other.data` to `nullptr`, ensuring that the destructor of `other` doesn't delete the transferred memory.

### Do not delete memory in a move operation

If you were to call `delete[] other.data` inside the move constructor, it would lead to undefined behavior later on when the moved-from object (`other`) is destructed.

Here's what that would look like:

```c++
MyString(MyString&& other) noexcept
  : length(other.length), data(other.data) {
    other.length = 0;
    delete[] other.data; // Deleting the data here
    other.data = nullptr;
}
```

The problem arises because you are assigning `other.data` to the new object's `data` member, and then immediately deleting it. Both the moved-from object (`other`) and the newly constructed object will have `data` pointers that refer to the same memory location. When you delete `other.data`, you are deallocating that memory.

Later, when the destructor is called on either the moved-from object (`other`) or the newly constructed object, it will attempt to delete the same memory again, leading to undefined behavior.
# default vs delete
## = default

The `= default` specifier indicates that the compiler should generate the default implementation for a special member function. This can be useful when you want to ensure that the default behavior is used, even if other constructors are defined.

```c++
class MyClass {
public:
  MyClass() = default; // Compiler generates the default constructor
  MyClass(int x) : value(x) { }

  int value;
};

int main() {
  MyClass obj; // Calls the default constructor
  return 0;
}
```
## = delete

The `= delete` specifier is used to explicitly delete a special member function, meaning that it cannot be used. This can be helpful in preventing certain operations that would otherwise be automatically generated by the compiler.

```c++
class NonCopyable {
public:
  NonCopyable() = default; // Default constructor is fine
  NonCopyable(const NonCopyable&) = delete; // Delete copy constructor
};

int main() {
  NonCopyable obj1;
  // NonCopyable obj2 = obj1; // Error: copy constructor is deleted
  return 0;
}
```

In this example, the copy constructor is explicitly deleted, so attempting to copy an object of the `NonCopyable` class will result in a compilation error.

You can also use `= delete` to prevent specific overloads of a function. For example, you might want to prevent a particular constructor from being called with certain types of arguments:
### Using = delete to Prohibit Specific Overloads

You can also use `= delete` to prevent specific overloads of a function. For example, you might want to prevent a particular constructor from being called with certain types of arguments:

```c++
class SpecificConstructor {
public:
  SpecificConstructor(double value) { }
  SpecificConstructor(int) = delete; // Delete constructor for int
};

int main() {
  SpecificConstructor obj(42.0);  // OK: double constructor
  // SpecificConstructor obj2(42); // Error: int constructor is deleted
  return 0;
}
```

By explicitly deleting the constructor that takes an `int`, you ensure that the class can only be constructed with a `double`.

# Usage examples

```c++
struct A
{
    int x;
    A(int x = 1): x(x) {} // user-defined default constructor
};
 
struct B : A
{
    // B::B() is implicitly-defined, calls A::A()
};
 
struct C
{
    A a;
    // C::C() is implicitly-defined, calls A::A()
};
 
struct D : A
{
    D(int y) : A(y) {}
    // D::D() is not declared because another constructor exists
};
 
struct E : A
{
    E(int y) : A(y) {}
    E() = default; // explicitly defaulted, calls A::A()
};
 
struct F
{
    int& ref; // reference member
    const int c; // const member
    // F::F() is implicitly defined as deleted
};
 
// user declared copy constructor (either user-provided, deleted or defaulted)
// prevents the implicit generation of a default constructor
 
struct G
{
    G(const G&) {}
    // G::G() is implicitly defined as deleted
};
 
struct H
{
    H(const H&) = delete;
    // H::H() is implicitly defined as deleted
};
 
struct I
{
    I(const I&) = default;
    // I::I() is implicitly defined as deleted
};
 
int main()
{
    A a;
    B b;
    C c;
//  D d; // compile error
    E e;
//  F f; // compile error
//  G g; // compile error
//  H h; // compile error
//  I i; // compile error
}
```