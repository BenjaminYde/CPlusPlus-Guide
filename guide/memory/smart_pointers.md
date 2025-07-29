# Smart Pointers

## Problem with raw pointers

Raw pointers in C++ have several issues that can lead to bugs, memory leaks, and undefined behavior if not managed properly. Some of the main problems with raw pointers are:

- **Memory leaks**: If you allocate memory using `new` but forget to deallocate it with `delete`, it can cause a memory leak. Memory leaks can lead to increased memory usage and, in extreme cases, cause your program to crash.
- **Dangling pointers**: A dangling pointer is a pointer that points to memory that has already been deallocated or is otherwise no longer valid. Accessing the memory through a dangling pointer results in undefined behavior, which can cause crashes, data corruption, or other hard-to-debug issues.
- **Double deletion**: If you accidentally delete the same memory twice, it can cause undefined behavior, leading to crashes or data corruption.
- **Ownership ambiguity**: With raw pointers, it can be unclear which part of the code is responsible for managing the memory, including deallocation. This can lead to inconsistencies in memory management and make the code harder to maintain.
- **Exception safety**: If an exception is thrown before a raw pointer's memory is deallocated, the memory might not be freed, leading to a memory leak. Ensuring that memory is always deallocated properly in the presence of exceptions can be challenging with raw pointers.

## Smart Pointers To The Rescue

### RAII

RAII (Resource Acquisition Is Initialization) is a C++ idiom that ties a resource's lifetime to an object's lifetime.

Smart pointers are objects that implement RAII for dynamically allocated memory. Here's how they work:

- **Acquisition** (in the Constructor): When you create a smart pointer, it takes ownership of a dynamically allocated object (it stores the raw pointer internally). This happens in the smart pointer's constructor.
- **Initialization**: The dynamically allocated object is now ready to be used.
- **Automatic Release** (in the Destructor): When the smart pointer goes out of scope (e.g., at the end of a function), its destructor is automatically called. This destructor is responsible for calling delete on the raw pointer it holds, freeing the memory.

In essence, a smart pointer is like a box with a built-in cleanup mechanism. You put your dynamically allocated object inside the box (the smart pointer). When the box is no longer needed, it automatically cleans up the object for you, preventing memory leaks.

### Benefits of Smart Pointers:

- **Automatic Memory Management**: You don't have to manually call delete. Smart pointers handle deallocation for you.
- **Prevent Memory Leaks**: Memory is automatically released when the smart pointer is no longer needed.
- **Exception Safety**: Even if an exception is thrown, the smart pointer's destructor will still be called, ensuring that memory is deallocated.
- **Clear Ownership Semantics**: Smart pointers (especially unique_ptr) make it clear who is responsible for managing a piece of memory.

### When Not to Use Smart Pointers

- **Interfacing with C APIs**: C code does not understand C++ smart pointers. When working with C libraries or system calls, you'll often need to use raw pointers (but you can still wrap them in smart pointers within your C++ code).
- **Performance-Critical Embedded Systems**: In some highly constrained embedded systems, the overhead of smart pointers (which, although usually small, might involve virtual function calls in some cases) might be unacceptable. However, even in these cases, carefully designed custom smart pointer-like classes can be beneficial.

## Types of Smart Pointers

The C++ Standard Library provides three main types of smart pointers in the `<memory>` header: `std::unique_ptr`, `std::shared_ptr`, and `std::weak_ptr`. Each of these has different use cases:

- `std::unique_ptr` represents exclusive ownership of a dynamically allocated object and cannot be copied. However, ownership can be transferred via move semantics. It's useful when you want to ensure a single part of the code is responsible for managing the memory of the object.   

- `std::shared_ptr` allows multiple pointers to refer to the same dynamically allocated object. The object will be deleted when the last `shared_ptr` pointing to it is destroyed or reset. This is useful in situations where an object needs to be accessed from multiple parts of the code.

- `std::weak_ptr` is a companion to `std::shared_ptr` that observes the object but does not contribute to the reference count. This is useful for breaking reference cycles which could lead to memory leaks.

Use the following include to use smart pointers

```c++
#include <memory>
```

## Unique pointers

`std::unique_ptr` is a smart pointer in the C++ standard library that provides a mechanism for exclusive ownership of dynamically allocated resources. It does not share its pointer, cannot be copied to another `unique_ptr`, passed by value to a function, or used in any C++ Standard Library algorithm that requires copies to be made. 

A `unique_ptr` can only be moved. This means that the ownership of the memory resource is transferred to another `unique_ptr` and the original `unique_ptr` no longer owns it.

### Key Features

