# The Compilation Process

## Overview

Compiling C++ code means translating human-readable source code into an executable program (or a library). This process involves several steps, each with its own purpose and tools. The process can be broken down into the following stages:

### 1. Coding 

The journey starts with writing C++ source files (`.cpp`) and their corresponding headers (`.h`). These files contain the core logic and structure of the program. The code you write directly influences the machine instructions generated later in the process, shaping the behavior of the final executable.

### 2. Preprocessing

Before the actual compilation begins, the preprocessor steps in to handle directives like `#include` and `#define`. It essentially expands the source code by inserting the contents of included files directly into the `.cpp` file. The result of this step is a fully expanded source file, often referred to as a **translation unit**, typically saved with a `.i` or `.ii` extension.

### 3. Compiling

Each translation unit is then fed into the compiler, where it is transformed into **assembly code**. Assembly is a low-level, human-readable representation of the program's instructions. During this stage, the compiler applies various optimizations to enhance performance and reduce resource usage. The output is an assembly file, commonly using extensions like `.s` or `.asm`.

### 4. Assembling

In the assembly phase, the human-readable assembly code is converted into **machine code** — a series of binary instructions that the CPU can directly execute. The resulting binary data is stored in an **object file**, which typically has an `.o` or `.obj` extension, depending on the platform and compiler. At this point, the file is no longer readable by humans.

### 5. Linking

The final step is linking, where the various object files produced during the assembly stage are combined. The linker resolves references between different translation units, ensuring that symbols and functions used across files are correctly connected. This process produces either an executable file or a dynamic library, ready to be run or loaded by other programs.

> [!CAUTION]
> TODO: Add image

## Preprocessing

Preprocessing is a crucial first stage in the compilation process that prepares your source code for translation into machine code. It involves executing preprocessor directives, which allow conditional compilation, macro definitions, file inclusions, and more.

### Key Tasks

#### 1. File Inclusion 

File inclusion involves inserting the contents of specified header files into your source file before compilation begins. This is typically achieved using the `#include` directive.

```c++
#include <iostream>
```

This line is replaced by the contents of <iostream> before actual compilation.

#### 2. Macro Expansion

Macro expansion replaces macro names with their corresponding defined values throughout the source code. This allows for easier code modification and improved readability.

```c++
#define PI 3.14159
```
Every occurrence of `PI` gets replaced with `3.14159`.

#### 3. Conditional Compilation

Conditional compilation enables including or excluding specific parts of the code based on compile-time conditions. It is often used to handle platform-specific code or debugging features.

```c++
#ifdef DEBUG
std::cout << "Debug mode is ON\n";
#endif
```

Only compiles if `DEBUG` is defined.

#### 4. Comment & Whitespace Removal

The preprocessor removes comments and unnecessary whitespace from the source code to streamline it for the next compilation phases. This step reduces the size of the code that the compiler has to process.

### Common Preprocessor Directives

- `#include`: Incorporates the contents of a file.
- `#define`: Defines macros for constants or functions.
- `#undef`: Undefines a macro.
- `#ifdef`, #ifndef, #endif: Allow conditional compilation based on whether macros are defined.
- `#pragma`: Direct compiler-specific behaviors, such as warnings or optimizations​

### Preprocessor Challenges

- **Excessive Use of Macros**: Leads to code that is difficult to debug or maintain.
- **Header File Dependencies**: Improper management of included files can cause compilation slowdowns or redundant inclusions.
- **Conditional Compilation Risks**: Mismanaged conditions may lead to inconsistent builds.

### Best Practices

- Use include guards or `#pragma` once to prevent multiple inclusions of the same header file:

```c++
#ifndef HEADER_NAME_H
#define HEADER_NAME_H

// Header contents

#endif
```

Alternatively, use #pragma once if supported by your compiler:

```c++
#pragma once
```

- Replace function-like macros with `constexpr` or inline functions to improve type safety and code readability:

```c++
constexpr double square(double x) {
    return x * x;
}
```

- Tools like **cppcheck** or **include-what-you-use** help in analyzing preprocessing impacts.

## Compiling

### Tokenization (Lexical Analysis)

The first step in the compilation process is to break the source code into smaller units called tokens. A token represents the smallest meaningful element of the code, such as keywords, operators, or literals. For example, the expression:

```
int a = 42;
```
would be split into the tokens `int`, `a`, `=`, `42`, and `;`.

The process of identifying these tokens is known as **lexical analysis**. By breaking down the code into tokens, the compiler can more easily construct the internal data structures needed for further analysis.

