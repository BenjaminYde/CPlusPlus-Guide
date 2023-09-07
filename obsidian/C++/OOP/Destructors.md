# What is a destructor

A destructor is a special member function of a class in C++ that is used to clean up any resources allocated by the object when it's no longer needed, like closing files, releasing memory, etc. It's called automatically when an object goes out of scope or is explicitly deleted.

Here is the basic syntax for a destructor:

```c++
class MyClass 
{
public:
    MyClass() { std::cout << "Constructor called\n"; }
    ~MyClass() { std::cout << "Destructor called\n"; }
};

int main() 
{
    MyClass obj; // Constructor called here
} // Destructor called here
```

- It has the same name as the class, preceded by a tilde (~).
- It doesn't take any arguments.
- It doesn't return anything.
# When is the Destructor Called?

- **Local Objects:** For objects with automatic storage duration (local objects), the destructor is called when the control goes out of the block where the object was created.

- **Dynamic Objects:** If you're managing the memory using `new` and `delete`, the destructor is called when `delete` is applied to a pointer to an object.

- **Static Objects:** For objects with static storage duration, the destructor is called when the program exits.

- **Temporary Objects:** Temporary objects are destroyed at the end of the full-expression in which they were created.

- **Container Elements:** When the container (e.g., a vector or list) is destroyed, the destructors of the elements are also called.
# Rules

1. **No Overloading:** You can't overload a destructor; a class can only have one destructor.
2. **No Inheritance:** Destructors are not inherited.
3. **Calling Order:** In inheritance, the destructor of the derived class is called first, then the base class destructor.
4. **Virtual Destructors:** If a class is intended to be used as a base class, the destructor should generally be virtual. This ensures that the correct destructor is called for derived objects when being deleted through a pointer to the base class.
5. **Explicit Call:** Though generally not recommended, you can call a destructor explicitly. You must ensure that you don't attempt to access the object afterward, as its behavior is undefined.