- **Exclusive Ownership**: A `unique_ptr` is the sole owner of the underlying resource. This means that at any given time, only one `unique_ptr` can point to a specific resource. This is strictly enforced by the compiler.
- **Non-Copyable**: `unique_ptr` cannot be copied. This design choice prevents accidental duplication of ownership, which could lead to double-deletion errors or other forms of undefined behavior.
- **Movable**: While copying is prohibited, `unique_ptr` supports move semantics. Ownership can be transferred from one `unique_ptr` to another using `std::move`. After a move, the source `unique_ptr` is reset to `nullptr`, relinquishing ownership.
* **Automatic Deallocation**: When a `unique_ptr` goes out of scope (e.g., at the end of a function or block), its destructor is automatically called. The destructor is responsible for deallocating the owned resource (typically by calling delete on the raw pointer it holds). This happens even if an exception is thrown, making `unique_ptr` exception-safe.
- **Lightweight**: `unique_ptr` has minimal overhead. In most implementations, it's essentially just a wrapper around a raw pointer, with no additional data members. This makes it as efficient as manual memory management in terms of performance.
- **Array Support**: `unique_ptr` can also manage dynamically allocated arrays using the `new[]` and `delete[]` operators. The specialization `std::unique_ptr<T[]>` ensures that the correct `delete[]` is used when the array goes out of scope.

### Common Use Cases

- **Pimpl Idiom** (Pointer to Implementation): `unique_ptr` is commonly used to manage the implementation details of a class, hiding them from the public interface.
- **Factory Functions**: Functions that create and return dynamically allocated objects can use `unique_ptr` to clearly transfer ownership of the newly created object to the caller. The caller becomes solely responsible for the object's lifetime.
- **Containers of Unique Pointers**: Storing dynamically allocated objects in containers like `std::vector` while ensuring automatic cleanup when the container is destroyed.

### Creating `unique_ptr`

The preferred way to create a unique_ptr is using the `std::make_unique` helper function:

```c++
#include <memory>

// For a single object
std::unique_ptr<MyClass> ptr = std::make_unique<MyClass>(constructor_args); 

// For an array
std::unique_ptr<MyClass[]> arrPtr = std::make_unique<MyClass[]>(array_size);
```

`std::make_unique` provides better exception safety and can sometimes be more efficient than directly using `new` with the `unique_ptr` constructor. So do NOT use the following syntax: 

```c++
// Do not use!
std::unique_ptr<MyClass> ptr(new MyClass(constructor_args));
```

### Accessing the Underlying Resource

You can access the raw pointer managed by the unique_ptr using the get() method or by using the overloaded `->` and `*` operators (just like with a raw pointer):

```c++
MyClass* rawPtr = ptr.get(); // Get the raw pointer (use with caution!)
ptr->memberFunction(); // Access member functions
(*ptr).memberVariable = 10; // Access member variables
```

### Transferring Ownership

The following code will fail to compile because there would be multiple owners of the pointer:

```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2 = myPtr1;  // Error: Cannot copy unique_ptr
```

```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2;
ptr2 = ptr1;  // Error: Cannot assign unique_ptr
```

```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2(myPtr1);  // Error: Cannot transfer ownership from ptr1 to ptr2
```

We could use the `std::move` method to move the value pointed to by `myPtr1` to that of `myPtr2`:

```c++
std::unique_ptr<int> myPtr1 = std::make_unique<int>(5);  
std::unique_ptr<int> myPtr2 = std::move(myPtr1); // ptr1 now becomes nullptr
std::cout << *myPtr2 << std::endl;
```

The dynamically allocated integer is not deleted in this process. It is now owned by `myPtr2` and will be deleted when `myPtr2` is destroyed, or if `myPtr2` is reset or reassigned to another dynamically allocated integer.

After the `std::move` operation, you should not use `myPtr1` to access the integer as it no longer owns it. Trying to do so (e.g., by dereferencing `myPtr1`) would lead to undefined behavior since `myPtr1` now holds a `nullptr`.

### Releasing Ownership

If you want to relinquish ownership without destroying the object, use the `release()` method:

```c++
MyClass* rawPtr = ptr.release(); // ptr now becomes nullptr, and you are responsible for managing rawPtr
// ... later ...
delete rawPtr; // You must now manually delete the object
```

## Shared pointers

`std::shared_ptr` is a smart pointer in the C++ standard library that implements shared ownership of a dynamically allocated resource using reference counting. Multiple `shared_ptr` instances can point to the same resource, and the resource is automatically deallocated when the last `shared_ptr` owning it is destroyed or reset.

### Key Features

