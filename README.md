# Welcome to the C++ Guide 📚

This repository is a C++ guide designed which is designed to be easily opened using VS Code or Github. It contains extensive documentation, code examples, and best practices to help you become a proficient C++ programmer. 
The guide intends to be **to the point** so you can continue what really matters, programming.

## Execute Code Examples 🚀

Explore the `examples` directory for **interactive C++** code examples, easily executable inside a **Docker DevContainer** within **Visual Studio Code**. This setup ensures a consistent and streamlined coding environment, ideal for learning and experimentation.

## Guide Index 🗂️

**The following index contains categories with topics that are ready for visibility or completed.**  
There is **more content incoming** so the categories will **not be visible here** until it is completed.    
Want to see what topics are in todo? See the **index per category**.

### CMake & Tooling

- Tooling
  - [Compilers Overview](./guide/cmake_and_tooling/tooling/compilers.md)
  - [Compilation Process](./guide/cmake_and_tooling/tooling/compilation_process.md)
  - [Build Generators](./guide/cmake_and_tooling/tooling/build_generators.md)
  - [Dependency Management](./guide/cmake_and_tooling/tooling/dependency_management.md)
  - [Common Tools](./guide/cmake_and_tooling/tooling/tooling.md)
  - [ABI (Application Binary Interface)](./guide/cmake_and_tooling/tooling/abi.md)
- CMake
  - [Introduction](./guide/cmake_and_tooling/cmake/introduction.md)
  - [Generators](./guide/cmake_and_tooling/cmake/generators.md)
  - [Variables](./guide/cmake_and_tooling/cmake/variables.md)
  - [Targets](./guide/cmake_and_tooling/cmake/targets.md)
  - [Presets](./guide/cmake_and_tooling/cmake/cmakepresets.md)
  - Macros and Functions (todo)
  - [Best Practices](./guide/cmake_and_tooling/cmake/best_practices.md)

### Containers

- Sequence Containers
  - [Creating And Using Arrays](./guide/containers/sequence/creating_and_using_arrays.md)
  - [Loops](./guide/containers/sequence/loops.md)
  - [std::array](./guide/containers/sequence/std_array.md)
  - [Dynamic Allocation](./guide/containers/sequence/dynamic_allocation.md)
  - [Iterators](./guide/containers/sequence/iterators.md)
  - [Standard Library Functions (STL)](./guide/containers/sequence/standard_library_functions.md)
  - [std::list](./guide/containers/sequence/std_list.md)
  - [std::deque](./guide/containers/sequence/std_deque.md)
- Associative Containers
  - [std::set](./guide/containers/associative/std_set.md)
  - [std::map](./guide/containers/associative/std_map.md)
  - [std::multiset](./guide/containers/associative/std_multiset.md)
  - [std::multimap](./guide/containers/associative/std_multimap.md)
- Unordered Associative Containers
  - [std::unordered_set](./guide/containers/unordered_associative/std_unordered_set.md)
  - [std::unordered_map](./guide/containers/unordered_associative/std_unordered_map.md)
  - [std::unordered_multiset](./guide/containers/unordered_associative/std_unordered_multiset.md)
  - [std::unordered_multimap](./guide/containers/unordered_associative/std_unordered_multimap.md)
- Other
  - [Views](./guide/containers/views.md)
  - [Container Adaptors](./guide/containers/container_adaptors.md)

### Strings

- [String Literals](./guide/strings/string_literals.md)
- [IO Streams](./guide/strings/io_streams.md)
- [C Style Strings](./guide/strings/c_style_strings.md)
- [std::string](./guide/strings/std_string.md)
- [Character Encoding](./guide/strings/character_encoding.md)
- [std::string_view](./guide/strings/string_view.md)
- [String Streams](./guide/strings/string_streams.md)
- [std::format](./guide/strings/std_format.md)
- [printf](./guide/strings/printf.md)
- [File IO](./guide/strings/file_io.md)
- [File Streams](./guide/strings/file_streams.md)

### Functions

- [Function Pointers](./guide/functions/function_pointers.md)
- [Lambdas](./guide/functions/lambdas.md)

### Object Oriented Programming (OOP)

- [Classes vs Structs](./guide/oop/classes_vs_structs.md)
- [Constructors](./guide/oop/constructors.md)
- [Destructors](./guide/oop/destructors.md)
- [H and CPP Files](./guide/oop/h_and_cpp_files.md)
- [Static](./guide/oop/static.md)
- [Friend](./guide/oop/friend.md)
- [Nesting Classes](./guide/oop/nesting_classes.md)
- [Operator Overloading](./guide/oop/operator_overloading/_index.md)
  - [Introduction](./guide/oop/operator_overloading/introduction.md)
  - [Friend, Member and Normal Function Overloading](./guide/oop/operator_overloading/friend_vs_member_vs_normal_function_overloading.md)
  - [In and Out operators](./guide/oop/operator_overloading/in_and_out_operators.md)
  - [Assignment Operator](./guide/oop/operator_overloading/assignment_operator.md)
- [Object Relationships](./guide/oop/object_relationships.md)
- [Inheritance](./guide/oop/inheritance/_index.md)
  - [Introduction](./guide/oop/inheritance/introduction.md)
  - [Order of Construction](./guide/oop/inheritance/order_of_construction.md)
  - [Access Specifiers](./guide/oop/inheritance/access_specifiers.md)
  - [Functions and Overriding Behavior](./guide/oop/inheritance/functions_and_overriding_behavior.md)
  - [Hiding Functionality](./guide/oop/inheritance/hiding_functionality.md)
