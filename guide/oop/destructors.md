# Destructors

A destructor is a special member function of a class in C++ that is used to clean up any resources allocated by the object when it's no longer needed, like closing files, releasing memory, etc. It's called automatically when an object goes out of scope or is explicitly deleted.

A destructor is defined by

- It has the same name as the class, prefixed with a tilde (`~`).
- It takes no arguments and has no return type.
- A class can only have one destructor and cannot be overloaded.

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

## When is the Destructor Called?

A destructor is called automatically when an object's lifetime ends. The context determines the exact moment:

- **Automatic Storage (Stack Objects)**: When the object goes out of scope. Destruction occurs in the reverse order of construction.

- **Dynamic Storage (Heap Objects)**: When `delete` is called on a pointer to the object. For an array allocated with `new[]`, `delete[]` must be used, which calls the destructor for every element in the array. Mismatching `delete` and `delete[]` results in undefined behavior.

- **Static/Global/Thread-Local Storage**: When the program (or thread for `thread_local`) terminates.

- **Container Elements**: When a standard library container (e.g., `std::vector`, `std::map`) is destroyed, it invokes the destructor for all elements it holds.

- **Temporary Objects**: At the end of the full-expression in which they were created.

## Advanced Destructor Concepts

### Virtual Destructors

When you delete an object of a derived class through a pointer to its base class, the program needs to know which destructor to call. If the base class destructor isn't virtual, the program will only call the base class destructor and completely skip the derived class's destructor. This can lead to memory leaks and other issues because the derived class's resources aren't properly cleaned up.

By making the base class destructor virtual, you ensure the correct destructor is always called—first the derived class's, and then the base class's—so the entire object is properly cleaned up.

```c++
class Base {
public:
    Base() {}
    // The key: a virtual destructor.
    virtual ~Base() { std::cout << "Base destructor\n"; } 
};

class Derived : public Base {
private:
    int* data_;
public:
    Derived() { data_ = new int[100]; }
    ~Derived() override {
        delete[] data_; // This would leak without a virtual base destructor!
        std::cout << "Derived destructor\n";
    }
};

int main() {
    Base* b = new Derived();
    delete b; // Correctly calls ~Derived(), then ~Base()
}
```

Output:

```
Derived destructor
Base destructor
```