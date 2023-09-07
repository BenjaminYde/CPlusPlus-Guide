String views are a powerful feature introduced in C++17 to provide a lightweight, non-owning reference to a string. The `std::string_view` class is defined in the `<string_view>` header. 
## Basic Usage

A string view can be constructed from a `std::string`, a C-style string, or an array of characters:

```c++
#include <string_view>

std::string str = "Hello, world!";
std::string_view sv1(str);
std::string_view sv2("Hello, world!");
std::string_view sv3(str.data(), str.size());
```
## Non-Owning

`std::string_view` does not own the data it points to. It's just a view, so you must ensure that the data it points to outlives the string view:

```c++
std::string_view dangerous()
{
    std::string local = "local string";
    return local;  // Dangerous: returning string_view to local data
}
```
## Substrings and Slicing

You can easily create a substring view without allocating new memory:

```c++
std::string_view sv = "Hello, world!";
std::string_view sub_sv = sv.substr(0, 5);  // "Hello"
```
## Comparison

String views can be compared using the standard comparison operators (`==`, `!=`, `<`, `<=`, `>`, `>=`):

```c++
if (sv1 == sv2) {
    // Do something
}
```
## Conversion

You can create a `std::string` from a `std::string_view`:

```c++
std::string new_str = std::string(sv);
```
### Utility Functions

`std::string_view` provides various utility functions like `find`, `rfind`, `find_first_of`, `find_last_of`, etc., similar to `std::string`.
## Length and Data Access

- `length()` or `size()`: Get the length of the view.
- `empty()`: Check if the view is empty.
- `data()`: Get a pointer to the underlying data (not null-terminated).
## Performance Considerations

Using `std::string_view` can improve performance by eliminating the need for string copies in many scenarios. However, because it doesn't own its data, you have to be careful to ensure that the underlying data outlives the string view.
## Example

Here's a simple example demonstrating some of these features:

```c++
#include <iostream>
#include <string_view>

void print_length(std::string_view sv) {
    std::cout << "Length: " << sv.length() << "\n";
}

int main() {
    std::string str = "Hello, world!";
    std::string_view sv = str;

    print_length(sv);  // Output: Length: 13

    std::string_view sub_sv = sv.substr(0, 5);
    print_length(sub_sv);  // Output: Length: 5

    if (sv.find("world") != std::string_view::npos) {
        std::cout << "Found 'world' in string view\n";
    }

    return 0;
}
```