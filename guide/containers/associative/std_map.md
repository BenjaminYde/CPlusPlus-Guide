# `std::map`: The Ordered Dictionary

`std::map` is a C++ container that stores key-value pairs in a sorted manner, allowing you to quickly look up values by their associated keys.

## Features

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

    // Iterating over the map will always be in sorted key order:
    // Alice, Bob
    for (const auto& pair : age_map) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }

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

## Element Access

### `operator[]` (The "Get-or-Create" operator)

- If the key exists, it returns a reference to the mapped value.

- If the key does not exist, it default-constructs a value, inserts it into the map, and returns a reference to the new value! This is a common source of bugs if used for read-only checks.

- Use case: Best for updating or inserting values easily.

```c++
std::map<std::string, int> scores;
scores["Alice"] = 100; // Key "Alice" doesn't exist. Creates it, sets value to 100.
scores["Alice"] = 150; // Key "Alice" exists. Updates its value to 150.
std::cout << scores["Bob"]; // Key "Bob" doesn't exist. Creates it, default-constructs an int (0), and prints it. `scores` is now size 2.
```

### `.at(key)` (The "Safe-Access" method)

- If the key exists, it returns a reference to the mapped value.
- If the key does not exist, it throws a `std::out_of_range` exception.
- Use case: Best for read-access when you consider a missing key to be a program error.

### `.find(key)` (The "Check-and-Access" idiom)

- This is the most efficient and versatile method for lookups.
- It returns an iterator to the key-value pair if the key exists, or an iterator to `.end()` if it does not. It never inserts elements.
- Use case: Best for checking for the existence of a key without the risk of accidental insertion.

```c++
auto it = scores.find("Charlie");
if (it != scores.end()) {
    // Key exists, use it
    std::cout << "Charlie's score: " << it->second << std::endl;
} else {
    // Key does not exist
    std::cout << "Charlie is not in the map.\n";
}
```

## Common Functions

- `insert({key, value})`: Inserts a unique key-value pair, maintaining sorted order by key.
- `erase(key)`: Removes a key-value pair by its key.
- `clear()`: Removes all key-value pairs.
- `count(key)`: Searches the container for elements with a key equivalents and returns the number of matches.
- `size()`: Returns the number of key-value pairs.
- `empty()`: Checks if the map is empty.
- `begin()`, `end()`: Iterators to traverse key-value pairs in sorted order.