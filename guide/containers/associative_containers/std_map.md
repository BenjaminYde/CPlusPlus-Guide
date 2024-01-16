`std::map` is a C++ container that stores key-value pairs in a sorted manner, allowing you to quickly look up values by their associated keys.
### Characteristics

- **Sorted Container**: The key-value pairs in a `std::map` are automatically sorted upon insertion, based on the keys. The sorting is typically done using the `<` operator, but you can also use a custom comparator function to sort based on custom rules.

- **Unique Keys**: Each key in `std::map` is unique. If you try to insert a pair with a key that already exists, the insertion will either have no effect or update the existing key's value, depending on how you insert it.

- **Dynamic Size**: Like most other standard C++ containers, `std::map` can grow or shrink dynamically, adapting its size as you add or remove elements.

- **Non-Hash-Based**: `std::map` uses a balanced binary search tree (often a Red-Black tree) for its underlying implementation. This is different from hash-based containers and ensures that the elements remain sorted.

- **Predictable Time Complexity**: Operations like insertion, deletion, and search have a worst-case time complexity of `O(log n)` due to the balanced binary search tree implementation. This is slower than hash-based containers for these operations but allows for ordered traversal and efficient range queries.

- **Range Queries**: Because of its sorted nature, `std::map` allows you to perform efficient range queries, which is not as straightforward in hash-based containers.

- **Custom Comparators**: `std::map` allows you to use custom comparator functions, offering flexibility in how the elements are ordered.

- **Low Memory Overhead**: Generally, `std::map` has a lower memory overhead compared to hash-based containers like `std::unordered_map`.

- **Higher CPU Time for Search**: While `std::map` typically has lower memory overhead, it generally requires more CPU time for search operations (`O(log n)`) compared to hash-based containers like `std::unordered_map` (`O(1)` on average).
## Basic usage

```c++
#include <iostream>
#include <map>

int main() {
    std::map<std::string, int> age_map;

    // Insert key-value pairs
    age_map["Alice"] = 25;
    age_map["Bob"] = 30;

    // Access and print elements
    std::cout << "Alice's age: " << age_map["Alice"] << std::endl;

    // Update a value
    age_map["Alice"] = 26;

    // Remove an element
    age_map.erase("Bob");

    return 0;
}
```
## When to Use

- When you need to associate values with keys.
- When you want these associations to be sorted by the keys.
- When you need fast look-ups.
## Limitations

- No direct access by index, you must use keys to access values.
- Higher memory and computational overhead for insertions/deletions compared to unordered containers like `std::unordered_map`.
## Common Functions

### Element Management

- `insert({key, value})`: Inserts a unique key-value pair, maintaining sorted order by key.
- `emplace(key, value)`: Constructs and inserts a unique key-value pair in-place.
- `erase(key)`: Removes a key-value pair by its key.
- `clear()`: Removes all key-value pairs.
### Element Access

- `operator[key]`: Returns a reference to the value associated with the key.
- `at(key)`: Returns the value associated with the key, throws if key not found.
### Element Lookup

- `find(key)`: Returns an iterator to the found pair, or `end()` if not found.
- `count(key)`: Returns 1 if the key exists, otherwise 0.
### Map Properties

- `size()`: Returns the number of key-value pairs.
- `empty()`: Checks if the map is empty.
### Iteration

- `begin()`, `end()`: Iterators to traverse key-value pairs in sorted order.