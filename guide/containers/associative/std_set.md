# `std::set`: The Ordered Set

`std::set` in C++ is a dynamic container that stores unique, automatically sorted elements and allows for fast look-up, addition, and deletion operations, but it lacks random access by index and may have higher memory overhead.

## Features 

- **Sorted Container**: The elements in a `std::set` are automatically sorted upon insertion. By default, sorting is done using the `<` operator, but you can also provide a custom comparator function to sort elements according to custom rules.

- **Unique Elements**: `std::set` only stores unique elements. If you try to insert an element that is already present, the insertion will have no effect. The uniqueness is determined either by the `<` operator or by the custom comparator, if provided.

- **Dynamic Size**: Like most other container classes in C++, `std::set` can dynamically grow or shrink in size. Memory management is handled automatically.

- **Non-Hash-Based**: `std::set` uses a balanced binary search tree (commonly a Red-Black tree) for its underlying implementation, not a hash table. This ensures the ordered nature of the elements.

- **Predictable Time Complexity**: Operations like insertion, deletion, and search have a worst-case time complexity of `O(log n)` due to the balanced binary search tree implementation. This is generally slower than hash-based containers for these operations, but it allows for efficient range queries.

- **Higher CPU Time for Search**: Although `std::set` usually has lower memory overhead, it generally requires more CPU time for search operations (`O(log n)`) compared to hash-based containers like `std::unordered_set` (`O(1)` on average).

- **Range Queries**: Due to its sorted nature, `std::set` allows efficient range query operations, enabling you to easily find all elements that fall within a certain range.

- **Custom Comparators**: Flexibility is provided in terms of ordering the elements by allowing custom comparator functions.

- **Low Memory Overhead**: Typically has less memory overhead compared to hash-based containers like `std::unordered_set`.

## Basic Usage

Here's an example to demonstrate how `std::set` can be used:

```c++
#include <iostream>
#include <set>

int main() {
    std::set<int> s;

    // Insert elements
    s.insert(3);
    s.insert(1);
    s.insert(4);
    s.insert(1); // Duplicate insertion; will be ignored

    // Print the elements (will be in sorted order)
    for (auto x : s) {
        std::cout << x << ' ';  // Output: 1 3 4
    }
    std::cout << std::endl;

    // Check if an element is present
    if (s.find(2) == s.end()) {
        std::cout << "Element 2 is not in the set" << std::endl;
    }

    // Erase an element
    s.erase(3);  // Removes 3 from the set

    return 0;
}
```

## When to use `std::set`

- When you need to keep elements in a sorted manner without manual reordering.
- When you need fast look-ups but do not require duplicates.
- When you want to filter out duplicates automatically.

## Limitations

- Unlike `std::vector` or `std::deque`, random access by index is not available; you have to iterate to an element.
- Higher overhead due to maintaining the balanced tree structure, both in terms of memory and computational cost for insertions/deletions.
- All elements must be sortable and comparable, meaning you have to provide a custom comparator for custom types that do not have natural ordering defined.

## Common functions

- `insert(value)`: Inserts a unique value, maintaining sorted order.
- `erase(value)`: Removes a specific value.
- `clear()`: Clears all elements.
- `find(value)`: Returns an iterator to the found element, or `end()` if not found.
- `count(value)`: Returns 1 if the element exists, otherwise 0 (since duplicates aren't allowed).
- `lower_bound(value)`: Finds the position of the first element not less than `value`.
- `upper_bound(value)`: Finds the position of the first element greater than `value`.
- `size()`: Returns the number of elements in the set.
- `empty()`: Checks if the set is empty.
- `max_size()`: Returns the maximum number of elements the set can hold.
- `begin()`, `end()`: Provide iterators to the beginning and end of the set.
- `rbegin()`, `rend()`: Provide reverse iterators to the set.