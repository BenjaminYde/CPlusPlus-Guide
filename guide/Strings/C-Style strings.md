In the C language, strings are represented as an array of characters. The last character of a string is a null character (`\0`) so that code operating on the string can determine where it ends. This null character is officially known as NUL, spelled with one L, not two.

For example, the string "hello" appears to be five characters long, but six characters worth of space are needed in memory to store the value.

![[Pasted image 20230903190613.png]]

They are a carryover from the C language and are supported in C++ for compatibility. 
Even though C++ provides a better string abstraction, it is important to understand the C technique for strings because they still arise in C++ programming. One of the most common situations is where a C++ program has to call a C-based interface in some third-party library or as part of interfacing to the operating system.
## Declaration and Initialization

You can declare a C-style string in several ways:

**Array Initialization**:
```c++
char str[] = "Hello";
```

Here, `str` is an array of 6 characters, including the null-terminating character.

**Pointer Initialization**:
```c++
const char* str = "Hello";
```

And of course, because the string is dynamically allocated, you have to remember to deallocate it properly when you’re done with it:

```c++
delete[] str;
```

Don’t forget to use array delete instead of normal delete!
## String Manipulation

The `<cstring>` header (or `<string.h>` in C) provides various functions for string manipulation:

**Length (`strlen`)**:
```c++
size_t len = strlen(str);
```

**Copy (`strcpy`)**:
```c++
char dest[50];
strcpy(dest, str);
```

**Concatenation (`strcat`)**:
```c++
strcat(dest, " World");
```

**Comparison (`strcmp`)**:
```c++
if (strcmp(str1, str2) == 0) {
    // strings are equal
}
```
## Limitations

### Buffer Overflow

C-style strings are susceptible to buffer overflows because functions like `strcpy` and `strcat` do not check for buffer size. This can lead to overwriting adjacent memory, causing undefined behavior or even security vulnerabilities.

```c++
char buffer[10];
strcpy(buffer, "This string is too long for the buffer");
```

In this example, the string "This string is too long for the buffer" is 39 characters long, not including the null-terminator. The `buffer` is only 10 characters long. Using `strcpy` here would result in a buffer overflow.
### Manual Memory Management

When you're dealing with dynamic string sizes, you have to manually allocate and deallocate memory using functions like `malloc()` and `free()` or `new` and `delete` in C++.

```c++
char *dynamicString = (char *)malloc(50);  // allocate 50 bytes
if (dynamicString == NULL) {
    // handle memory allocation failure
}
strcpy(dynamicString, "Hello, world!");
// ... some code ...
free(dynamicString);  // don't forget to free the memory
```

In this example, we allocate 50 bytes for `dynamicString`. We then copy "Hello, world!" into it. Finally, we free the memory. If you forget to free the memory, you'll have a memory leak.
### Limited Functionality

C-style strings don't have built-in methods for operations like finding a substring, replacing characters, or other common string manipulations. You have to use external functions or write your own.

```c++
const char *haystack = "Hello, world!";
const char *needle = "world";
char *result = strstr(haystack, needle);
if (result) {
    printf("Substring found at position %ld\n", result - haystack);
} else {
    printf("Substring not found\n");
}
```

In this example, we use the `strstr` function from `<cstring>` to find a substring. Unlike languages with built-in string types that have methods for these operations, C-style strings require you to use external functions.

## Summary

To understand the necessity of the C++ string class, consider the advantages and disadvantages of C-style strings.
### Advantages:

- They are simple, making use of the underlying basic character type and array structure.
- They are lightweight, taking up only the memory that they need if used properly.
- They are low level, so you can easily manipulate and copy them as raw memory.
- If you’re a C programmer—why learn something new?
### Disadvantages:

- They require incredible efforts to simulate a first-class string data type.
- They are unforgiving and susceptible to difficult-to-find memory bugs.
- They don’t leverage the object-oriented nature of C++.
- They require knowledge of their underlying representation on the part of the programmer.

The bottom line is that working with C-style strings requires remembering a lot of nit-picky rules about what is safe/unsafe, memorizing a bunch of functions that have funny names like strcat() and strcmp() instead of using intuitive operators, and doing lots of manual memory management.