- **Reference Counting**: Each `shared_ptr` instance associated with a resource increments a reference counter. When a `shared_ptr` is destroyed or reset, it decrements the counter.
- **Automatic Deallocation**: When the reference count drops to zero (meaning no more `shared_ptr` instances are pointing to the resource), the managed resource is automatically deleted using the appropriate deleter (by default, `delete` for single objects and `delete[]` for arrays).
- **Thread Safety**: The reference count manipulations (increment and decrement) are atomic, ensuring thread safety in multi-threaded scenarios with regard to the pointer itself. Modifying the underlying resource may still require external synchronization.
- **Aliasing Constructor**: Allows creating a `shared_ptr` that shares ownership with another `shared_ptr` but points to a different (but related) object. Useful for managing sub-objects or members of a larger structure.

### When to Use `std::shared_ptr`

#### Use when:

**Shared Resource Ownership**: When multiple parts of your code need to own and manage the lifetime of a dynamically allocated object.
**Complex Object Lifetimes**: When it's difficult or impossible to determine a single owner or a clear deallocation point.
**Implementing Caches, Observer Patterns**: Where objects need to be shared and their lifetimes are tied to multiple observers or cached instances.

#### Do not use when:

- **Single, Clear Ownership**: When you have a clear single owner for an object, unique_ptr is simpler, more efficient, and better expresses ownership semantics.
- **Simple Data Structures within a Limited Scope**: If you're dealing with small, simple data structures within a single function or a very limited scope, stack allocation or `unique_ptr` might be more appropriate.
  - **Performance Overhead**: Reference counting does introduce some performance overhead compared to unique_ptr or raw pointers. However, modern implementations optimize this significantly.

### Creating `shared_ptr`

```c++
// Preferred: Exception-safe and potentially more efficient (single allocation)
std::shared_ptr<MyClass> sharedPtr = std::make_shared<MyClass>(constructor_args); 

// For arrays (C++20):
std::shared_ptr<MyClass[]> sharedArrayPtr = std::make_shared<MyClass[]>(size);
```

### Copying

Copying a `shared_ptr` creates a new `shared_ptr` instance that shares ownership of the same resource and increments the reference count:

```c++
std::shared_ptr<MyClass> ptr2 = ptr1; // ptr1 and ptr2 now share ownership
```

### Accessing the Resource

Use the `->` and `*` operators just like raw pointers or `unique_ptr`.

```c++
sharedPtr->memberFunction();
(*sharedPtr).memberVariable = value;
```

You can check if a `shared_ptr` is managing an object (not `nullptr`) using a boolean context:

```c++
if (sharedPtr) { 
    // sharedPtr is valid
}
```

Get the current reference count using `use_count()`. Useful for debugging and understanding ownership.

```c++
std::cout << sharedPtr.use_count() << std::endl;
```

### Transferring Ownership

You can move a `std::unique_ptr` to a `std::shared_ptr` to transfer ownership from a single owner (`unique_ptr`) to a shared ownership model (`shared_ptr`). This is a common scenario when you initially create an object with unique ownership but later need to share it with other parts of your code.

#### Using `std::move` and the `shared_ptr` Constructor:

The most straightforward way is to use `std::move` to transfer ownership to a `shared_ptr` when constructing the `shared_ptr`:

```c++
#include <iostream>
#include <memory>

class MyClass {
public:
    MyClass(int val) : data(val) {
        std::cout << "MyClass constructed: " << data << std::endl;
    }
    ~MyClass() {
        std::cout << "MyClass destructed: " << data << std::endl;
    }
    int data;
};

// Factory function that creates an object with unique ownership
std::unique_ptr<MyClass> createMyClass(int val) {
    return std::make_unique<MyClass>(val);
}

int main() {
    // Create the object with unique ownership
    std::unique_ptr<MyClass> uniquePtr = createMyClass(10);

    // Later, decide to share ownership
    std::shared_ptr<MyClass> sharedPtr1 = std::move(uniquePtr);
    std::shared_ptr<MyClass> sharedPtr2 = sharedPtr1; // Now shared ownership

    std::cout << "sharedPtr1 use count: " << sharedPtr1.use_count() << std::endl; // Output: 2
    std::cout << "sharedPtr2 use count: " << sharedPtr2.use_count() << std::endl; // Output: 2

    return 0;
} // MyClass is destructed when both sharedPtr1 and sharedPtr2 go out of scope
```

Notes: 

- **Move, Don't Copy**: You must use `std::move` to transfer ownership. You cannot copy a `unique_ptr`.
- `unique_ptr` becomes nullptr: After the move, the `unique_ptr` no longer owns the object and becomes `nullptr`. Attempting to access the object through the original `unique_ptr` will lead to undefined behavior.

### The Problem with `shared_ptr`: Circular Dependencies

