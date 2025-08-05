# Dynamic Allocation

In C++, memory for variables can be allocated in different ways. So far, we've seen static allocation (e.g., C-style arrays, `std::array`), where the size of the object must be a constant known at compile time.

But what if you don't know the size until the program is running? What if a user needs to enter 10 items, or 10,000? This is the problem that dynamic memory allocation solves. It allows you to request memory from the operating system (from a pool called the heap) at runtime.

## The Old Way (`new` and `delete[]`)

### Allocating

The traditional C++ way to handle dynamic memory is through the `new` and `delete[]` operators. This approach gives you raw control, but as we'll see, it's incredibly dangerous and error-prone.

You use `new T[size]` to allocate an array of size elements of type `T`. This returns a pointer to the first element of that new block of memory.

```c++
int size = 10;
int* myArray = new int[size]; // Allocates an array of 10 ints on the heap
```

### Accessing Elements

You can access elements of a dynamically allocated array just like a regular array, using the indexing operator `[]`:

```c++
myArray[5] = 42; // Sets the value of the sixth element to 42
```

### Releasing Memory

When you're done with a dynamically allocated array, it's essential to release the memory, or else you'll have a memory leak. This is done using the `delete[]` operator:

```c++
delete[] myArray;
// Setting it to nullptr is a good practice to prevent accidental use.
my_array = nullptr;
```

After deleting the memory, you should ensure that you don't use the pointer again, as it is now a dangling pointer.

## The Dangers of Manual Management

Managing memory with new and delete[] is like juggling chainsaws. It's powerful, but one mistake leads to disaster. This is why it's almost never used in modern C++ application code.

### Memory Leaks

If you `new` something and forget to `delete[]` it, that memory is lost forever to your program. It cannot be used again until the program terminates. This is a memory leak. A small leak can go unnoticed, but in a long-running program (like a server), it will eventually consume all available memory and crash the system.

How to create a leak:

```c++
void create_leak() {
    int* leaky_array = new int[1000];
    // The function ends, but we never called delete[].
    // The 4000 bytes allocated for this array are now lost.
}
```

### Dangling Pointers

After you `delete[]` a pointer, the pointer variable itself still holds the old memory address. It is now a dangling pointer because it points to memory you no longer own. Using it is undefined behavior.

When will you use a dangling pointer?:

```c++
int* data = new int[10];
data[0] = 42;

delete[] data; // Memory is released.

// DANGER: `data` is now dangling. This writes to unowned memory.
// It might crash, it might corrupt other data, or it might appear to work (for now).
data[0] = 99;
```

### The Resizing Nightmare

C++ does not provide a built-in mechanism for resizing a dynamically allocated array. If you need to resize it, you must

1. Allocate a new, larger block of memory.
2. Copy all the elements from the old block to the new one.
3. Delete the old block.
4. Point your original pointer to the new block.
5. This is inefficient and a breeding ground for bugs.

```c++
int* myArray = new int[size];
int* newArray = new int[newSize];

std::copy(myArray, myArray + size, newArray);
delete[] myArray;

myArray = newArray;
size = newSize;
```

## The Modern Solution: `std::vector`

To solve previous mentioned problems, C++ provides `std::vector`. It is a dynamic array container that **manages its own memory automatically**. It handles allocation, deallocation, and resizing for you in a safe and highly efficient way.

You should prefer `std::vector` over manual `new` and `delete[]`.

```c++
#include <vector>
#include <iostream>

int main() {
    // Creates an empty vector. No memory is allocated for elements yet.
    std::vector<int> my_vector;

    // Use push_back to add elements. The vector will grow as needed.
    my_vector.push_back(10);
    my_vector.push_back(20);
    my_vector.push_back(30);

    // Access elements safely
    std::cout << "Element at index 1: " << my_vector.at(1) << std::endl;

    // Iterate easily and safely
    for (const auto& num : my_vector) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
} // When my_vector goes out of scope, its memory is automatically freed. No leaks!
```

### Common Functions

The `std::vector` is a very versatile container in C++ and comes with a lot of handy functions. Here's a list of some common and useful member functions that you might find handy:

#### Size and Capacity

- `size()`: Returns the number of elements in the vector.
- `empty()`: Returns whether the vector is empty.
- `capacity()`: Returns the number of elements that can be held in currently allocated storage.
- `resize(n)`: Resizes the vector to contain `n` elements.
- `reserve(n)`: Requests that the vector's capacity be at least enough to contain `n` elements.

