String streams in C++ are part of the `<sstream>` header and provide a convenient way to perform string manipulations, such as parsing and formatting. They are similar to iostreams like `std::cin` and `std::cout`, but operate on strings rather than standard input/output.

## Types of String Streams

- **`std::istringstream`**: Input string stream, are used to hold input from a data producer, such as a keyboard, a file, or a network.
- **`std::ostringstream`**: Output string stream, useful for creating formatted strings.
- **`std::stringstream`**: Both input and output operations can be performed.

## Standard streams

A **standard stream** is a pre-connected stream provided to a computer program by its environment. C++ comes with four predefined standard stream objects that have already been set up for your use. The first three, you have seen before:

- **cin** -- an istream object tied to the standard input
- **cout** -- an ostream object tied to the standard output
- **cerr** -- an ostream object tied to the standard error
- **clog** -- an ostream object tied to the standard error

## Basic Usage

#### Output String Stream (`std::ostringstream`)

You can use an output string stream to concatenate and format strings:

```c++
#include <sstream>
#include <iostream>

int main() {
    std::ostringstream oss;
    oss << "Hello, " << "world " << 2023;
    std::string fullString = oss.str();
    std::cout << fullString << std::endl;  // Output: Hello, world 2023
}
```
#### Input String Stream (`std::istringstream`)

You can use an input string stream to parse a string:

```c++
#include <sstream>
#include <iostream>

int main() {
    std::string input = "42 3.14 Hello";
    std::istringstream iss(input);
    
    int i;
    double d;
    std::string s;
    
    iss >> i >> d >> s;
    std::cout << "Parsed: " << i << ", " << d << ", " << s << std::endl;
}
```

Output:
```
Parsed: 42, 3.14, Hello
```
### Advanced Usage

#### Tokenization

You can tokenize a string using `std::getline` with a delimiter:

```c++
std::istringstream iss("one,two,three");
std::string token;
while (std::getline(iss, token, ',')) {
    std::cout << token << std::endl;
}
```

Output:
```
one
two
three
```
#### Manipulators

You can use manipulators like `std::setw`, `std::setprecision`, etc., to control the formatting:

```c++
std::ostringstream oss;
oss << std::setw(10) << std::setprecision(2) << 3.14159;
std::string s = oss.str();  // s contains "      3.1"
```
#### Error handling

You can check the stream's state using methods like `good()`, `eof()`, `fail()`, and `bad()`:

```c++
std::istringstream iss("42");
int i;
iss >> i;
if (iss.fail()) {
    // Handle error
}
```
#### Clearing a String Stream

You can clear the contents and state flags of a string stream using `str("")` and `clear()`:

```c++
std::stringstream ss;
ss << "Hello";
ss.str("");  // Clear contents
ss.clear();  // Clear state flags
```

### Use Cases

- **Parsing CSV or similar formats**: You can use `std::istringstream` to read each line and parse the tokens.

- **String Concatenation**: `std::ostringstream` can be more efficient than using `+` or `+=` for string concatenation in a loop.

- **Type Conversion**: String streams can be used for converting other types to strings and vice versa, although dedicated functions like `std::stoi` or `std::to_string` are generally more straightforward for this purpose.