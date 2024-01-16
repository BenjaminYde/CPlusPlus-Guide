## What Are Iterators?

Iterators are objects that can traverse through all the elements in a container. They behave much like pointers, and you can dereference them to access the value they point to.
### Types of Iterators

C++ defines several types of iterators, each with different properties:

1. **Input Iterator**: Allows reading elements but not modifying them.
2. **Output Iterator**: Allows writing elements but not reading them.
3. **Forward Iterator**: Allows reading and writing elements, and can only move forward.
4. **Bidirectional Iterator**: Allows moving both forwards and backwards.
5. **Random Access Iterator**: Allows direct access to any element and supports all pointer arithmetic.
## Using Iterators with `std::array` and `std::vector`

Both `std::array` and `std::vector` provide functions to obtain iterators:

- **`begin()`**: Returns an iterator to the first element.
- **`end()`**: Returns an iterator one past the last element.
- **`rbegin()`**: Returns a reverse iterator to the last element (for bidirectional or random access iterators).
- **`rend()`**: Returns a reverse iterator one before the first element.
### Example with std::vector

```c++
#include <iostream>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};

// Using iterator to traverse the vector
for (auto it = numbers.begin(); it != numbers.end(); ++it) 
{
    std::cout << *it << " "; // Dereferencing the iterator to access the value
}
```
### Example with Built-in Arrays

```c++
#include <iostream>

int numbers[] = {10, 20, 30, 40, 50};
int* begin = numbers;         // Pointer to the first element
int* end = numbers + 5;       // Pointer one past the last element
for (int* it = begin; it != end; ++it) {
    std::cout << *it << " "; // Dereferencing the pointer to access the value
}
```
## Other iterators

### Input iterator

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