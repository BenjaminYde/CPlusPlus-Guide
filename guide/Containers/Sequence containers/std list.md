# std::list

The `std::list` data structure in C++ is a doubly-linked list implementation. Unlike arrays or vectors, elements in a **doubly-linked** list are not stored in contiguous memory locations. Each element points to its next element and also to its previous element, hence the term "doubly-linked". 

`std::list` is a container that supports constant time insertion and removal of elements from anywhere in the container. Fast random access is not supported. It is usually implemented as a doubly-linked list. Compared to [std::forward_list](https://en.cppreference.com/w/cpp/container/forward_list "cpp/container/forward list") this container provides bidirectional iteration capability while being less space efficient.

Adding, removing and moving the elements within the list or across several lists does not invalidate the iterators or references. An iterator is invalidated only when the corresponding element is deleted.
### Features

1. **Dynamic Size**: Like vectors and unlike arrays, lists are dynamic in size, meaning you can add or remove elements at runtime.

2. **Non-contiguous Memory**: The elements are not stored in contiguous memory locations, which provides greater flexibility but at the cost of slower access times.

3. **Bidirectional Iterators**: `std::list` provides bidirectional iterators, which means you can iterate forwards and backwards through the list but cannot perform arithmetic operations on the iterator like you can with random-access iterators.

4. **Element Insertion and Deletion**: Elements can be efficiently inserted or deleted from any part of the list (beginning, middle, or end) in constant time, O(1).
### Dynamic Size

- **std::list**: Dynamic size, can grow or shrink at runtime.
- **std::vector**: Dynamic size, but designed for efficient insertions/deletions at the end.
- **std::array**: Fixed size, defined at compile-time.
### Memory Allocation

- **std::list**: Non-contiguous memory, elements can be spread out in memory.
- **std::vector**: Contiguous memory, elements are stored next to each other.
- **std::array**: Contiguous memory, elements are stored next to each other, with size determined at compile-time.
### Iterators

- **std::list**: Bidirectional iterators. You can move forwards and backwards but cannot perform arithmetic operations like `it + 5`.
- **std::vector**: Random-access iterators. You can move in both directions and perform arithmetic operations.
- **std::array**: Random-access iterators, same as `std::vector`.
### Insertion and Deletion

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
## std::forward_list

`std::forward_list` is a container that supports fast insertion and removal of elements from anywhere in the container. Fast random access is not supported. It is implemented as a **singly-linked** list. Compared to [std::list](https://en.cppreference.com/w/cpp/container/list "cpp/container/list") this container provides more space efficient storage when bidirectional iteration is not needed.

Adding, removing and moving the elements within the list, or across several lists, does not invalidate the iterators currently referring to other elements in the list. However, an iterator or reference referring to an element is invalidated when the corresponding element is removed from the list.