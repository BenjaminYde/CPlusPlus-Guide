# Pointers

## What is a Pointer?

A pointer is a variable that holds a memory address.  In C++, pointers are typed, meaning a pointer to an int (written as `int*`) is distinct from a pointer to a double (written as `double*`). This type information is crucial for pointer arithmetic and dereferencing, enabling the compiler to correctly interpret the data at the pointed-to location.

## Stack vs. Heap

Understanding pointers requires a grasp of how memory is organized. The two primary regions are the **stack** and the **heap**:

### Stack

The stack is used for **static memory allocation**. It contains local variables, function parameters, and function call information (like return addresses).

- **Automatic Management**: The compiler handles allocation and deallocation on the stack. Memory is allocated when a function is entered and automatically freed when the function returns. This is managed through a simple stack pointer that is incremented and decremented.
- **Fast Access:** Stack access is extremely fast because memory addresses are typically known at compile time, and the LIFO (Last-In, First-Out) structure allows for straightforward allocation and deallocation.
- **Limited Size**: The stack size is relatively small (compared to the heap) and fixed at compile time. The exact size can often be configured through compiler settings or operating system limits.
- **Stack Overflow**: Exceeding the stack's capacity (e.g., through excessively deep recursion or very large local variables) leads to a stack overflow error, usually causing program termination.

### Heap

The heap is the region of memory used for **dynamic memory allocation**. This is where you have explicit control over memory allocation and deallocation during runtime.

- **Dynamic Allocation**: Memory is allocated on demand using operators like new (or malloc in C).
- **Manual Deallocation**: Unlike the stack, the heap requires manual deallocation using delete (or free in C). Failure to deallocate leads to memory leaks.
- **Larger Size**: The heap is typically much larger than the stack, limited primarily by available system RAM and virtual memory.
- **Slower Access**: Heap allocation and deallocation are slower than stack operations. The memory manager needs to find suitable free blocks, and fragmentation can occur over time.
- **Fragmentation**: As memory is repeatedly allocated and deallocated, the heap can become fragmented, meaning free space is broken into small, non-contiguous chunks. This can make it difficult to allocate large blocks of memory even if sufficient total free space exists.

The heap is used for dynamic memory allocation, and allows you to allocate memory explicitly during runtime. Unlike the stack, the heap does not automatically deallocate memory—you have to do it manually. If you forget to deallocate memory when you're done with it, it can lead to memory leaks. The heap is larger than the stack, but allocating and deallocating memory on the heap is slower than on the stack.

![Img](./static/stack_vs_heap_1.png)
![Img](./static/stack_vs_heap_2.png)

## Why and when to use pointers?

Pointers are not merely about storing addresses; they are about enabling powerful programming techniques. Here's a more nuanced look at their purpose:

- **Efficient Data Manipulation:**  Passing large objects (like `structs` or `classes`) directly to functions can be slow due to copying. Pointers offer a solution by passing only the memory address, avoiding expensive copy operations.
  - **Example**: Passing a large image object to a function for processing. Instead of copying the entire image, you pass a pointer to it.
- **Dynamic Memory Allocation**: When the size of data is unknown at compile time, or if you need data to persist beyond the scope of a function, pointers are essential. They allow you to allocate memory on the heap using `new` (or `new[]` for arrays), giving you flexibility and control over the lifetime of your data.

## How to use pointers?

### Declare The Pointer Using  (`*`)

Use `*` when you want to create a pointer to an object or when you want to access the value the pointer is pointing to. Pointers are useful when you need to pass an object to a function without making a copy, but you also need the flexibility of being able to change what the pointer points to.

```c++
int* ptr;  // Declares a pointer named 'ptr' that can point to an integer.
```

There are three ways to declare pointer variables, but the first way is preferred:

```c++
int* ptr; // Preferred  
int *ptr;  
int * ptr;
```

### The Address-of Operator (`&`):

**Purpose**: Gets the memory address of a variable.

```c++
int x = 25; 
int* ptr = &x; // 'ptr' now holds the memory address of 'x'.
```

In this example, `&x` gives the memory address of `x`, and `ptr` stores this address. The `*` symbol is used to declare a pointer, and the `&` symbol is used to get the memory address of a variable.

This following example shows the same principle again (value vs pointer address):

```c++
string food = "Pizza"; // A food variable of type string  
cout << food;  // Outputs the value of food (Pizza)  
cout << &food; // Outputs the memory address of food (**0x6dfed4**)
```

### The Dereference Operator (`*`)

The dereference operator is the asterisk (`*`). When the `*` is placed before the name of a pointer variable, it dereferences the pointer, i.e., it retrieves the value stored at the memory address held by the pointer.

