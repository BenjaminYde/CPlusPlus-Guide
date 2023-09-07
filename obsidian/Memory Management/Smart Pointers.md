## Problem with raw pointers

Raw pointers in C++ have several issues that can lead to bugs, memory leaks, and undefined behavior if not managed properly. Some of the main problems with raw pointers are:

- **Memory leaks**: If you allocate memory using `new` but forget to deallocate it with `delete`, it can cause a memory leak. Memory leaks can lead to increased memory usage and, in extreme cases, cause your program to crash.

- **Dangling pointers**: A dangling pointer is a pointer that points to memory that has already been deallocated or is otherwise no longer valid. Accessing the memory through a dangling pointer results in undefined behavior, which can cause crashes, data corruption, or other hard-to-debug issues.

- **Double deletion**: If you accidentally delete the same memory twice, it can cause undefined behavior, leading to crashes or data corruption.

- **Ownership ambiguity**: With raw pointers, it can be unclear which part of the code is responsible for managing the memory, including deallocation. This can lead to inconsistencies in memory management and make the code harder to maintain.

- **Exception safety**: If an exception is thrown before a raw pointer's memory is deallocated, the memory might not be freed, leading to a memory leak. Ensuring that memory is always deallocated properly in the presence of exceptions can be challenging with raw pointers.

## Welcome to Smart Pointers

Smart pointers are a feature of C++ that provides a level of automatic memory management, helping to prevent memory leaks and dangling pointers. They achieve this by keeping track of the number of references to a dynamically allocated object and automatically deleting it when the reference count drops to zero. This makes them particularly useful in large codebases where manual memory management could become difficult and error-prone.

ome common types of smart pointers in C++ include `std::unique_ptr`, `std::shared_ptr`, and `std::weak_ptr`. Each of these has different use cases:

`std::unique_ptr` represents exclusive ownership of a dynamically allocated object and cannot be copied. However, ownership can be transferred via move semantics. It's useful when you want to ensure a single part of the code is responsible for managing the memory of the object.   

`std::shared_ptr` allows multiple pointers to refer to the same dynamically allocated object. The object will be deleted when the last `shared_ptr` pointing to it is destroyed or reset. This is useful in situations where an object needs to be accessed from multiple parts of the code.

`std::weak_ptr` is a companion to `std::shared_ptr` that observes the object but does not contribute to the reference count. This is useful for breaking reference cycles which could lead to memory leaks.

Use the following include to use smart pointers

```c++
#include <memory>
```

### Unique pointers

`std::unique_ptr` is a smart pointer that owns and manages another object through a pointer and disposes of that object when the `unique_ptr` goes out of scope. The uniqueness refers to the fact that at any point, only one `unique_ptr` instance can point to a certain object.

```c++
std::unique_ptr<int> ptr(new int(5));
```

The above code creates a `unique_ptr` that points to an integer. When `ptr` goes out of scope, it will automatically deallocate the memory that it points to.

Key points:

- They are called unique because they cannot be copied. This ensures that the ownership of the memory resource is not shared and is unique to the pointer owning it.

- They are useful in situations where you want to ensure that your program doesn't accidentally use the same memory resource in two different places.

- When the `unique_ptr` goes out of scope, it automatically frees the memory it owns. This helps avoid memory leaks.

### Shared pointers

`std::shared_ptr` is a type of smart pointer that retains shared ownership of an object. Multiple `shared_ptr` objects may own the same object. The object is destroyed and its memory deallocated when the following conditions are both met:

- The last remaining `shared_ptr` owning the object is destroyed.
- The last `std::weak_ptr` to the object is destroyed.

```c++
std::shared_ptr<int> ptr(new int(10));
```

Key points:

- A `shared_ptr` allows multiple pointers to refer to the same block of memory.

- It maintains a reference counter to keep track of how many `shared_ptrs` own the shared resource.

- When the last `shared_ptr` to a resource is destroyed, the resource will be de-allocated. This helps avoid memory leaks.

### Weak pointers

`std::weak_ptr` is a smart pointer that holds a non-owning ("weak") reference to an object that is managed by `std::shared_ptr`. It must be converted to `std::shared_ptr` in order to access the object. `weak_ptr` models temporary ownership: when an object needs to be accessed only if it exists, and it may be deleted at any time by other code.

```c++
std::shared_ptr<int> shared(new int(20));
std::weak_ptr<int> weak = shared; // `weak` is a weak pointer that points to `shared`.
```

Key points:

- `std::weak_ptr` is used in conjunction with `std::shared_ptr`. It can't access its object directly.

- It doesn't increase the reference counter of the `shared_ptr`.

- It is useful for breaking circular references which can be created using `std::shared_ptr`.