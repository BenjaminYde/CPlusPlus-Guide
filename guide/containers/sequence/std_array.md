# The Modern C++ Array: `std::array`

## What is it?

For fixed-size arrays, C++11 introduced a far superior alternative: `std::array`. It's a lightweight container that gives you the performance of a C-style array with the safety and convenience of a modern container.

- **Type Safety**: `std::array` includes the size as part of its type, so it's safer in terms of type checking. This prevents issues related to array decay and accidental changes to the array's size.
- **Standard Container Interface**: `std::array` provides functions that are consistent with other C++ standard containers (like `size()`, `begin()`, `end()`), making it more consistent and easier to use with algorithms from the standard library.
- **No Performance Overhead**: `std::array` doesn't have any overhead compared to a built-in array. It's simply a wrapper around the built-in array, and modern compilers can optimize it just as well.
- **Bounds Checking**: Using the `at()` member function, you can access elements with bounds checking, which can make your code safer.
- It has iterators for use with standard algorithms.

## Declaration and Initialization

```c++
#include <array>

// An array of 5 integers. Uninitialized in this scope.
std::array<int, 5> my_array;

// Initialization using an initializer list (aggregate initialization).
std::array<int, 5> numbers = {10, 20, 30, 40, 50};

// The compiler can deduce the type if you want.
std::array an_array = {1, 2, 3, 4}; // Deduces std::array<int, 4> (since C++17)
```

## How to use it?

Here is an example:

```c++
#include <iostream>
#include <array> // The required header

// The function signature is clean and safe. No size needed!
void print_std_array(const std::array<int, 5>& arr) {
    std::cout << "Elements: ";
    for (int element : arr) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    std::array<int, 5> my_array = {10, 20, 30, 40, 50};
    print_std_array(my_array);
    // std::cout << my_array.at(10); // Throws std::out_of_range exception! Safe.
}
```

## Passing `std::array` by Reference & Const

When you pass `std::array` to a function, it behaves differently than a built-in array. If you pass it by value, a copy of the array is made. This can be inefficient if the array is large since copying a large block of memory can be time-consuming.

By passing the `std::array` by reference, you avoid this copy, making the code more efficient. Here's an example:

```c++
#include <array>

void modifyArray(std::array<int, 5>& arr) {
    arr[0] = 99; // Modifying the original array, not a copy
}

int main() {
    std::array<int, 5> numbers = {10, 20, 30, 40, 50};
    modifyArray(numbers); // Passes by reference
    // numbers[0] is now 99
    return 0;
}
```

If you want to ensure that the function doesn't modify the `std::array`, you can pass it as a `const` reference:

```c++
void printArray(const std::array<int, 5>& arr) {
    // ...
}
```

## Functions for `std::array`

- **`size()`**: Returns the number of elements in the array. Since `std::array` has a fixed size, this value is always equal to the size specified at the type definition.
- **`max_size()`**: Returns the maximum number of elements the array can hold, which is the same as `size()` for `std::array`.
- **`empty()`**: Returns a boolean indicating whether the array is empty. Always returns `false` for `std::array` unless the size is 0.
- **`at(index)`**: Provides access to the element at the specified index, with bounds checking.
- **`operator[]`**: Provides access to the element at the specified index, without bounds checking.
- **`front()`**: Returns a reference to the first element in the array.
- **`back()`**: Returns a reference to the last element in the array.
- **`data()`**: Returns a pointer to the underlying raw array.
- **`fill(value)`**: Assigns the given value to all elements in the array.
- **`swap(other_array)`**: Exchanges the content of the array with another array of the same size and type.
- **`begin()`**, **`end()`**: Provide iterators for iterating over the elements.

## Templates and Arrays

To write a single function that works for `std::array` of any size, you make it a template. This allows the compiler to automatically generate a version of your function for whatever size array you pass to it.

Example:

```c++
#include <iostream>
#include <array>

// This is a template function.
// 'T' will become the element type (e.g., int, double).
// 'N' will become the size of the array (e.g., 5, 10).
template <typename T, size_t N>
void print_array(const std::array<T, N>& arr) {
    std::cout << "Elements: ";
    for (const auto& element : arr) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    // An array of 5 integers
    std::array<int, 5> my_array = {10, 20, 30, 40, 50};
    
    // An array of 3 doubles
    std::array<double, 3> another_array = {3.14, 2.71, 1.61};

    // The SAME function works for both!
    // The compiler generates a print_array<int, 5> for this call.
    print_array(my_array); 

    // The compiler generates a print_array<double, 3> for this call.
    print_array(another_array); 
}
```

### Key Takeaways:

- **You can't "just pass the array" to a normal function because the size is a mandatory part of the type**.
- **The correct, modern C++ way to handle this is to write a template function**. The compiler then deduces the type (`T`) and the size (`N`) for you, giving you the flexibility you want while maintaining full type safety.