## Creating a unique_ptr

A [unique_ptr](https://learn.microsoft.com/en-us/cpp/standard-library/unique-ptr-class?view=msvc-170) does not share its pointer. It cannot be copied to another `unique_ptr`, passed by value to a function, or used in any C++ Standard Library algorithm that requires copies to be made. A `unique_ptr` can only be moved. This means that the ownership of the memory resource is transferred to another `unique_ptr` and the original `unique_ptr` no longer owns it. We recommend that you restrict an object to one owner, because multiple ownership adds complexity to the program logic. Therefore, when you need a smart pointer for a plain C++ object, use `unique_ptr`, and when you construct a `unique_ptr`, use the [make_unique](https://learn.microsoft.com/en-us/cpp/standard-library/memory-functions?view=msvc-170#make_unique) helper function.

```c++
std::unique_ptr<int> myPtr1(new int(5));
```

## Moving a unique_ptr

The following code will fail to compile because there would be multiple owners of the pointer:


```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2 = myPtr1;  // Error: Cannot copy unique_ptr
```

```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2;
ptr2 = ptr1;  // Error: Cannot assign unique_ptr
```

```c++
std::unique_ptr<int> myPtr1(new int(10));
std::unique_ptr<int> myPtr2(myPtr1);  // Error: Cannot transfer ownership from ptr1 to ptr2
```

We could use the `move` method to move the value pointed to by `myPtr1` to that of `myPtr2`.

```c++
std::unique_ptr<int> myPtr1 = std::make_unique<int>(5);  
std::unique_ptr<int> myPtr2 = std::move(myPtr1);
std::cout << *myPtr2 << std::endl;
```

Here's what is happening:

1. `std::unique_ptr<int> myPtr1 = std::make_unique<int>(25);` - This line creates a `unique_ptr` named `myPtr1` that manages an integer initialized to 25. The `unique_ptr` `myPtr1` is now the sole owner of this integer.
2. `std::unique_ptr<int> myPtr2 = std::move(myPtr1);` - This line uses `std::move` to transfer ownership of the dynamically allocated integer from `myPtr1` to a new `unique_ptr` named `myPtr2`. After this operation, `myPtr2` becomes the owner of the integer, and `myPtr1` is set to `nullptr`, meaning it no longer points to the integer.

The dynamically allocated integer is not deleted in this process. It is now owned by `myPtr2` and will be deleted when `myPtr2` is destroyed, or if `myPtr2` is reset or reassigned to another dynamically allocated integer.

After the `std::move` operation, you should not use `myPtr1` to access the integer as it no longer owns it. Trying to do so (e.g., by dereferencing `myPtr1`) would lead to undefined behavior since `myPtr1` now holds a `nullptr`.

## unique_ptr Array

```c++
// Create a unique_ptr to an array of 5 integers.
auto p = make_unique<int[]>(5);

// Initialize the array.
for (int i = 0; i < 5; ++i)
{
    p[i] = i;
    wcout << p[i] << endl;
}
```