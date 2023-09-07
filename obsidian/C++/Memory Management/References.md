## Address-of operator (&)

The address of a variable can be obtained by preceding the name of a variable with an ampersand sign (`&`), known as _address-of operator_. For example:

```c++
int n = 42;
int a = &n;
std::cout << a; // prints the address of variable `a`
```

## Dereference operator (\*)

The dereference operator is the asterisk (`*`). When the `*` is placed before the name of a pointer variable, it dereferences the pointer, i.e., it retrieves the value stored at the memory address held by the pointer.

Let's say you have a pointer `p` pointing to an integer variable `x`:

```c++
int x = 10;
int* p = &x; // p now holds the address of x
```

You can use the dereference operator to access the value stored in `x` through the pointer `p`:

```c++
std::cout << *p; // This will print 10
```

You can also modify the value of `x` through the pointer `p`:

```c++
*p = 20; // This changes the value of x to 20
cout << x; // This will print 20
```

## Value by reference

Use `&` when you want to create a reference (alias) to an existing object. By using a reference, you can directly modify the original object within a function without making a copy of it. This is useful when you want to pass large objects to a function without copying them, or when you want to modify the original object within the function.

```c++
void modify_int(int &x) {
    x = 42;
}

int main() {
    int a = 10;
    modify_int(a);
    // 'a' is now 42 because it was passed by reference
}
```



