# Lambdas

## What is a Lambda?

A **lambda expression** (or simply "lambda") is a convenient way to define an anonymous, inline function object directly where it is needed. Think of it as a function you can write on the fly without needing to give it a name.

Under the hood, the compiler transforms a lambda into a unique, unnamed function object (a struct or class with an `operator()`).

## Why and When to Use Lambdas?

Lambdas primary purpose is to provide a **short, self-contained block of code to an algorithm or function that expects a callable object.**

- **Standard Library Algorithms**: This is the most common use case. Functions like `std::sort`, `std::for_each`, `std::find_if`, and `std::count_if` require a function to execute. Instead of defining a separate named function or a full functor struct, you can pass a lambda directly.

- **Asynchronous Operations**: When launching tasks with `std::async` or defining callbacks for completion handlers, lambdas provide a clean way to package the work to be done.

- **Local, One-Off Helpers**: If you need a small helper function that is only used in one specific place, a lambda avoids polluting the surrounding namespace with a named function that has no other purpose.

**In short: Use a lambda when you need a simple function for a single, specific location and don't want the boilerplate of a named function.**

```c++
std::vector<int> numbers = {5, 1, 4, 2, 3};

// Before lambdas, you needed a separate function:
bool isGreaterThan(int a, int b) {
    return a > b;
}
std::sort(numbers.begin(), numbers.end(), isGreaterThan);

// With a lambda, the logic is right where you need it. It's more readable.
std::sort(numbers.begin(), numbers.end(), [](int a, int b) {
    return a > b; // Sort in descending order
});
```

## Syntax Breakdown

The full syntax of a lambda expression can look intimidating, but it's composed of simple, distinct parts.

`[ capture_clause ] ( parameters ) mutable -> return_type { function_body }`

1.  **`[ capture_clause ]` (Required)**: The heart of a lambda's power. It specifies which variables from the surrounding scope are accessible inside the lambda and how they are accessed (by value or by reference). If you don't need to access any outside variables, you use empty brackets `[]`.

2.  **`( parameters )` (Optional)**: The parameter list, just like a regular function. You can omit the parentheses if the lambda takes no arguments.

3.  **`mutable` (Optional)**: Allows you to modify variables that were captured *by value*. By default, value-captures are `const` inside the lambda.

4.  **`-> return_type` (Optional)**: Explicitly specifies the return type. In most cases, the compiler can deduce this for you, so it's often omitted. You only need it in complex cases where the deduction might fail (e.g., multiple return statements of different, but convertible, types).

5.  **`{ function_body }` (Required)**: The code that executes when the lambda is called.

## Capturing Variables: The `[ ... ]` Clause

The capture clause is what makes a lambda more than just a simple function. It gives the lambda a "memory" of its surrounding environment.

### Capture by Value `[=]`

Captures all referred-to variables from the outer scope by making a **copy** of them.

  - **Pros**: Safe. The lambda operates on its own copies, so it cannot accidentally modify the original variables. The lambda is self-contained and can outlive the original scope without issues.
  - **Cons**: Can be inefficient if you copy large objects.

```c++
void captureByValueExample() {
    int x = 10;
    int y = 20;

    // Captures copies of x and y at the moment of creation.
    auto myLambda = [=]() { return x + y; };

    x = 100; // This change does NOT affect the lambda's captured copy of x.

    std::cout << myLambda(); // Prints 30, not 120.
}
```

### Capture by Reference `[&]`

Captures all referred-to variables from the outer scope by **reference**.

  - **Pros**: Efficient. No copying is involved. Allows the lambda to modify the original variables.
  - **Cons**: **Dangerous.** If the lambda's lifetime exceeds the lifetime of the captured variables, you will have a **dangling reference**. This is a very common bug.

```c++
void captureByReferenceExample() {
    int x = 10;
    int y = 20;

    // Captures references to the original x and y.
    auto myLambda = [&]() { x = 50; }; // Modifies the original x.

    myLambda();

    std::cout << x; // Prints 50.
}
```

### Mixed Captures (The Best of Both Worlds)

You can capture variables individually to be precise and safe. This is often the best practice.

  - `[x, &y]`: Capture `x` by value and `y` by reference.
  - `[=, &y]`: Capture `y` by reference, and all other variables by value.
  - `[&, x]`: Capture `x` by value, and all other variables by reference.

