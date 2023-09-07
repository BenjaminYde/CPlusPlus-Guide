Lambdas are a way to define anonymous functions or function objects directly within the code. They can be thought of as unnamed, inline functions that you can declare where you need them.

The following is the syntax of a lambda:

```
[ captureClause ] ( parameters ) -> returnType
{
    statements;
}
```

- **Capture Clause (`[ captureClause ]`)**:
	- Defines how variables from the outer scope are available within the lambda.
	- Examples:
		- `[=]`: capture all referred variables by value.
		- `[&]`: capture all referred variables by reference.
		- `[a, &b]`: capture `a` by value and `b` by reference.

- **Parameters (`( parameters )`)**:
	- Similar to regular function parameters, this is where you declare the arguments that the lambda takes.
	- Example: `(int x, double y)`: takes an integer and a double as parameters.

- **Return Type (`-> returnType`)**:
	- Optional part that explicitly specifies the return type of the lambda.
	- Example: `-> int`: specifies that the lambda returns an integer.
	- If omitted, the compiler will deduce the return type based on the return statements in the lambda (as of C++14).

- **Body (`{ statements; }`)**:
	- Contains the code that will be executed when the lambda is called.
	- Example: `{ return x + y; }`: returns the sum of `x` and `y`.

```c++
int a = 10;
int b = 20;
auto lambda = [a, &b](int x, double y) -> int {
    b += a; // modifying 'b' since it's captured by reference
    return x + static_cast<int>(y);
};
int result = lambda(5, 3.2); // Calls the lambda with arguments 5 and 3.2
```

## Basic syntax

```c++
auto myLambda = [](int x, int y) { return x + y; };
int result = myLambda(3, 4); // result is 7
```

## Capturing variables

### Capture variable by value []

```c++
int a = 5;
auto lambda = [a]() { return a + 1; }; // Captures only 'a' by value
int result = lambda(); // result is 6
a = 20; // Changing 'a' outside the lambda does not affect the captured value
result = lambda(); // result is still 6
```

### Capture all variables by value [=]

`[=]` means that all local variables referred to inside the lambda are captured by value.

```c++
int a = 5;
int b = 10;
auto lambda = [=]() { return a + b; }; // Captures both 'a' and 'b' by value
int result = lambda(); // result is 15
a = 20; // Changing 'a' and 'b' outside the lambda does not affect the captured values
b = 20;
result = lambda(); // result is still 15
```

### Capture by reference [&]

`[&]` captures all available variables by reference, `[&x]` captures x by reference.

```c++
int a = 5;
int b = 10;
auto lambda = [&]() { a += 2; b += 3; }; // Captures both 'a' and 'b' by reference
lambda();
// Since 'a' and 'b' are captured by reference, their values are modified
std::cout << a; // Output is 7
std::cout << b; // Output is 13
```

### Combining captures

You can combine different capture modes to have precise control over how each variable is captured. Here's an example that illustrates this:

```c++
int a = 5;
int b = 10;
int c = 15;

// Capture 'a' by value, 'b' by reference, and all other referred variables (in this case 'c') by value
auto lambda = [a, &b, =]() { b += a; c = 20; return a + b + c; };

int result = lambda(); // result is 40, 'b' is modified, but 'a' and 'c' remain unchanged in the outer scope
std::cout << a; // Output is 5
std::cout << b; // Output is 15, since 'b' was captured by reference and modified
std::cout << c; // Output is 15, since 'c' was captured by value and not modified in the outer scope
```

In this example:

- `a` is captured by value, so its value inside the lambda is a snapshot and remains 5.
- `b` is captured by reference, so changes to `b` inside the lambda are reflected in the outer scope.
- `c` is captured by value due to the `[=]` part of the capture clause, so changes to `c` inside the lambda are not reflected in the outer scope.

## Mutable lambda

The `mutable` keyword in a lambda expression is used when you want to modify variables that have been captured by value. 

By default, variables captured by value in a lambda are `const`, meaning that they cannot be modified inside the lambda. When you use the `mutable` keyword, it allows you to change that behavior and modify the captured variables.

```c++
int x = 10;
auto lambda = [x]() mutable {
    x += 5;
    return x;
};

int result1 = lambda(); // result1 is 15
int result2 = lambda(); // result2 is also 15, not 20
std::cout << x; // Output is 10, since the original 'x' is unchanged
```

The `mutable` keyword provides a way to create lambdas that have a modifiable state, while still encapsulating that state within the lambda, separate from the surrounding code. It can be a useful tool when you want a lambda to have behavior that changes over time, without affecting the rest of your program.

## Return type deduction

The compiler can deduce the return type, or you can specify it explicitly.

```c++
auto myLambda = [](int x) -> double { return x * 0.5; };
```

## Generic lambdas

Since C++14, you can use auto in the parameter list to create a templated lambda:

```c++
auto genericLambda = [](auto x, auto y) { return x + y; };
```

## Usage with standard algorithms

Lambdas are often used with standard algorithms like `std::sort`, `std::for_each`, etc., to provide custom behavior.

```c++
std::sort(v.begin(), v.end(), [](int a, int b) { return a > b; }); 
// Sort in descending order
```