# The C-Style Array

## What is it?

C-style arrays are the most primitive and fundamental aggregate data type in C++. They are inherited directly from the C language.

Think of them as a raw, fixed-size block of memory. You tell the compiler you want a certain number of elements, and it carves out that exact amount of contiguous memory for you. There are no extra features, no safety nets, and no conveniences. It's just you and the memory. This low-level nature is both its strength and its greatest weakness.

## Declaration and Initialization

```c++
// Declares an array that can hold 5 integers.
// The memory is allocated, but the values are uninitialized (garbage).
int uninitialized_array[5];

// Declares and initializes an array with specific values.
// The compiler automatically deduces the size is 5.
int initialized_array[] = {10, 20, 30, 40, 50};

// You can also specify the size and initialize it.
// If you provide fewer initializers, the rest are set to zero.
double data[4] = {3.14, 2.71}; // Becomes {3.14, 2.71, 0.0, 0.0}```

You can also initialize an array at the time of declaration:

```c++
int myArray[] = {10, 20, 30, 40, 50}; // The compiler determines the size
float anotherArray[4] = {3.14, 2.71, 0.0, 1.61};
```

**How Not To Do It**: The size cannot be a variable determined at runtime. This is a common beginner mistake.

```c++
int size = 10;
// int my_array[size]; // COMPILE ERROR: size is not a compile-time constant.

const int CONST_SIZE = 10;
int my_array[CONST_SIZE]; // OK: CONST_SIZE is known at compile time.
```

## Accessing Elements

You access elements using the subscript operator `[]` with a zero-based index. The first element is at index `0`.

```c++
int my_array[] = {10, 20, 30, 40, 50};

int first_value = my_array[0];  // Accesses the first element (10)
my_array[3] = 99;               // Changes the fourth element from 40 to 99
```

### No bounds checking

C++ arrays have zero bounds checking. Accessing an index outside the array's defined range is undefined behavior. It won't give you an error; it will read or write to some other part of your program's memory, leading to crashes and security holes.

```c++
int data[3] = {10, 20, 30};

// DANGER: Accessing index 3, but valid indices are 0, 1, 2.
data[3] = 99; // This corrupts memory somewhere else.

// DANGER: Loop goes one step too far.
for (int i = 0; i <= 3; ++i) {
    // std::cout << data[i] << " "; // Reads corrupted memory on the last iteration.
}
```

This is a classic "buffer overflow" bug.

## Getting the Size 

You can get the number of elements in an array using the `sizeof` operator, but this trick has a major limitation.

```c++
int numbers[] = {10, 20, 30, 40, 50};

// This formula works ONLY in the same scope where the array was defined.
size_t element_count = sizeof(numbers) / sizeof(numbers[0]); // 20 bytes / 4 bytes = 5 elements
```

## Passing Arrays to Functions: Array Decay

This is the single most confusing and error-prone aspect of C-style arrays. When you pass an array to a function, it "decays" into a pointer to its first element. The function loses all information about the array's size.

Here an example:

```c++
#include <iostream>

// These two function signatures are 100% identical to the compiler.
// void process_array(int arr[], size_t size);
void process_array(int* arr, size_t size) {
    std::cout << "Inside function: sizeof(arr) = " << sizeof(arr) << std::endl;
    for (size_t i = 0; i < size; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}

int main() {
    int my_array[] = {10, 20, 30};
    std::cout << "Inside main: sizeof(my_array) = " << sizeof(my_array) << std::endl;

    // Because of array decay, we MUST pass the size as a separate argument.
    process_array(my_array, 3);
}
```

Output:

```
Inside main: sizeof(my_array) = 12
Inside function: sizeof(arr) = 8
10 20 30
```

The following two declarations are the same:

```c++
// option 1
void printArray(int arr[], int size);
// option 2
void printArray(int *arr, int size);
```

>[!NOTE]
> `sizeof(arr)` is 8 on a 64-bit system because that's the size of a pointer, not the array data!

## Multidimensional Arrays

C++ supports multidimensional arrays, which are essentially arrays of arrays. They are stored in a contiguous block of memory in row-major order. This means the elements of the first row are stored first, followed by the elements of the second row, and so on.

```c++
// A 2x3 array (2 rows, 3 columns)
int matrix[2][3] = {
    {1, 2, 3},  // Row 0
    {4, 5, 6}   // Row 1
};

// Accessing the element at row 1, column 2
int value = matrix[1][2]; // value will be 6
```

When passing a multidimensional array to a function, you must specify the size of all dimensions except the first one.

```c++
// The size of the second dimension (3) is required.
void print_matrix(int arr[][3], int rows) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < 3; ++j) {
            std::cout << arr[i][j] << " ";
        }
        std::cout << std::endl;
    }
}
```