```c++
std::string message = "Initial";
int counter = 0;

// Capture 'message' by value (a safe copy)
// Capture 'counter' by reference (so we can modify it)
auto myLambda = [message, &counter]() {
    counter++;
    std::cout << message << ": " << counter << std::endl;
};

message = "Changed"; // Does not affect the lambda's copy
myLambda(); // Prints "Initial: 1"
myLambda(); // Prints "Initial: 2"

std::cout << "Final counter: " << counter; // Prints 2
```

## Advanced Lambda Concepts

### `mutable` Lambdas

The `mutable` keyword allows a lambda to modify its own internal state, specifically the variables it captured **by value**.

Each time you call a mutable lambda, it operates on the same captured members that live within the lambda object itself.

```c++
// A simple counter that lives entirely inside the lambda
auto counter_lambda = [count = 0]() mutable {
    count++;
    std::cout << "Internal count is: " << count << std::endl;
};

counter_lambda(); // Prints "Internal count is: 1"
counter_lambda(); // Prints "Internal count is: 2"
```

**Key Point**: This does **not** affect any original variable from which `count` might have been copied. The state change is entirely encapsulated within the lambda object.

### Generic Lambdas (C++14)

By using `auto` in the parameter list, you can create a generic, template-like lambda that works with different types.

```c++
// This one lambda can add ints, doubles, or concatenate strings.
auto add = [](auto a, auto b) {
    return a + b;
};

int sum_int = add(5, 10);          // 15
double sum_double = add(3.5, 4.2); // 7.7
std::string hello = add(std::string("Hello, "), std::string("World!"));
```

### Capture with Initialization (C++14)

This powerful feature lets you create and initialize a new variable directly within the capture clause. This is perfect for:

1.  Moving an object into a lambda (e.g., a `std::unique_ptr`).
2.  Creating a member variable for the lambda that doesn't exist in the outer scope.

```c++
// 1. Moving ownership into a lambda
auto ptr = std::make_unique<int>(42);

auto lambda_owner = [p = std::move(ptr)]() {
    std::cout << "Value is: " << *p << std::endl;
};
lambda_owner();
// 'ptr' in the outer scope is now null. The lambda owns the memory.

// 2. Creating a new member
auto lambda_with_member = [value = 5]() mutable {
    value *= 2;
    return value;
};
std::cout << lambda_with_member(); // Prints 10
std::cout << lambda_with_member(); // Prints 20
```

## How Not to Use Lambdas: Common Pitfalls

### 1. The Dangling Reference

This is the most critical error. Capturing a local variable by reference `[&]` and returning the lambda from the function. The lambda now holds a reference to memory that is no longer valid.

**How NOT to do it:**

```c++
// DO NOT DO THIS
std::function<void()> createBadLambda() {
    int local_value = 100;
    // This lambda captures a reference to local_value.
    // When createBadLambda returns, local_value is destroyed.
    return [&]() {
        std::cout << "Value is: " << local_value << std::endl;
    };
} // local_value dies here!

int main() {
    auto badLambda = createBadLambda();
    badLambda(); // UNDEFINED BEHAVIOR. Dangling reference.
}
```

**Solution**: Capture by value `[=]` if the lambda needs to outlive the scope.

### 2. Accidental Expensive Copies

Using the default `[=]` capture can be inefficient if you're working with large objects inside a loop.

**Inefficient Example:**

```c++
std::vector<std::string> large_data_vector; // Imagine this is very large
std::string large_string_to_find;          // Also large

// Inefficient: 'large_string_to_find' is copied for every single element comparison.
auto it = std::find_if(large_data_vector.begin(), large_data_vector.end(),
    [=](const std::string& item) { return item == large_string_to_find; }
);
```

**Solution**: If you are not modifying the captured object, capture by `const` reference. If it's safe to do so (the object will not go out of scope), capture by reference.

```c++
// Efficient: Capture by reference. No copy is made.
auto it = std::find_if(large_data_vector.begin(), large_data_vector.end(),
    [&](const std::string& item) { return item == large_string_to_find; }
);
```

### 3. Overly Complex Lambdas

A lambda should be short and simple. If your lambda body is more than a few lines long or contains complex logic, it's a strong sign that it should be a regular named function instead. This improves readability, testability, and reusability.