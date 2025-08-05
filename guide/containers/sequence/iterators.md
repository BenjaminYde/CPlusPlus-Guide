# Iterators

## What Are Iterators?

In C++, if you want to write code that works with a `std::vector`, a `std::list`, a `std::map`, or any other container, how do you do it? You could write a separate function for each container type, but that's not scalable or generic.

This is the problem iterators solve. They are a powerful design pattern that decouples algorithms from containers. An iterator is an object that acts like a generalized pointer, providing a uniform way to traverse elements in any container, regardless of how that container stores its data internally.

### Types of Iterators

C++ defines several types of iterators, each with different properties:

1. **Input Iterator**: Allows reading elements but not modifying them.
2. **Output Iterator**: Allows writing elements but not reading them.
3. **Forward Iterator**: Allows reading and writing elements, and can only move forward.
4. **Bidirectional Iterator**: Allows moving both forwards and backwards.
5. **Random Access Iterator**: Allows direct access to any element and supports all pointer arithmetic.

### Core Idea

At its simplest, think of an iterator as a smart pointer that knows how to move through a specific container. All iterators support two fundamental operations:

- **Dereferencing (`*it`)**: Gets the value of the element the iterator is currently pointing to.
- **Incrementing (`++it`)**: Moves the iterator to the next element in the sequence.

#### The `begin()` and `end()` Idiom

All standard containers provide a pair of functions to get the iterators that define their sequence:

- `container.begin()`: Returns an iterator pointing to the first element.
- `container.end()`: Returns an iterator pointing one position past the last element.

This `end()` iterator is a special "sentinel" value. It does not point to a valid element and must not be dereferenced. The half-open range `[begin, end)` is a fundamental concept in C++. A loop continues as long as the iterator is not equal to this end sentinel.

## Using Iterators with `std::array` and `std::vector`

Both `std::array` and `std::vector` provide functions to obtain iterators:

- `begin()`: Returns an iterator to the first element.
- `end()`: Returns an iterator one past the last element.
- `rbegin()`: Returns a reverse iterator to the last element (for bidirectional or random access iterators).
- `rend()`: Returns a reverse iterator one before the first element.

### Example with `std::vector`

```c++
#include <iostream>
#include <vector>

int main() {
    std::vector<int> numbers = {10, 20, 30, 40, 50};

    // The classic iterator loop.
    // 'it' is an iterator object, specifically a std::vector<int>::iterator.
    for (auto it = numbers.begin(); it != numbers.end(); ++it) {
        std::cout << *it << " "; // Dereference to get the value
    }
}
```

This is the manual way of doing what a range-based for loop `for (auto& num : numbers) {...}` does for you automatically.

### Example with C-Style Arrays

```c++
#include <iostream>

int numbers[] = {10, 20, 30, 40, 50};
int* begin = numbers;        // Pointer to the first element
int* end = numbers + 5;      // Pointer one past the last element
for (int* it = begin; it != end; ++it) 
{
    std::cout << *it << " "; // Dereferencing the pointer to access the value
}
```

## The Power of Generic Algorithms

The true power of iterators is that they allow generic algorithms from the `<algorithm>` header to work on any container that provides the required iterator type.

Let's say we want to find a specific value. Instead of writing a search loop for a vector, another for a list, etc., we use `std::find`.

```c++
#include <iostream>
#include <vector>
#include <list>
#include <algorithm> // The home of generic algorithms

int main() {
    std::vector<int> vec = {10, 20, 30, 40, 50};
    std::list<int>   lst = {10, 20, 30, 40, 50};
    int val_to_find = 30;

    // Use std::find on a vector
    auto vec_it = std::find(vec.begin(), vec.end(), val_to_find);
    if (vec_it != vec.end()) {
        std::cout << "Found " << *vec_it << " in the vector.\n";
    }

    // Use the EXACT same algorithm on a list
    auto lst_it = std::find(lst.begin(), lst.end(), val_to_find);
    if (lst_it != lst.end()) {
        std::cout << "Found " << *lst_it << " in the list.\n";
    }
}
```

The `std::find` algorithm doesn't know or care that it's working with a `vector` or a `list`. It only knows how to use their iterators (`++` to advance, `*` to dereference, `!=` to compare). This is the decoupling that makes the C++ Standard Template Library (STL) so powerful.

## `const` Iterators

If you don't need to modify the elements, you should use `const` iterators. They provide read-only access.

- `cbegin()` and `cend()`: These member functions always return a `const_iterator`.
- This is a best practice for safety, making your intent clear.

```c++
// This loop promises not to modify the elements of 'numbers'.
for (auto it = numbers.cbegin(); it != numbers.cend(); ++it) {
    // *it = 100; // This would be a COMPILE ERROR.
    std::cout << *it << " ";
}
```

## The Danger Zone - Iterator Invalidation By Removing Elements

An iterator is only valid as long as the container it points into remains unmodified in a way that would change its structure.

Actions that modify the container, like adding or removing elements, can invalidate iterators, turning them into dangling pointers that will cause undefined behavior.

`std::vector` is the most common place this occurs. When a vector's size exceeds its capacity, it reallocates its entire memory block to a new location. When this happens, all iterators (and pointers/references) to its elements become immediately invalid.

### How Not To Do It: A Classic Bug

