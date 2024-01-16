## std::span

`std::span` is a feature in C++20 that serves as a lightweight, non-owning reference to a subsequence (a contiguous range) of an array or a container like `std::vector`, `std::array`, or even a C-style array. The primary use case for `std::span` is to provide a way to pass around the information of a "view" of a data structure without actually copying the underlying data. This can be particularly useful for improving performance and reducing memory overhead in various algorithms and data manipulations.

Here's a simple example using `std::span`:

```c++
#include <iostream>
#include <span>

void print_elements(std::span<int> arr) {
    for (int element : arr) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    int my_array[5] = {1, 2, 3, 4, 5};
    std::span<int> my_span(my_array);

    print_elements(my_span);

    return 0;
}
```

In this example, `print_elements` takes a `std::span` parameter. This allows it to operate on the array without needing to know its size at compile time or owning a copy of the data.
### Key Properties

1. **Non-owning**: `std::span` does not own the data it points to; it's just a view.
2. **Contiguous**: Points to a contiguous block of memory (like arrays or `std::vector`).
3. **Type-safe**: Offers compile-time checking.
4. **Dynamic Extent**: The size can be determined at runtime.
5. **Static Extent**: The size is known at compile-time.
### Member Functions

Here are some key member functions that you'll likely use:

- `size()`: Returns the number of elements in the span.
- `empty()`: Checks if the span is empty.
- `front()`, `back()`: Returns the first and the last element, respectively.
- `operator[]`: Allows indexed access to elements.
- `begin()`, `end()`: Provide iterators to the first and past-the-last elements.
### Construction

```c++
int a[10];
std::vector<int> v;
std::array<int, 10> arr;

std::span<int> span1(a, 10);        // from pointer and length
std::span<int> span2(a, a + 10);    // from two pointers
std::span<int> span3(v);            // from std::vector
std::span<int> span4(arr);          // from std::array
```

### Subviews

You can easily create subviews:

```c++
std::span<int> span1(a, 10);
std::span<int> subspan = span1.subspan(0, 5);  // First 5 elements
```