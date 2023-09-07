A function pointer is a variable that can store the address of a function. This means it can be used to call a function indirectly, through the pointer, rather than directly by name.

## Declaring a function pointer

The declaration includes the return type, followed by an asterisk, followed by the name of the pointer, and then the parameters of the function in parentheses. 

Here's a declaration of a function pointer that takes two integers and returns an integer:

```c++
int (*functionPtr)(int, int);
```

## Assigning a function to a pointer

You can assign a function to a pointer by using the function's name without parentheses:

```c++
int add(int x, int y) { return x + y; }
functionPtr = &add; // Assign the function 'add' to 'functionPtr'
```

## Calling the function via pointer

You can call the function using the pointer just like a regular function call:

```c++
int result = functionPtr(5, 3); // Calls 'add' function and result will be 8
```

## Using the function pointer as parameter

Function pointers can also be used as parameters to other functions. This allows the receiving function to call a function that was defined elsewhere:

```c++
void applyFunction(int (*func)(int, int), int x, int y) {
   int result = func(x, y);
   // Do something with result
}
applyFunction(add, 5, 3); // Calls 'add' function with 5 and 3
```

## Array of function pointers

You can even have an array of function pointers, allowing you to index into an array to call different functions:
`
```c++
int (*funcs[])(int, int) = {add, subtract, multiply, divide};
int result = funcs[0](5, 3); // Calls 'add' function
```