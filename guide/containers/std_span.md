# std::span

## The Old Way (And Why It's Bad)

Before C++20, if you wanted to write a function that operates on a sequence of elements, you typically passed a pointer and a size. This is a classic C-style approach.

```c++
#include <iostream>

// This function takes a pointer and a size. It has no idea if they are valid.
void print_elements_old(int* arr, size_t size) {
    for (size_t i = 0; i < size; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}

int main() {
    int my_array[5] = {1, 2, 3, 4, 5};
    
    // Correct usage
    print_elements_old(my_array, 5);

    // DANGEROUS: How not to do it
    print_elements_old(my_array, 10); // Reads past the end of the array! Undefined Behavior.
    print_elements_old(nullptr, 5);    // Passes a null pointer! Crash.
}
```

### Pros and Cons of the Old Way:

#### Pros:

- It works... if you're careful.

#### Cons:

- **Error-Prone**: It's incredibly easy to pass the wrong size, leading to buffer overruns—a major source of bugs and security vulnerabilities.
- **Not Expressive**: The function signature (`int*`, `size_t`) doesn't convey the idea of a "range of integers." It's just two unrelated parameters.
- **Inflexible**: You have to manually manage the pointer and size for different container types.

This is the problem `std::span` was created to solve.

## `std::span`, what is it?

Think of a `std::span` as a "view" into a contiguous block of memory.

- It does not own the data. It's just a lightweight object that holds a pointer to the start of the data and a size.
- `std::span<T>` creates a mutable view, meaning you can modify the underlying elements through the span.
- If the original data is destroyed, the span becomes a "dangling view"—pointing to invalid memory. This is the single most important thing to remember.
- To create a readonly (immutable) view, you must explicitly use const in the template parameter: `std::span<const T>`

It's a smart, safe replacement for the (pointer, size) duo.

```c++
#include <iostream>
#include <span> // The required header
#include <vector>
#include <array>

// The new function signature is clean and expressive.
// This function takes a MUTABLE span. It can change the data.
void print_elements(std::span<int> data) {
    for (int element : data) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    // Works with C-style arrays
    int c_array[] = {1, 2, 3, 4, 5};
    print_elements(c_array);

    // Works with std::vector
    std::vector<int> vec = {6, 7, 8};
    print_elements(vec);

    // Works with std::array
    std::array<int, 4> std_array = {9, 10, 11, 12};
    print_elements(std_array);
}
```

In this example, `print_elements` takes a `std::span` parameter. This allows it to operate on the array without needing to know its size at compile time or owning a copy of the data.

## Read-Only vs. Modifiable Views

Often, a function only needs to read data, not modify it. You can enforce this at compile time by using a span of `const`.

```c++
// This function PROMISES not to modify the elements.
void print_readonly(std::span<const int> data) {
    for (int element : data) {
        // data[0] = 5; // This would be a COMPILE ERROR.
        std::cout << element << " ";
    }
    std::cout << std::endl;
}
```

This is a powerful way to make your APIs safer and more self-documenting. Always prefer `std::span<const T>` for function parameters unless you explicitly intend to modify the elements.

## Creating Subviews

This is where `std::span` truly shines. You can create views into portions of your data without making any copies. This is incredibly efficient.

- `.first<N>()`: Creates a span of the first N elements.
- `.last<N>()`: Creates a span of the last N elements.
- `.subspan(offset, count)`: The most flexible option. Creates a span starting at an offset with a specific count.

```c++
#include <iostream>
#include <span>

void print_subview(std::span<const int> data) {
    std::cout << "Subview (size " << data.size() << "): ";
    for (int element : data) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    int data[] = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90};

    // Create a view of the whole array
    std::span<const int> data_span(data);

    // Create subviews without copying any data
    print_subview(data_span.first<3>());    // First 3 elements
    print_subview(data_span.last<4>());     // Last 4 elements
    print_subview(data_span.subspan(2, 5)); // 5 elements starting at index 2
}
```

## Static vs. Dynamic Extent

You can also create a span with a size known at compile time. This is called a static extent. It provides an extra layer of safety.

```c++
// This function ONLY accepts spans of exactly 5 integers.
void process_five_ints(std::span<int, 5> five_ints) {
    // ...
}

int main() {
    int data1[5] = {1,2,3,4,5};
    int data2[6] = {1,2,3,4,5,6};

    process_five_ints(data1);       // OK
    // process_five_ints(data2);    // COMPILE ERROR: wrong size
}
```

This is useful for APIs that require fixed-size inputs, like processing a 3D vector or an RGBA color.

## "How Not To Do It": The Dangling Span

This is the most critical danger when using `std::span`. Because a span does not own the data, it's possible for the underlying data to be destroyed while the span is still alive. Using such a dangling span results in undefined behavior.

```c++
#include <span>
#include <vector>
#include <iostream>

std::span<int> create_dangling_span() {
    std::vector<int> vec = {1, 2, 3};
    return vec; // DANGER! 'vec' is destroyed when the function returns.
                // The returned span now points to garbage.
}

int main() {
    std::span<int> dangling = create_dangling_span();
    
    // The following line will likely crash or print garbage.
    // This is UNDEFINED BEHAVIOR.
    std::cout << "First element of dangling span: " << dangling[0] << std::endl; 
}
```