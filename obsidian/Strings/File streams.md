File streams in C++ allow you to perform file operations like reading and writing. They are part of the C++ Standard Library, and three primary classes handle file IO: `std::ifstream` for input (reading), `std::ofstream` for output (writing), and `std::fstream` for both.

These classes are defined in the `<fstream>` header.

## `std::ifstream` - Input File Stream

**Purpose**: Used for reading data from files.

```c++
#include <fstream>
#include <iostream>

int main() {
    std::ifstream inputFile("example.txt");
    std::string line;
    while (getline(inputFile, line)) {
        std::cout << line << std::endl;
    }
    inputFile.close();
    return 0;
}
```

## `std::ofstream` - Output File Stream

**Purpose**: Used for writing data to files.

```c++
#include <fstream>

int main() {
    std::ofstream outputFile("example.txt");
    outputFile << "Writing to file.\n";
    outputFile << "Another line.\n";
    outputFile.close();
    return 0;
}
```

## `std::fstream` - Input/Output File Stream

**Purpose**: Used for both reading and writing to/from files.

```c++
#include <fstream>
#include <iostream>

int main() {
    std::fstream file("example.txt", std::ios::in | std::ios::out | std::ios::app);

    // Writing to file
    file << "Writing via fstream.\n";

    // Reading from file
    file.seekg(0);  // Move the get pointer to the beginning
    std::string line;
    while (getline(file, line)) {
        std::cout << line << std::endl;
    }

    file.close();
    return 0;
}
```

### Common Methods

- `open(filename, mode)`: Opens a file with the specified mode (e.g., `std::ios::in`, `std::ios::out`, `std::ios::app`, etc.)
- `close()`: Closes the file.
- `eof()`: Checks if the end of the file has been reached.
- `getline()`: Reads a line from the file into a string.
- `>>` and `<<` operators for reading and writing.
- `seekg()` and `seekp()` for moving the read and write pointers, respectively.
### Error Handling

File streams set flags that can be checked to see if operations succeeded.

- `fail()`: Returns true if the last operation failed.
- `bad()`: Returns true if the stream is in an invalid state.
- `good()`: Returns true if the stream is in a valid state and no flags are set.

Example:

```c++
std::ifstream file("nonexistent.txt");
if (file.fail()) {
    std::cerr << "File could not be opened!";
}
```
### Stream State Reset

You can clear the stream's error state using `clear()` and reset the get/put position using `seekg()` and `seekp()`.

```c++
file.clear();
file.seekg(0, std::ios::beg);
```