While shared_ptr is excellent for managing shared ownership, it has a significant weakness: **circular dependencies**. A circular dependency occurs when:

- Object A holds a shared_ptr to Object B.
- Object B holds a shared_ptr to Object A.

This creates a cycle where A's reference count will never reach zero because B is holding a reference to it, and B's reference count will never reach zero because A is holding a reference to it.  Even if no other part of the code has a `shared_ptr` to A or B, they will **keep each other alive indefinitely, leading to a memory leak**.

#### Example:

```c++
#include <iostream>
#include <memory>

class B; // Forward declaration

class A {
public:
    std::shared_ptr<B> b_ptr;
    A() { std::cout << "A constructed\n"; }
    ~A() { std::cout << "A destructed\n"; }
};

class B {
public:
    std::shared_ptr<A> a_ptr; // This creates a cycle
    B() { std::cout << "B constructed\n"; }
    ~B() { std::cout << "B destructed\n"; }
};

int main() {
    std::shared_ptr<A> a = std::make_shared<A>();
    std::shared_ptr<B> b = std::make_shared<B>();

    a->b_ptr = b;
    b->a_ptr = a;

    // a and b will never be deleted, even when they go out of scope here!
    return 0; 
}
```

Output:
```
A constructed
B constructed
```

**Solution**: `std::weak_ptr`

This is where `std::weak_ptr` comes in. It provides a way to observe a `shared_ptr`-managed object without affecting its reference count, thus breaking the circular dependency.

## Weak Pointers

`std::weak_ptr` is a smart pointer that holds a non-owning reference to an object that is managed by a `std::shared_ptr`. It is used to observe a shared resource without participating in its ownership and, crucially, to break circular dependencies that can arise with `shared_ptr`.

### Key Features

- **Non-Owning**: A `weak_ptr` does not increment the reference count of the associated `shared_ptr`. Therefore, it does not prevent the managed object from being deallocated.
- **Breaks Circular Dependencies**: By not affecting the reference count, `weak_ptr` can be used to break cycles between objects that would otherwise keep each other alive indefinitely, preventing memory leaks.
- **Checks for Validity**: You can check if the `shared_ptr` being observed by a `weak_ptr` is still valid (i.e., the object hasn't been deleted) using the `expired(`) method.
- **Obtaining a `shared_ptr`**: You can attempt to obtain a temporary `shared_ptr` from a `weak_ptr` using the `lock()` method. If the object still exists, `lock()` returns a shared_ptr that can be used to access it; otherwise, it returns a nullptr.

### When to Use `weak_ptr`

#### Use when:

- **Breaking Circular Dependencies**: The primary use case is to resolve situations where two or more objects hold `shared_ptr` instances to each other, creating a cycle.
- **Observing Without Owning**: When you need to observe or access an object managed by a `shared_ptr` without affecting its lifetime (e.g., in an observer pattern, a caching mechanism).
- **Optional References**: When you want to hold a reference to an object that might or might not exist.

#### Do not use when:

- **You Need Ownership**: If you need to ensure the object stays alive as long as you're using it, you need a shared_ptr, not a `weak_ptr`.
- **As a General Replacement for `shared_ptr`**: `weak_ptr` is a specialized tool for specific scenarios, not a general-purpose replacement for shared ownership.

### Creating `weak_ptr`

```c++
std::shared_ptr<MyClass> sharedPtr = std::make_shared<MyClass>();
std::weak_ptr<MyClass> weakPtr(sharedPtr);
```

```c++
// Check if the object still exists
if (weakPtr.expired()) {
    std::cout << "Object no longer exists\n";
} else {
    std::cout << "Object still exists\n";
}

// Obtain a shared_ptr to access the object (if it exists)
if (std::shared_ptr<MyClass> sharedPtr = weakPtr.lock()) {
    sharedPtr->doSomething();
} else {
    std::cout << "Failed to lock weak_ptr\n";
}
```

### Example: Breaking the Circular Dependency

```c++
#include <iostream>
#include <memory>

class B; // Forward declaration

class A {
public:
    std::shared_ptr<B> b_ptr;
    A() { std::cout << "A constructed\n"; }
    ~A() { std::cout << "A destructed\n"; }
};

class B {
public:
    std::weak_ptr<A> a_ptr; // Use weak_ptr here to break the cycle
    B() { std::cout << "B constructed\n"; }
    ~B() { std::cout << "B destructed\n"; }
};

void main() {
    std::shared_ptr<A> a = std::make_shared<A>();
    std::shared_ptr<B> b = std::make_shared<B>();

    a->b_ptr = b;
    b->a_ptr = a; // No cycle created
}
```