#### Element Access

- `operator[]`: Accesses an element at a specific index without bounds checking.
- `at(n)`: Accesses the element at position `n`, with bounds checking.
- `front()`: Returns a reference to the first element.
- `back()`: Returns a reference to the last element.

#### Modifiers

- `push_back(x)`: Adds an element to the end of the vector.
- `pop_back()`: Removes the last element from the vector.
- `insert(pos, val)`: Inserts an element at the specified position.
- `erase(pos)`: Erases an element at the specified position.
- `clear()`: Removes all elements from the vector.
- `swap(vec)`: Swaps the contents with another vector.

#### Iterators

- `begin()`: Returns an iterator pointing to the first element.
- `end()`: Returns an iterator pointing past the last element.
- `rbegin()`: Returns a reverse iterator pointing to the last element.
- `rend()`: Returns a reverse iterator pointing before the first element.

#### Miscellaneous

- `data()`: Returns a pointer to the first element in the array used internally by the vector.

###  Size vs Capacity

- `size()`: The number of elements currently stored in the vector.
- `capacity()`: The number of elements the vector can hold before it must reallocate memory.

When a vector's `size` exceeds its `capacity` (e.g., during a `push_back`), the vector performs the resizing dance for you: it allocates a new, larger block of memory (typically 1.5x or 2x the old capacity), copies all elements over, and frees the old block. This is an expensive operation.

If you know ahead of time that you will be adding many elements, you can pre-allocate the memory once to avoid repeated reallocations. This is a crucial performance optimization. You can use `reserve()` for this.

#### How Not To Do It (Inefficient):

```c++
std::vector<int> numbers;
// This loop might cause MANY reallocations, slowing the program down.
for (int i = 0; i < 1000; ++i) {
    numbers.push_back(i);
}
```

#### The Efficient Way (reserve):

```c++
std::vector<int> numbers;
// 1. Pre-allocate memory ONCE for all 1000 integers.
numbers.reserve(1000);

// 2. This loop will now perform ZERO reallocations. It's much faster.
for (int i = 0; i < 1000; ++i) {
    numbers.push_back(i);
}
```

## C-Style Dynamic Memory

Before C++ introduced the `new` and `delete` operators, the C language provided a set of functions for managing dynamic memory. These functions are available in C++ via the `<cstdlib>` header for compatibility, but their use in modern C++ code is strongly discouraged. Understanding what they do and why they are avoided is crucial for any serious C++ programmer.

### Core Functions

- `malloc(size_t size)`: allocates a block of memory of given byte size from the heap.
  - It returns a `void*` (a generic pointer to untyped memory). You must cast this pointer to the correct type yourself.
  - The allocated memory is uninitialized; its contents are garbage.
- `free(void* ptr)`: Releases a block of memory pointed to by `ptr` that was previously allocated by `malloc` (or `realloc`).
- `realloc(void* ptr, size_t new_size)`: Reallocates a given block of memory, changing its size to new_size.
  - It may return a pointer to the same memory block or a new one (if the data had to be moved).
  - This is the C-style way to "resize" a dynamic array.

### A Typical C-Style Example

This is how these functions are used in a C program.

```c
#include <stdio.h>
#include <stdlib.h> // The C header for malloc, free, realloc

int main(void) {
    int n = 5;
    int* arr;

    // 1. Allocate memory for 5 integers.
    // We must calculate the size in bytes manually.
    arr = (int*)malloc(n * sizeof(int));

    // Always check if malloc succeeded. If it fails, it returns NULL.
    if (arr == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // 2. Use the memory.
    for (int i = 0; i < n; i++) {
        arr[i] = i + 1; // Assign 1, 2, 3, 4, 5
    }

    // 3. We are done. We MUST free the memory.
    free(arr);
    arr = NULL; // Good practice to prevent using a dangling pointer.

    return 0;
}
```

## The Golden Rule in C++: Avoid Mixing C & C++ Memory Systems When Possible

While available in C++, the C memory functions (malloc, etc.) and the C++ memory operators (new, delete) are two completely separate and **incompatible systems**.
Mixing them is a guaranteed way to cause **undefined behavior**.

Memory allocated by `malloc/realloc` must be released with free. Memory allocated with `new/new[]` must be released with `delete/delete[]`. Never cross the streams.

### How Not To Do It: The Absolute Wrong Way

