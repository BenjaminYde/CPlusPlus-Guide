## What is a pointer?

A pointer is a variable that stores the memory address of another variable. The type of the pointer corresponds to the type of the variable it points to. For example, an `int*` is a pointer to an `int`, a `double*` is a pointer to a `double`, and so on.
### Stack

The stack is used for static memory allocation and contains local variables and function call information. It's automatically managed by the compiler. The memory is allocated when a function is called and deallocated when the function returns. The size of the stack is set when your program starts, and can't be changed. If you use up all the stack space (e.g., via recursion that never ends), your program will crash with a stack overflow error.
### Heap

The heap is used for dynamic memory allocation, and allows you to allocate memory explicitly during runtime. Unlike the stack, the heap does not automatically deallocate memory—you have to do it manually. If you forget to deallocate memory when you're done with it, it can lead to memory leaks. The heap is larger than the stack, but allocating and deallocating memory on the heap is slower than on the stack.

![[StackVsHeap_01.png]]

![[StackVsHeap_02.png]]
## Why and when to use pointers?

- **Dynamic Memory Allocation**: When the amount of memory needed is not known at compile time, or the data is too large to fit on the stack, you can allocate memory dynamically on the heap using pointers. This is done with the `new` keyword in C++, which returns a pointer to the allocated memory.

- **Memory Efficiency**: If you're dealing with large amounts of data, it can be more efficient to pass pointers to this data around rather than the data itself. This is because copying a pointer (which is typically the size of one machine word) is often cheaper than copying the data it points to.
## How to use pointers?

Use `*` when you want to create a pointer to an object or when you want to access the value the pointer is pointing to. Pointers are useful when you need to pass an object to a function without making a copy, but you also need the flexibility of being able to change what the pointer points to.

```c++
int num = 10;
int* ptr = &num;  // ptr now points to num
```

In this example, `&num` gives the memory address of `num`, and `ptr` stores this address. The `*` symbol is used to declare a pointer, and the `&` symbol is used to get the memory address of a variable.

You can also dereference a pointer to get the value it points to:

```c++
int num = 10;
int* ptr = &num;
int value = *ptr;  // value now holds 10
```

In this example, `*ptr` gives the value that `ptr` points to.

```c++
string food = "Pizza"; // A food variable of type string  
cout << food;  // Outputs the value of food (Pizza)  
cout << &food; // Outputs the memory address of food (**0x6dfed4**)
```

This example shows the same principle again (value vs pointer address).
## Pointer creation convention

There are three ways to declare pointer variables, but the first way is preferred:

```c++
string* mystring; // Preferred  
string *mystring;  
string * mystring;
```
## Null pointers

A null pointer is a pointer that doesn't point to any memory location. It's a good practice to initialize pointers to null if you don't have a variable for them to point to yet. You can use the `nullptr` keyword in C++11 and later to create a null pointer. Here's an example:

```c++
int* ptr = nullptr;
```
## Passing By Pointer

When passing a pointer to a function, the pointer's address itself is passed by value, which means the function receives a copy of the pointer. Modifying the copy will not change the original pointer. However, the object the pointer is pointing to can still be modified within the function.

```c++
void modify_int(int *x) {
    *x = 42; // Access the value the pointer 'x' is pointing to
}

int main() {
    int a = 10;
    int *ptr = &a; // Create a pointer 'ptr' pointing to 'a'
    modify_int(ptr);
    // 'a' is now 42 because the function modified the value it pointed to
}
```

It provides direct access to the object it points to. However, raw pointers can lead to issues like memory leaks or dangling pointers if not managed properly.
## Dynamic Memory Allocation

In C++, dynamic memory allocation is handled using the `new` and `delete` operators (or their array counterparts `new[]` and `delete[]`).

-  `new`: This operator is used to allocate memory on the heap for a given type. It returns a pointer to the first byte of the allocated block. If it cannot allocate the requested memory (for example, if there isn't enough free memory), it throws a `std::bad_alloc` exception.

-  `delete`: This operator is used to deallocate memory that was previously allocated with `new`. It frees up the memory so it can be reused for future allocations. You must pass to `delete` a pointer that was returned by `new` (or a null pointer).

Here's an example:

```c++
int* ptr = new int(10);  // allocates an int on the heap, and initializes it to 10
delete ptr;  // frees the memory
```

For arrays, you use `new[]` and `delete[]`:

```c++
int* arr = new int[10];  // allocate memory for an array of 10 ints on the heap

for (int i = 0; i < 10; i++)
    arr[i] = i;

delete[] arr;            // deallocate the array
```
## The arrow operator (->)

The arrow operator `->` is used to access members of an object through a pointer. It is equivalent to dereferencing the pointer and then using the dot operator `.`

Let's say you have a class `MyClass` with a member variable `myVariable`:

```c++
class MyClass {
public:
    int myVariable;
};
```

You can create an object of `MyClass` and access `myVariable` like this:

```c++
MyClass obj;
obj.myVariable = 10;
```

But if you have a pointer to an object of `MyClass`, you can't use the dot operator directly. You need to dereference the pointer first. You can do this with the `*` operator and the dot operator:

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
// x is still 5, y is still 10
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
// x is now 10, y is now 5
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
// x is now 10, y is now 5
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

## `*&` (Reference to a Pointer)

Use `*&` when you want to create a reference to a pointer. This is useful when you want to pass a pointer to a function and modify the original pointer within the function, for example, to make it point to a different object.

```c++
void modify_ptr(int* &x) {
    int b = 42;
    x = &b; // Make the pointer 'x' point to 'b'
}

int main() {
    int a = 10;
    int *ptr = &a; // Create a pointer 'ptr' pointing to 'a'
    modify_ptr(ptr);
    // 'ptr' now points to a different object (int b = 42) because it was passed as a reference to a pointer
}
```

Note that in the last example, `ptr` points to a local variable `b` in the `modify_ptr` function, which will go out of scope once the function exits. This is not recommended, as it can lead to undefined behavior when accessing the pointer afterward. This example is only meant to illustrate the concept of passing a reference to a pointer.

### Initialize pointer out of scope with `*&`

This version of the function uses references to pointers. 

```c++
class MyClass {
    // ...
};

void load(MyClass* &a) {
    // The function can modify a to point to a new object
    a = new MyClass();
    // Initialize the object...
}

void main() {
    MyClass* a = nullptr;
    load(a);
    // a now points to a new MyClass object initialized in load()
    // When you're done with the object, you need to delete it to prevent memory leaks
    delete a;
}
```