Character encoding is an important aspect to consider when working with strings, especially if your application needs to support internationalization or handle text in multiple languages.

## ASCII and Extended ASCII

By default, `std::string` is designed to store ASCII characters. ASCII characters are 7-bit characters that cover basic Latin letters, digits, and various control characters. Extended ASCII uses 8 bits and can represent additional characters, but it's not standardized across different systems.
## UTF-8

`std::string` can also store UTF-8 encoded strings. UTF-8 is a variable-length encoding that can represent any character in the Unicode standard, yet it is backward-compatible with ASCII. When using `std::string` to store UTF-8 text, keep in mind that many of the standard library functions (like `length()`, `substr()`, etc.) operate on a byte-level rather than a character-level, which can lead to issues.

For example:

```c++
std::string utf8_str = "Hello, 世界!";
std::cout << utf8_str.length();  // Output will be 13, not 9
```

In this example, the string contains 9 characters, but `length()` returns 13 because it counts bytes, not characters. The two Chinese characters ("世界") are each encoded as 3 bytes in UTF-8.
## Wide Strings

For encodings like UTF-16 or UTF-32, you can use wide string variants like `std::wstring`, `std::u16string`, or `std::u32string`. These are similar to `std::string` but use `wchar_t`, `char16_t`, or `char32_t` respectively to store characters.

```c++
std::wstring wide_str = L"Hello, 世界!";
```