```c++
int x = 25; 
int* ptr = &x; 
int y = *ptr; // 'y' now holds the value 25 (the value pointed to by 'ptr').
```

**Modifying Values**: You can use the dereference operator to change the value the pointer points to:

```c++
*ptr = 30; // Now 'x' is 30.
```

### Null pointers

A null pointer is a pointer that doesn't point to any memory location. It's a good practice to initialize pointers to null if you don't have a variable for them to point to yet. You can use the `nullptr` keyword in C++11 and later to create a null pointer. Here's an example:

```c++
int* ptr = nullptr;
```

## Working with Arrays

**Array names decay to pointers**: In most contexts, the name of an array decays into a pointer to its first element.

```c++
int arr[] = {1, 2, 3}; 
int* ptr = arr; // 'ptr' now points to 'arr[0]'.
```

**Accessing array elements**: You can use pointer arithmetic or array indexing interchangeably:

```c++
*(ptr + 2) = 5; // Equivalent to 'arr[2] = 5;'
```

## Dynamic Memory Allocation: `new` and `delete`

In C++, dynamic memory allocation is handled using the `new` and `delete` operators (or their array counterparts `new[]` and `delete[]`).

The `new` operator is used to allocate memory on the heap for a given type. It returns a pointer to the first byte of the allocated block. If it cannot allocate the requested memory (for example, if there isn't enough free memory), it throws a `std::bad_alloc` exception.

The `delete` operator is used to deallocate memory that was previously allocated with `new` to prevent **memory leaks**. It frees up the memory so it can be reused for future allocations. You must pass to `delete` a pointer that was returned by `new` (or a null pointer).

Here an example:

```c++
int* ptr = new int(5); // Allocates an int and sets its value to 5.
delete ptr;  // frees the memory
```

For arrays, you use `new[]` and `delete[]`:

```c++
int* arr = new int[10]; // allocate memory for an array of 10 ints on the heap

for (int i = 0; i < 10; i++)
    arr[i] = i;

delete[] arr; // deallocate the array
```

## The arrow operator (`->`)

Let's say you have a pointer to an object of `MyClass`, you can't use the dot operator directly. You need to dereference the pointer first. You can do this with the `*` operator and the dot operator:

```c++
MyClass* pObj = &obj;
(*pObj).myVariable = 20;
```

However, this syntax is a bit cumbersome, so C++ provides the arrow operator `->` as a shorthand:

```c++
MyClass* pObj = &obj;
pObj->myVariable = 30;
```

The `->` operator automatically dereferences the pointer for you, so you can access the object's members directly.

### Example

Let's say you have a struct `Point`:

```c++
struct Point {
    int x;
    int y;
};

int main() {
    Point* p = new Point;
    p->x = 5;  // Access x using the arrow operator
    p->y = 10; // Access y using the arrow operator
    // Equivalent: (*p).x = 5;
    delete p;
    return 0;
}
```

## The Swap Example

### By value 

This version of the function uses pass-by-value, which means that the function receives copies of the arguments passed to it. Any modifications made within the function will not affect the original variables. Therefore, a swap function using pass-by-value would not work as expected.

```c++
void swap(int a, int b) {
    int temp = a;
    a = b;
    b = temp;
}

int x = 5, y = 10;
swap(x, y);
// x is still 5, y is still 10 (nothing changed!)
```

### By pointer

This version of the function uses pointers to the original variables. The function does not receive copies of the values, but rather the memory addresses of the original variables. Therefore, changes made to the values pointed to by these pointers will reflect in the original variables.

```c++
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int x = 5, y = 10;
swap(&x, &y);
// x is now 10, y is now 5 (it worked!)
```

### By reference

This version of the function uses pass-by-reference, which means that the function receives the actual variables themselves, not copies or pointers. Any changes made to these references within the function will directly modify the original variables.

```c++
void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

int x = 5, y = 10;
swap(x, y);
// x is now 10, y is now 5 (it worked!)
``` 

In this case, the function is called with `x` and `y` directly, not the addresses of `x` and `y`. The function then swaps the values of `x` and `y` by changing `a` and `b`, which are references to `x` and `y` respectively.

Pass-by-reference can be a more intuitive and safer way to modify the original variables in a function, as you don't have to deal with pointers directly.

## Should I pass by reference or by pointer

Deciding whether to pass by pointer or pass by reference depends on several factors:

- **Nullability**: If it's valid for the argument to be null, you should pass by pointer. A pointer can be null, but a reference cannot.

- **Reassignment**: If you need to reassign the pointer to a different memory address within the function, you should pass by pointer. References can't be reassigned.

- **Ownership Semantics**: If passing the object implies a transfer of ownership (especially in the context of dynamic memory allocation), a pointer is typically used. In modern C++, smart pointers (like `std::unique_ptr`) can clarify these semantics even more.

Passing by reference is generally preferred because it simplifies the syntax. It's clearer that the passed object itself could be modified, and the caller doesn't have to check for null (since references can't be null).

In general remember the following:

### Pointers

-   A **pointer** can be initialized to any value anytime after it is declared.

```c++
int a = 5;
int *p = &a;
```

-   A **pointer** can be assigned to point to a `NULL` value.
-   **Pointers** need to be dereferenced with a `*`.
-   A **pointer** can be changed to point to any variable of the same type.

### References

-   A **reference** must be initialized when it is declared.

```c++
int a = 5;
int &ref = a;
```

-   **References** cannot be `NULL`.
-   **References** can be used ,simply, by name.
-   Once a **reference** is initialized to a variable, it cannot be changed to refer to a variable object.

## Functions: Passing Pointers

### Passing pointer by value

When passing a pointer to a function, the pointer's address itself is passed by value, which means the function receives a copy of the pointer. Modifying the copy will not change the original pointer. However, the object the pointer is pointing to can still be modified within the function.

```c++
void initializeInt(int* ptr) {
  *ptr = 10; // Or some more complex initialization logic
}

void main() {
  int a;
  initializeInt(&a); // Pass the address of 'a'
  // 'a' is now initialized to 10
}
```

It provides direct access to the object it points to. However, raw pointers can lead to issues like memory leaks or dangling pointers if not managed properly:

Consider the following example:

```c++
void reassignPointer(int* ptr) {  // No longer a reference to a pointer
    int* newPtr = new int(42);
    ptr = newPtr; // Only modifies the local copy of the pointer
}

void main() {
    int* myPtr = new int(10);
    reassignPointer(myPtr); // Passes a copy of the pointer's value
    // myPtr still points to the memory allocated for the value 10, not the value 42
    delete myPtr; // Deletes the memory initially allocated for the value 10
    // The memory allocated inside reassignPointer (for the value 42) is never freed, causing a memory leak
}
```

### Passing pointer by reference (`*&`)

Use `*&` when you want to create a reference to a pointer. This is useful when you want to pass a pointer to a function and modify the original pointer within the function, for example, to make it point to a different object.

```c++
void reassignPointer(int*& ptr) {
    int* newPtr = new int(42);
    ptr = newPtr;
}

void main() {
    int* myPtr = nullptr;
    reassignPointer(myPtr); // myPtr now points to the newly allocated int with value 42
    delete myPtr;
}
```

## Pointer Arithmetic

### Incrementing/Decrementing

Moves the pointer to the next or previous memory location of the same type.

```c++
int arr[] = {10, 20, 30}; 
int* ptr = arr; 
ptr++; // 'ptr' now points to 'arr[1]' (value 20).
```

**Important**: Pointer arithmetic takes into account the size of the data type. Incrementing an int* moves it by sizeof(int) bytes (usually 4), while incrementing a char* moves it by sizeof(char) bytes (usually 1).

### Adding/Subtracting Integers

You can add or subtract an integer from a pointer to move it forward or backward by a certain number of elements.

```c++
ptr = ptr + 3; // Moves 'ptr' forward by 3 integer-sized memory locations.
```

You can use pointer arithmetic or array indexing interchangeably:

```c++
*(ptr + 2) = 5; // Equivalent to 'arr[2] = 5;'
```

## How Not to Use Pointers: Common Pitfalls

### 1. Memory Leaks

**Problem**: Failing to delete memory that was allocated with `new`. This leads to memory that is no longer accessible but still occupied, eventually exhausting available memory.

**Solution**: Always pair `new` with a corresponding delete (or `new[]` with `delete[]`).

### 2. Dangling Pointers

A pointer that points to memory that has been deallocated (freed) or goes out of scope. Accessing a dangling pointer leads to undefined behavior.

### 3. Incorrect Pointer Arithmetic

Performing pointer arithmetic that goes beyond the bounds of an array or allocated memory block. This can overwrite other data or lead to crashes.

### 4. Assuming delete Sets the Pointer to `nullptr`

**Problem**: delete only deallocates the memory; it does not change the value of the pointer variable itself. The pointer will still hold the old address (making it a dangling pointer).

**Solution**: Manually set the pointer to nullptr after deletion:

```c++
delete ptr; 
ptr = nullptr;
```