- [Virtual Functions](./guide/oop/virtual_functions/_index.md)
  - [Introduction](./guide/oop/virtual_functions/virtual_functions.md)
  - [Override and Final Specifier](./guide/oop/virtual_functions/override_and_final_specifier.md)
  - [Covariant Return Types](./guide/oop/virtual_functions/covariant_return_types.md)
  - [Destructors](./guide/oop/virtual_functions/destructors.md)
  - [Pure Virtual](./guide/oop/virtual_functions/pure_virtual.md)
  - [Multiple Inheritance](./guide/oop/virtual_functions/multiple_inheritance.md)
  - [Object Slicing](./guide/oop/virtual_functions/object_slicing.md)

### Memory Management

- [References](./guide/memory_management/references.md)
- [Pointers](./guide/memory_management/pointers.md)
- [Smart Pointers](./guide/memory_management/smart_pointers.md)
- [How To Use Smart Pointers With Functions](./guide/memory_management/smart_pointers_in_functions.md)
- [Shallow Copy vs Deep Copy](./guide/memory_management/shallow_copy_vs_deep_copy.md)

### Concurreny

- [Introduction](./guide/concurrency/introduction.md)
- STL Threads
  - [std::thread](./guide/concurrency/stl_threads/thread.md)
  - [std::async and std::future](./guide/concurrency/stl_threads/async_and_future.md)
- [POSIX vs STL Threads](./guide/concurrency/posix_vs_stl_threads.md)

### Typing

- [Auto](./guide/typing/auto.md)
- Casting
  - [implicit_casting](./guide/typing/casting/implicit_casting.md)
  - [explicit_casting](./guide/typing/casting/explicit_casting.md)
  - [static_cast](./guide/typing/casting/static_cast.md)
  - [dynamic_cast](./guide/typing/casting/dynamic_cast.md)
- [Using constexpr](./guide/typing/using_constexpr.md)
- [Using constval](./guide/typing/using_constval.md)

### Design Patterns & Idioms

- Idioms
  - [RAII](./guide/design_patterns/raii.md)
  - [PIMPL](./guide/design_patterns/pimpl.md)

### Todo

- Design patterns
- Templates
- Error handling

## References 📍

### General

- **CPP Reference**
    - This is more of a reference but contains examples and explanations that can serve as a learning resource.
    - Link [here](https://en.cppreference.com/w/)
- **Online C++ Compiler**
    - Link [here](https://www.tutorialspoint.com/compile_cpp_online.php)
- **C++ Core Guidelines**
  - Link [here](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
- **Google C++ Style Guide**
  - Link [here](https://google.github.io/styleguide/cppguide.html).

### Tutorials

* **LearnCpp**
    - Devoted to teaching you how to program in C++. Whether you’ve had any prior programming experience or not, the tutorials on this site will walk you through all the steps to write, compile, and debug your C++ programs, all with plenty of examples.
    - Link [here](https://www.learncpp.com/)
- **GeeksforGeeks**
    - Link [here](https://www.geeksforgeeks.org/c-plus-plus/?ref=shm_outind)
    - Offers a variety of tutorials and exercises ranging from basic to advanced topics.
    TutorialsPoint: C++ Tutorial

### Books

- **Software Architecture with C++**, (Paid)
  - Design modern systems using effective architecture concepts, design patterns, and techniques with C++20
  - By Adrian Ostrowski & Piotr Gaczkowski, April 2021, 540 pages
  - Link [here](https://www.packtpub.com/product/software-architecture-with-c/9781838554590).
- **Professional C++**, (Paid)
  - Professional C++, 5th Edition raises the bar for advanced programming manuals. Complete with a comprehensive overview of the new capabilities of C++20, each feature of the newly updated programming language is explained in detail and with examples.
  - By Marc Gregoire, Februari 2021, 1312 pages
  - Link [here](https://www.amazon.com.be/-/en/Marc-Gregoire/dp/1119695406).
- **Modern CMake for C++** (2nd edition), (Paid)
  - Write comprehensive, professional-standard CMake projects and ensure the quality and simplicity of your solutions
  - By Rafal Świdziński, May 2024, 502 pages
  - Link [here](https://www.packtpub.com/en-be/product/modern-cmake-for-c-9781805123361).
- **CMake Best Practices** (2nd edition), (Paid)
  - Write comprehensive, professional-standard CMake projects and ensure the quality and simplicity of your solutions
  - By Dominik Berner & Mustafa Kemal Gilor, Aug 2024, 502 pages
  - Link [here](https://www.packtpub.com/en-be/product/cmake-best-practices-9781835880654).
- **Advanced C and C++ Compiling** (Paid)
  - Learning how to write C/C++ code is only the first step. To be a serious programmer, you need to understand the structure and purpose of the binary files produced by the compiler: object files, static libraries, shared libraries, and, of course, executables.
  - Link [here](https://www.amazon.com/Advanced-C-Compiling-Milan-Stevanovic/dp/1430266678)
- **Learning C++** (Free)
  - Free unaffiliated eBook created from Stack Overflow contributors.
  - Link [here](https://riptutorial.com/Download/cplusplus.pdf)
- **More C++ Idioms** (Free)
  - Link [here](https://en.wikibooks.org/wiki/More_C%2B%2B_Idioms).
- **C++ Programming: Code patterns design** (Free)
  - Software design patterns are abstractions that help structure system designs.
  - Link [here](https://en.wikibooks.org/wiki/C%2B%2B_Programming/Code/Design_Patterns).
- **C++ Notes for Professionals book** (Free)
  - Link [here](https://goalkicker.com/CPlusPlusBook/).

### Interviews

- **C++ Interview Questions and Answers** (geeksforgeeks.org)
  - Link [here](https://www.geeksforgeeks.org/cpp-interview-questions/).