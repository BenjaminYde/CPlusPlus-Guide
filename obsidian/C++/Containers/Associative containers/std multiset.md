`std::multiset` is a C++ container that stores elements in a sorted manner and allows for duplicate values, unlike `std::set`.
## Characteristics

- **Sorted Container**: The elements in `std::multiset` are automatically sorted as they are inserted. Default sorting is done using the `<` operator, but custom comparators can also be used.

- **Allows Duplicates**: Unlike `std::set`, `std::multiset` allows duplicate elements.

- **Dynamic Size**: The container can dynamically grow or shrink as needed.

- **Non-Hash-Based**: `std::multiset` uses a balanced binary search tree (commonly a Red-Black tree) for its underlying implementation, ensuring the elements are sorted.

- **Predictable Time Complexity**: Operations like insertion, deletion, and search have a worst-case time complexity of `O(log n)` due to the balanced tree structure.

- **Range Queries**: The sorted nature enables efficient range query operations.

- **Custom Comparators**: Allows for custom comparator functions to be used for sorting.

- **Low Memory Overhead**: Generally lower memory overhead compared to hash-based containers like `std::unordered_multiset`.

- **Higher CPU Time for Search**: More CPU time is needed for search operations (`O(log n)`) compared to hash-based containers (`O(1)` on average).
## Basic usage

```c++
#include <iostream>
#include <set>

int main() {
    std::multiset<int> numbers;

    // Insert elements
    numbers.insert(5);
    numbers.insert(5);  // Duplicates allowed
    numbers.insert(3);

    // Access and print elements
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
	// Output: 3 5 5
	
    // Remove an element
    numbers.erase(numbers.find(5));  // Removes one instance of 5

    return 0;
}
```
## When to Use

- When you need a sorted collection of elements.
- When you want to allow duplicate values.
- When you need fast look-ups and insertions.
## Limitations

- No direct access by index.
- Higher memory and computational overhead compared to unsorted containers like `std::unordered_multiset`.
## Common Functions

### Element Management

- `insert(value)`: Inserts a value, maintaining sorted order.
- `emplace(args)`: Constructs and inserts a value in-place.
- `erase(value)`: Removes all instances of a specific value.
- `clear()`: Removes all elements.
### Element Lookup

- `find(value)`: Returns an iterator to the first occurrence of the value, or `end()` if not found.
- `count(value)`: Returns the number of occurrences of a value.
### Set Properties

- `size()`: Returns the number of elements.
- `empty()`: Checks if the multiset is empty.
### Iteration

- `begin()`, `end()`: Iterators to traverse elements in sorted order.