```c++
#include <vector>
#include <iostream>

int main() {
    std::vector<int> numbers = {10, 20, 30, 40};
    
    // DANGER: We are modifying the vector while iterating over it.
    for (auto it = numbers.begin(); it != numbers.end(); ++it) {
        if (*it == 20) {
            // This `insert` MIGHT cause a reallocation.
            // If it does, the `it` iterator becomes invalid.
            // The `++it` in the next loop cycle will be undefined behavior.
            numbers.insert(it, 99); 
        }
    }
    // The program might crash here, or produce incorrect results.
}
```

**The Rule**: Never add or remove elements from a std::vector or std::deque while iterating over it with a standard for loop.

### How To Do It: The Erase-Remove Idiom

The `erase` member function returns a new, valid iterator to the next element, which is the correct way to handle removal:

```c++
// The correct way to erase elements while iterating
for (auto it = numbers.begin(); it != numbers.end(); /* no increment here */) {
    if (*it == 20) {
        // erase() returns an iterator to the element AFTER the one erased.
        it = numbers.erase(it);
    } else {
        ++it; // Only increment if we didn't erase.
    }
}
```

Calling erase in a loop can be very inefficient for `std::vector` because each erase shifts all subsequent elements. Then how do you efficiently remove all elements with a certain value from a container? 

The **Erase-Remove Idiom** is the canonical, efficient solution. It's a two-step process:

1.  `std::remove`: This algorithm shuffles all elements that are not being removed to the front of the container. It returns an iterator to the new "logical" end of the range. The container's size does not change, and the elements after the new logical end are in a valid but unspecified state.
2. `container.erase`: Call the container's `erase` member function to delete the elements from the new logical end to the actual end of the container.

```c++
#include <vector>
#include <algorithm>
#include <iostream>

int main() {
    std::vector<int> v = {10, 20, 30, 20, 40, 20, 50};

    // 1. "Remove" all 20s by shuffling non-20s to the front.
    // `v` becomes {10, 30, 40, 50, ?, ?, ?} and `new_end` points to the first '?'.
    auto new_end = std::remove(v.begin(), v.end(), 20);

    // 2. Erase the unspecified elements at the end of the container.
    v.erase(new_end, v.end());

    for (int n : v) {
        std::cout << n << " "; // Output: 10 30 40 50
    }
}
```

## Iterator Helper Functions

The `<iterator>` header provides several essential helper functions for writing generic code.

- `std::next(it, n)`: Returns the iterator `n` positions after `it` without modifying `it`.
- `std::prev(it, n)`: Returns the iterator `n` positions before `it` (requires a bidirectional iterator).
- `std::distance(first, last)`: Calculates the number of elements between two iterators.
- `std::advance(it, n)`: Moves the iterator `it` forward (or backward if `n` is negative) by `n` positions.

```c++
#include <vector>
#include <iterator>
#include <iostream>

int main() {
    std::vector<int> v = {10, 20, 30, 40, 50};
    auto it = v.begin();
    
    // Get iterator to the 3rd element (30)
    auto it2 = std::next(it, 2);
    std::cout << "Element at index 2 is " << *it2 << std::endl;

    // Move 'it' itself forward by 3 positions
    std::advance(it, 3);
    std::cout << "Element at index 3 is " << *it << std::endl; // it now points to 40

    // Calculate distance
    long dist = std::distance(it2, it); // distance from 30 to 40
    std::cout << "Distance is " << dist << std::endl; // Output: 1
}
```

## Iterators Types

### Input Iterator

An input iterator allows you to read elements but not modify them. A common use of input iterators is with `std::istream_iterator` for reading from streams.

```c++
#include <iostream>
#include <iterator>
#include <sstream>

std::istringstream input_stream("10 20 30");
std::istream_iterator<int> it(input_stream);
std::istream_iterator<int> end;

while (it != end) {
    std::cout << *it << " ";
    ++it;
}
// Output: 10 20 30
```

### Output Iterator

An output iterator allows you to write elements but not read them. A common use of output iterators is with `std::ostream_iterator` for writing to streams.

```c++
#include <iostream>
#include <iterator>
#include <vector>

void main() {
    std::vector<int> numbers = {10, 20, 30};
    std::ostream_iterator<int> it(std::cout, " ");

    for (const auto& number : numbers) {
        *it = number; // Writes to std::cout
    }
    // Output: 10 20 30
}
```

### Forward Iterator

A forward iterator allows reading and writing elements, and it can only move forward. An example is the iterator for a singly-linked list (`std::forward_list`).

```c++
#include <iostream>
#include <forward_list>

void main() {
    std::forward_list<int> numbers = {10, 20, 30};

    for (auto it = numbers.begin(); it != numbers.end(); ++it) {
        std::cout << *it << " "; // Reading
        *it += 5;                // Writing
    }
    // Output: 10 20 30
}
```

### Bidirectional Iterator

A bidirectional iterator allows moving both forwards and backwards. A common use is with `std::list`.

```c++
#include <iostream>
#include <list>

void main() {
    std::list<int> numbers = {10, 20, 30};

    auto it = numbers.end();
    while (it != numbers.begin()) {
        --it; // Moving backward
        std::cout << *it << " ";
    }
    // Output: 30 20 10
}
```

### Random Access Iterator

A random access iterator allows direct access to any element and supports all pointer arithmetic. `std::vector` and built-in arrays provide random access iterators.

```c++
#include <iostream>
#include <vector>

void main() {
    std::vector<int> numbers = {10, 20, 30, 40, 50};

    // Direct access to elements
    auto it = numbers.begin() + 2;
    std::cout << *it << " "; // Output: 30

    // Pointer arithmetic
    it += 2;
    std::cout << *it << " "; // Output: 50
}
```