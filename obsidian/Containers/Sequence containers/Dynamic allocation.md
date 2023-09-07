Dynamic memory allocation allows you to request memory dynamically from the heap during runtime, rather than allocating it statically at compile time. When working with arrays in C++, this is particularly useful when you need to allocate an array of a size that is not known until your program is running.
### Allocating Memory

In C++, you can allocate memory dynamically using the `new` operator:

```c++
int size = 10;
int* myArray = new int[size]; // Allocates an array of 10 ints on the heap
delete[] myArray; // Deallocate the memomory because it is not used anymore
```
### Accessing Elements

You can access elements of a dynamically allocated array just like a regular array, using the indexing operator `[]`:

```c++
myArray[5] = 42; // Sets the value of the sixth element to 42
```
### Releasing Memory

When you're done with a dynamically allocated array, it's essential to release the memory, or else you'll have a memory leak. This is done using the `delete[]` operator:

```c++
delete[] myArray;
```

After deleting the memory, you should ensure that you don't use the pointer again, as it is now a dangling pointer.
### Resizing a Dynamic Array

C++ does not provide a built-in mechanism for resizing a dynamically allocated array. If you need to resize it, you must manually allocate a new block of memory, copy the existing elements, and then release the old memory:

```c++
int* myArray = new int[size];
int* newArray = new int[newSize];

std::copy(myArray, myArray + size, newArray);
delete[] myArray;

myArray = newArray;
size = newSize;
```
### Using `std::vector`

Because managing dynamic memory manually can be error-prone, modern C++ often prefers to use `std::vector`, which is a dynamically resizable array that handles all the memory management for you:

```c++
#include <vector>

int size = 10;
std::vector<int> myVector(size); // Creates a vector of 10 ints
myVector.push_back(42); // Resizes the vector and adds an element
```

The `std::vector` is a very versatile container in C++ and comes with a lot of handy functions. Here's a list of some common and useful member functions that you might find handy:
#### Size and Capacity

- `size()`: Returns the number of elements in the vector.
- `empty()`: Returns whether the vector is empty.
- `capacity()`: Returns the number of elements that can be held in currently allocated storage.
- `resize(n)`: Resizes the vector to contain `n` elements.
- `reserve(n)`: Requests that the vector's capacity be at least enough to contain `n` elements.
#### Element Access

- `operator[]`: Accesses an element at a specific index without bounds checking.
- `at(n)`: Accesses the element at position `n`, with bounds checking.
- `front()`: Returns a reference to the first element.
- `back()`: Returns a reference to the last element.
#### Modifiers

- `push_back(x)`: Adds an element to the end of the vector.
- `pop_back()`: Removes the last element from the vector.
- `insert(pos, val)`: Inserts an element at the specified position.
- `erase(pos)`: Erases an element at the specified position.
- `clear()`: Removes all elements from the vector.
- `swap(vec)`: Swaps the contents with another vector.
#### Iterators

- `begin()`: Returns an iterator pointing to the first element.
- `end()`: Returns an iterator pointing past the last element.
- `rbegin()`: Returns a reverse iterator pointing to the last element.
- `rend()`: Returns a reverse iterator pointing before the first element.
#### Miscellaneous

- `data()`: Returns a pointer to the first element in the array used internally by the vector.