```c++
#include <cstdlib>

// SCENARIO 1: Malloc -> Delete
int* p1 = (int*)malloc(sizeof(int));
// delete p1; // WRONG! Memory allocated with malloc must be freed with free.

// SCENARIO 2: New -> Free
int* p2 = new int;
// free(p2); // WRONG! Memory allocated with new must be deleted.

// SCENARIO 3: New -> Realloc
char* p3 = new char[10];
// char* p4 = (char*)realloc(p3, 20); // WRONG! Cannot use realloc on a pointer from new.
```

## Why Modern C++ Avoids `malloc` and `free`

The primary reason to avoid C-style allocation in C++ is that `malloc` and `free` are fundamentally not object-oriented. They only understand bytes, not C++ objects with constructors and destructors.

### `malloc` Does Not Call Constructors

When you create a C++ object, its constructor is responsible for initializing its state. `malloc` gives you raw, uninitialized memory. It never calls a constructor, leaving your object in an invalid state.

```c++
#include <iostream>
#include <string>
#include <cstdlib>

class MyObject {
public:
    MyObject() {
        std::cout << "Constructor called. Object is ready.\n";
    }
};

int main() {
    std::cout << "Creating with C++ new:\n";
    MyObject* obj1 = new MyObject(); // Constructor is called.
    delete obj1;

    std::cout << "\nCreating with C malloc:\n";
    MyObject* obj2 = (MyObject*)malloc(sizeof(MyObject)); // Constructor is NOT called.
    // At this point, obj2 points to garbage memory. It is not a valid MyObject.
    free(obj2);
}
```

Output:

```
Creating with C++ new:
Constructor called. Object is ready.

Creating with C malloc:
```

### `free` Does Not Call Destructors

This is even more dangerous. A C++ object's destructor is responsible for cleaning up any resources it holds (e.g., closing files, releasing network sockets, freeing other memory). `free` just deallocates the object's own memory, completely ignoring the destructor. This is a direct cause of **memory leaks**.

```c++
#include <iostream>
#include <cstdlib>

class ResourceHolder {
public:
    ResourceHolder() {
        std::cout << "ResourceHolder constructed.\n";
    }
    ~ResourceHolder() {
        std::cout << "Destructor called. Releasing resources.\n";
    }
};

int main() {
    std::cout << "Deleting with C++ delete:\n";
    ResourceHolder* obj1 = new ResourceHolder();
    delete obj1; // Destructor IS called. Correct.

    std::cout << "\nFreeing with C free:\n";
    ResourceHolder* obj2 = new ResourceHolder();
    free(obj2); // Destructor is NOT called. Incorrect. Resource leak!
}
```

Output:

```
Deleting with C++ delete:
ResourceHolder constructed.
Destructor called. Releasing resources.

Freeing with C free:
ResourceHolder constructed.
```

## When To Mix C-Style Memory With C++?

The primary reason to using c-style arrays in C++ is when interfacing with legacy C libraries or low-level operating system APIs.

These C APIs don't understand `std::vector` or `std::string`. They expect a raw pointer to a contiguous block of memory. The good news is that modern C++ containers are designed to provide this easily and safely.

The key is to use a C++ container (like `std::vector`) to manage the memory and then use its `.data()` member function to get a temporary raw pointer to pass to the C API.

### Example:C++ to C Interoperability

Let's imagine we have an old C library function that processes an array of integers.

```c
// A legacy C function in some library we don't control.
// It expects a pointer to an array and the number of elements.
void process_data_in_c(const int* data, size_t size) {
    printf("C function received %zu integers:\n", size);
    for (size_t i = 0; i < size; ++i) {
        printf("%d ", data[i]);
    }
    printf("\n");
}
```

Now, here is the safe, modern C++ way to call this function.

```c++
#include <vector>
#include <cstdio> // For C-style I/O

// The legacy C function from above
void process_data_in_c(const int* data, size_t size);

int main() {
    // 1. Use std::vector to safely manage dynamic memory.
    std::vector<int> my_numbers = {10, 20, 30, 40, 50};

    // Add more data dynamically...
    my_numbers.push_back(60);

    // 2. To call the C function, get a raw pointer to the vector's
    //    contiguous data block and pass its size.
    //    The vector still OWNS the memory. We are just borrowing a pointer.
    process_data_in_c(my_numbers.data(), my_numbers.size());

    // 3. When my_numbers goes out of scope, its destructor is called
    //    and all memory is safely and automatically cleaned up. No leaks.
    return 0;
}
```