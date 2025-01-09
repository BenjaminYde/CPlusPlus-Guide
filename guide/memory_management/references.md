# References

## What is a reference?

The core idea behind references is to work directly with an existing object without creating a copy. You create a reference using the `&` symbol in the declaration. This is useful when you want to pass large objects to a function without copying them, or when you want to modify the original object within the function.


```c++
void swap(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 10, y = 20;
    swap(x, y);
    std::cout << "x: " << x << ", y: " << y << std::endl; // Output: x: 20, y: 10
}
```

### Key Characteristics of References:

**Must be initialized:** A reference must be initialized to refer to an existing object when it is declared:


```c++
int num = 10;
int &refNum = num; // refNum is now an alias for num

// int &refNum;  // Error! Reference must be initialized.
```

**Cannot be reassigned**: Once a reference is bound to an object, it cannot be changed to refer to a different object. Think of it as a permanent alias:

```c++
int num1 = 10;
int num2 = 20;
int &refNum = num1; // refNum is an alias for num1

// refNum = num2;  // This does NOT make refNum an alias for num2. 
                  // It assigns the value of num2 to num1.
```

**Implicitly dereferenced**: You do not need a special operator to access the value of the object a reference refers to. It's used just like the original variable:

```c++
int value = 5;
int &refValue = value;

refValue = 15;  // Modifies 'value' directly
std::cout << value << std::endl; // Output: 15
```

## Other Use Cases

### Returning References from Functions

Functions can return references, allowing you to create chained operations or provide direct access to internal data members (use with caution!).

```c++
std::vector<int> myVector = {1, 2, 3, 4, 5};

int& getElement(int index) {
    return myVector[index];
}

int main() {
    getElement(2) = 10; // Directly modifies the element at index 2
    std::cout << myVector[2] << std::endl; // Output: 10
    return 0;
}
```

### Range-Based for Loops

References can be used in range-based for loops to modify elements of a container directly.

```c++
std::vector<int> numbers = {1, 2, 3, 4, 5};

for (int &num : numbers) {
    num *= 2; // Doubles each element in the vector
}
```

### Const References

To prevent accidental modifications, you can create const references. This ensures that the reference cannot be used to change the value of the object it refers to.

```c++
void printValue(const int &value) {
    std::cout << value << std::endl;
    // value = 10; // Error! Cannot modify a const reference
}
```

`const` references are great for passing objects to functions when you only need to read the object's data and want to guarantee that the function won't change it.