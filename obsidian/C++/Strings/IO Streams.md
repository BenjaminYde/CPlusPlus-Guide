### Basics

**Header Files**: Include the `<iostream>` header file to use these streams.

```c++
#include <iostream>
```

**Namespaces**: These streams are in the `std` namespace. You can use `using namespace std;` or prefix them with `std::`.

```c++
using namespace std;
// or
std::cout << "Hello, World!";
```

## Buffered vs Unbufferd IO

### Buffered IO 

In buffered IO, data is temporarily stored in a buffer before being moved to the target device. For example, when you write to `std::cout`, the data might first go into an internal buffer. Several scenarios can cause the buffer to flush, sending its data to the actual output:

1. **Buffer Full**: When the buffer is full, it automatically flushes its content.
2. **Manual Flush**: You can manually flush the buffer using `std::flush` or `std::endl`.
3. **Program Termination**: Buffers usually flush automatically when the program terminates successfully.

**Advantages of Buffered IO**

- **Efficiency**: Reading or writing large chunks at once is generally faster than one character at a time.
- **Control**: You have the opportunity to manipulate the data while it’s in the buffer.

**Example with `std::cout` (Buffered)**

In this example, we will use `std::cout` to write multiple lines of text,

```c++
#include <iostream>

int main() {
    std::cout << "This is Line 1 of buffered output";      
    std::cout << "This is Line 2 of buffered output";  
    std::cout << "This is Line 3 of buffered output";
    std::cout << std::flush;  // Manually flush the buffer
    return 0;
}

//Output: This is Line 1 of buffered outputThis is Line 2 of buffered outputThis is Line 3 of buffered output
```

All three lines are concatenated and appear as one long line because there are no line breaks (`\n` or `std::endl`) in between them. The `std::flush` at the end ensures that any buffered output is displayed immediately, but it doesn't insert a new line.

### Unbuffered IO

In unbuffered IO, data is moved directly to the target device without any intermediate storage. This is useful for error messages and diagnostic information, which you would want to be displayed immediately.

**Advantages of Unbuffered IO**

- **Immediacy**: Output is immediate, which is useful for time-sensitive data.
- **Simplicity**: There is no need to manage a buffer, which makes the code somewhat simpler for small tasks.

**Example with `std::cerr` (Unbuffered)**

```c++
#include <iostream>

int main() {
    std::cerr << "This is Line 1 of unbuffered output"; // Unbuffered, appears immediately
    std::cerr << "This is Line 2 of unbuffered output"; // Unbuffered, with flush (although unnecessary)
    std::cerr << "This is Line 3 of unbuffered output"; // Unbuffered, appears immediately
    return 0;
}

// Output: This is Line 1 of unbuffered outputThis is Line 2 of unbuffered outputThis is Line 3 of unbuffered output
```

## Console Output (`cout`)

**Basic Usage**: Output text or variables to the console.

**Buffered** by default, which means the output may be held in a buffer until the buffer is flushed. You can manually flush it using `std::flush` or `std::endl`.

```c++
std::cout << "Hello, World!" << std::endl; // Flushes the buffer automatically

// Output: Hello, World!
```

**Chaining**: You can chain multiple items together.

```c++
int x = 10;
cout << "Value of x: " << x << endl;
// Output: Value of x: 10
```

**Manipulators**: Use IO manipulators like `endl`, `setw`, `setprecision` etc., for formatting.

```c++
cout << setw(10) << setprecision(2) << 3.14159 << endl;
// output: 3.1
```
## Console Input (`cin`)

**Basic Usage**: Read data from the keyboard.

```c++
int a;
cin >> a;
// Output: (waits for user input)
```

If you input `42`, it will store `42` in `a`.

**Chaining**: Chain together for multiple inputs.

```c++
int a, b;
cin >> a >> b;
// Output: (waits for user input)
```
## Console Error (`cerr`)

**Basic Usage**: It’s generally used to display error messages or diagnostic information.

**Unbuffered**, meaning it writes data to the console immediately, making it ideal for reporting errors that might cause the program to terminate prematurely.

```c++
std::cerr << "An error occurred!" << std::endl; // Outputs immediately
// Output: An error occured
```

## Console Log (`clog`)

**Basic Usage**: Typically used for debugging messages or low-priority output that doesn't need to be displayed immediately.

**Buffered**, similar to `std::cout`. Output may be held until the buffer is flushed.

```c++
std::clog << "This is a log message." << std::endl;  // Buffered output
```
## Example

Here is how the full example's output would look like for different scenarios:

```c++
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    cout << "Enter two numbers: ";
    int a, b;
    if (cin >> a >> b) {
        cout << "Sum: " << a + b << endl;
    } else {
        cerr << "Invalid input" << endl;
        // Resetting stream state
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
    }
    return 0;
}
```