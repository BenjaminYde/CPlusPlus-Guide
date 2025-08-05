# `std::multimap`: The Ordered Multi-Dictionary

`std::multimap` is the C++ Standard Library's implementation of an ordered associative container that stores key-value pairs, sorted by key. Its defining feature, which separates it from `std::map`, is that it allows for duplicate keys. Each key can be associated with multiple different values.

## Features

- **Sorted Container**: The key-value pairs in `std::multimap` are automatically sorted upon insertion by their keys. Sorting is done using the `<` operator by default, or a custom comparator can be specified.

- **Allows Duplicate Keys**: Unlike `std::map`, `std::multimap` allows duplicate keys, each with its own associated value.

- **Dynamic Size**: Like other C++ standard containers, `std::multimap` can grow or shrink dynamically.

- **Non-Hash-Based**: Utilizes a balanced binary search tree (commonly a Red-Black tree) for its underlying implementation, thus maintaining the order of elements.

- **Predictable Time Complexity**: Due to its balanced tree structure, operations such as insertion, deletion, and search have a worst-case time complexity of `O(log n)`.

- **Range Queries**: The sorted nature of the container allows for efficient range queries on keys.

- **Custom Comparators**: You can use custom comparator functions for sorting the key-value pairs.

- **Low Memory Overhead**: Typically has less memory overhead compared to hash-based containers like `std::unordered_multimap`.

- **Higher CPU Time for Search**: Although it usually has lower memory overhead, `std::multimap` generally requires more CPU time (`O(log n)`) for search operations compared to hash-based containers like `std::unordered_multimap` (`O(1)` on average).

## Basic usage

```c++
#include <iostream>
#include <map>

int main() {
    std::multimap<std::string, int> age_map;

    // Insert key-value pairs
    age_map.insert({"Alice", 25});
    age_map.insert({"Bob", 30});
    age_map.insert({"Alice", 26});  // Duplicates allowed for keys

    // Access and print elements
    for (const auto& pair : age_map) {
        std::cout << pair.first << ": " << pair.second << " ";
    }
    std::cout << std::endl;
    // Output: Alice: 25 Alice: 26 Bob: 30

    // Remove elements with a specific key
    age_map.erase("Bob");

    return 0;
}
```

## When to Use

- When you need to associate multiple values with keys.
- When you want these associations to be sorted by the keys.
- When you need fast look-ups.

## Limitations

- No direct access by index.
- Higher memory and computational overhead for insertions/deletions compared to unordered containers like `std::unordered_multimap`.

## Common Functions

- `insert({key, value})`: Inserts a key-value pair, maintaining sorted order by key.
- `erase(key)`: Removes all instances of a specific key.
- `clear()`: Removes all key-value pairs.
- `find(key)`: Returns an iterator to the first occurrence of the key, or `end()` if not found.
- `count(key)`: Returns the number of occurrences of a key.
- `size()`: Returns the number of key-value pairs.
- `empty()`: Checks if the multimap is empty.

- `begin()`, `end()`: Iterators to traverse key-value pairs in sorted order.