### Syntax Analysis (Parsing)

Once the source code is tokenized, the next step is to ensure that the arrangement of tokens follows the syntactic rules of the C++ language. This is known as syntax analysis or parsing.

Syntax analysis checks if the code adheres to the grammatical rules of C++. For example:

```
int b = a + 0;
```

This expression is syntactically correct, even though adding zero to a variable has no practical effect. The compiler's main concern at this stage is whether the structure of the code is correct, not its logical meaning.

If a piece of code is missing essential syntax elements, such as a semicolon, the compiler will raise a syntax error:

```
int b = a + 0
```

This will produce an error like: `g++: expected ';' at end of declaration`

### Semantic Analysis

After syntax analysis, the compiler performs semantic analysis, which focuses on the meaning of the code. The compiler checks whether the expressions in the code make sense within the context of the language.

For instance, consider the following incorrect code:

```
it b = a + 0;
```

Here, `it` is not a valid type in C++. During semantic analysis, the compiler will raise an error such as: `unknown type name 'it'`

This phase ensures that variables are declared before they are used, functions are called with the correct arguments, and types are compatible.

### Intermediate Code Generation

Once the analysis phases are complete, the compiler generates an intermediate representation (IR) of the code. This intermediate code is typically a simplified version of the source code that is easier for the compiler to optimize.

For example, a class method in C++ might be transformed into a plain C-style function during intermediate code generation:

```
class A {
public:
    int get_member() { return mem_; }
private:
    int mem_;
};
```

would be transformed into (abstract example):

```
struct A {
    int mem_;
};
int A_get_member(A* this) { return this->mem_; }
```

This transformation allows the compiler to apply optimizations more effectively.

### Optimization

During the optimization phase, the compiler improves the intermediate code to make it more efficient. Optimizations may include:

- **Constant folding**: Replacing expressions with their computed values at compile time.
- **Loop unrolling**: Reducing the overhead of loop control by expanding the loop body.
- **Dead code elimination**: Removing code that will never be executed.

For instance, the following code:

```
int a = 41;
int b = a + 1;
```

would be optimized to:

```
int a = 41;
int b = 42;
```

Modern compilers are highly proficient at optimizing code, often outperforming manual optimizations made by developers.

### Assembly Code Generation

After optimization, the compiler generates assembly code tailored to the target platform. Assembly code is a low-level, human-readable representation of machine instructions.

The assembly code is then passed to the assembler, which converts it into an object file containing machine code instructions.

Consider the following C++ project structure:

- main.cpp
- rect.cpp
- rect.h

After preprocessing, the compiler treats each .cpp file as a separate compilation unit. For example, when compiling main.cpp, the compiler does not include the implementation of functions from rect.cpp. It only trusts that the functions are defined elsewhere. Unresolved symbols will be filled in during the linking phase.

## Assembling

> [!CAUTION]
> TODO

## Linking

> [!CAUTION]
> TODO

## Notes

- gcc vs g++
- static vs dynamic libraries:
  - https://www.linkedin.com/pulse/differences-between-static-dynamic-libraries-nasser-abuchaibe/
  - see c++ compiling book page 53
  - when to use what
- what is inside object files? (see c++ compiling book page 26)
- talk about ABI
  - multiple compilers
  - cross platform


## Static vs Dynamic Libraries

> [!CAUTION]
> TODO

## References

### Books

- **Advanced C and C++ Compiling** (Paid)
  - Learning how to write C/C++ code is only the first step. To be a serious programmer, you need to understand the structure and purpose of the binary files produced by the compiler: object files, static libraries, shared libraries, and, of course, executables.
  - Link [here](https://www.amazon.com/Advanced-C-Compiling-Milan-Stevanovic/dp/1430266678)

### Links

- https://www.linkedin.com/pulse/c-compilation-steps-amit-nadiger/
- https://www.toptal.com/c-plus-plus/c-plus-plus-understanding-compilation
- https://subscription.packtpub.com/book/programming/9781789801491/1/ch01lvl1sec03/the-c-compilation-model
- https://app.studyraid.com/en/read/1708/24051/compilation-process
- https://mikelis.net/code-to-binary-an-in-depth-look-at-the-c-building-process/
- https://evolved-cpp.netlify.app/e-compiling-and-linking/01-the-compilation-process/#the-c-compilation-process
- https://elhacker.info/manuales/Lenguajes%20de%20Programacion/C++/Advanced%20C%20and%20C++%20Compiling%20(Apress,%202014).pdf