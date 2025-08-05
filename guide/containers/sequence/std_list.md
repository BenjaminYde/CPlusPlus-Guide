# std::list

## Features

`std::list` is the C++ Standard Library's implementation of a doubly-linked list. Each element is an independent node in memory that holds a value and two pointers: one to the next element and one to the previous element.

Unlike an array or `std::vector`, the elements of a `std::list` are not stored in a contiguous block of memory. They can be scattered all over the heap.

Compared to [std::forward_list](https://en.cppreference.com/w/cpp/container/forward_list "cpp/container/forward list") this container provides bidirectional iteration capability while being less space efficient.

1. **Dynamic Size**: Like vectors and unlike arrays, lists are dynamic in size, meaning you can add or remove elements at runtime.

2. **Non-contiguous Memory**: The elements are not stored in contiguous memory locations, which provides greater flexibility but at the cost of slower access times.

1. **No Random Access**: You cannot jump to the 5th element (`my_list[4]`). You must start at the beginning (or end) and traverse element by element.

2. **Bidirectional Iterators**: `std::list` provides bidirectional iterators, which means you can iterate forwards and backwards through the list but cannot perform arithmetic operations on the iterator like you can with random-access iterators.

2. **Element Insertion and Deletion**: Elements can be efficiently inserted or deleted from any part of the list (beginning, middle, or end) in constant time, `O(1)`.
   - Adding, removing and moving the elements within the list or across several lists does not invalidate the iterators or references. An iterator is invalidated only when the corresponding element is deleted.

## Comparision With Other Containers

### 1. Dynamic Size

- **std::list**: Dynamic size, can grow or shrink at runtime.
- **std::vector**: Dynamic size, but designed for efficient insertions/deletions at the end.
- **std::array**: Fixed size, defined at compile-time.

### 2. Memory Allocation

- **std::list**: Non-contiguous memory, elements can be spread out in memory.
- **std::vector**: Contiguous memory, elements are stored next to each other.
- **std::array**: Contiguous memory, elements are stored next to each other, with size determined at compile-time.

Modern CPUs are incredibly fast, but memory is slow. To bridge this gap, CPUs use multiple levels of fast cache memory. When you access a memory address, the CPU pulls in a whole "cache line" (e.g., 64 bytes) of adjacent memory, assuming you'll need it soon.

`std::vector` is the **king of cache-friendliness**. Its contiguous elements mean that when you access the first element, the next several are likely already pulled into the cache. Iterating through a vector is blisteringly fast because you get very few "cache misses."

`std::list` is the **enemy of the cache**. Each node is a separate memory allocation, potentially far away from the others. Iterating through a list involves jumping all over memory, leading to a cache miss for almost every single element.

### 3. Iterators

- **std::list**: Bidirectional iterators. You can move forwards and backwards but cannot perform arithmetic operations like `it + 5`.
- **std::vector**: Random-access iterators. You can move in both directions and perform arithmetic operations.
- **std::array**: Random-access iterators, same as `std::vector`.

### 4. Insertion and Deletion

- **std::list**: Constant-time O(1) insertions and deletions at both ends, as well as in the middle if you have an iterator to the position.
- **std::vector**: Amortized constant-time O(1) insertions/deletions at the end, but O(n) in the middle or at the beginning.
- **std::array**: Not designed for insertions or deletions. Any such operation would require manual element shifting and would be O(n).

```c++
#include <iostream>
#include <list>

int main() {
    std::list<int> myList;
    
    myList.push_back(10);
    myList.push_back(20);
    myList.push_front(5);
    
    // Insert 15 into the list before 20
    auto it = myList.begin();
    std::advance(it, 2);
    myList.insert(it, 15);

    // Iterate and print elements
    for (int num : myList) {
        std::cout << num << ' ';
    }
    
    // Output will be: 5 10 15 20
    return 0;
}
```

## When To Use `std::list`

### Iterator Stability 

This is the most important reason to choose `std::list`. Adding or removing elements from a list **does not invalidate any iterators, pointers, or references to other elements in the list**. An iterator is only invalidated if the specific element it points to is deleted.

A `std::vector`, by contrast, invalidates all iterators upon reallocation.

Use `std::list` when you need to store pointers or iterators to elements in a container that will be modified, and you need those pointers/iterators to remain valid.

```c++
std::list<MyObject> my_list;
// ... populate list ...

// Get an iterator to the first element
auto it = my_list.begin();

// This push_front operation does NOT invalidate `it`.
my_list.push_front(MyObject()); 

// `it` still correctly points to the same element it did before,
// even though that element is no longer at the front.
// If this were a std::vector, `it` could now be dangling.
it->do_something();
```

### The `splice` Operation

`std::list` has a unique and highly efficient member function: splice. It allows you to move elements from one list to another (or within the same list) in constant time `O(1)` without any memory allocation or copying of elements. It just rearranges the pointers.

```c++
#include <list>
#include <iostream>

int main() {
    std::list<int> list1 = {1, 2, 3, 4};
    std::list<int> list2 = {10, 20, 30};

    auto it = list1.begin();
    ++it; // it points to '2'

    // Splice all of list2 into list1 before the element '2'
    list1.splice(it, list2);

    // list1 is now: {1, 10, 20, 30, 2, 3, 4}
    // list2 is now empty.
    // This was an extremely fast O(1) operation.

    for(int n : list1) { std::cout << n << " "; }
}
```

### The Verdict: When should you actually use `std::list`?

Use `std::list` only when you can definitively say "yes" to one of these questions:

1. Do I absolutely require that iterators/pointers/references to elements remain stable even when the list is modified?

1. Will I be frequently using `splice` to move large numbers of elements between lists?

1. Am I storing very large, expensive-to-move objects where the cost of moving them in a vector outweighs the cost of cache misses? (This is rare).

If the answer to all of these is "no," `std::vector` **is almost certainly the better choice**.

## `std::forward_list`

`std::forward_list` is a container that supports fast insertion and removal of elements from anywhere in the container. Fast random access is not supported. It is implemented as a **singly-linked** list. Compared to [std::list](https://en.cppreference.com/w/cpp/container/list "cpp/container/list") this container provides more space efficient storage when bidirectional iteration is not needed.

Adding, removing and moving the elements within the list, or across several lists, does not invalidate the iterators currently referring to other elements in the list. However, an iterator or reference referring to an element is invalidated when the corresponding element is removed from the list.