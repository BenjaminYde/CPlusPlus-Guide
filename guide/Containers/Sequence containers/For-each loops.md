### Basic example

Here's a simple example of declaring, initializing, and using an array:

```c++
#include <iostream>

int main() {
    int numbers[] = {10, 20, 30, 40, 50};
    int size = sizeof(numbers) / sizeof(numbers[0]);

    std::cout << "Array elements are: ";
    for(int i = 0; i < size; i++) 
    {
        std::cout << numbers[i] << " ";
    }

    return 0;
}
```

### The auto keyword

Because element_declaration should have the same type as the array elements, this is an ideal case in which to use the `auto` keyword, and let C++ deduce the type of the array elements for us.

In the following for-each example, our element declarations are declared by value:

```c++
```cpp
std::string array[]{ "peter", "likes", "frozen", "yogurt" };
for (auto element : array) // element will be a copy of the current array element
{
    std::cout << element << ' ';
}
```

### References

Each array element iterated over will be copied into variable element. Copying array elements can be expensive, and most of the time we really just want to refer to the original element. Fortunately, we can use references for this:

```c++
```cpp
std::string array[]{ "peter", "likes", "frozen", "yogurt" };
for (auto& element: array) // The ampersand makes element a reference to the actual array element, preventing a copy from being made
{
    std::cout << element << ' ';
}
```

In the above example, element will be a reference to the currently iterated array element, avoiding having to make a copy. Also any changes to element will affect the array being iterated over.

And, of course, it’s a good idea to make your reference `const` if you’re intending to use it in a read-only fashion:

```c++
std::string array[]{ "peter", "likes", "frozen", "yogurt" };
for (const auto& element: array) // element is a const reference to the currently iterated array element
{
    std::cout << element << ' ';
}
```

### Loops and pointers

In order to iterate through the array, for-each needs to know how big the array is, which means knowing the array size. Because arrays that have decayed into a pointer do not know their size, for-each loops will not work with them!

```c++
int sumArray(const int array[]) // array is a pointer
{
    int sum{ 0 };
    for (auto number : array) // compile error, the size of array isn't known
    {
        sum += number;
    }
    return sum;
}

```