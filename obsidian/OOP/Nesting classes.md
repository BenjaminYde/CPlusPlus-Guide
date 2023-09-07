## Basics of Nested Classes:

Nesting classes in C++ refers to defining a class (called the "nested" or "inner" class) within another class (called the "enclosing" or "outer" class). Nested classes are a way to encapsulate a class that's used only within another class, keeping the global namespace clean and encapsulating the functionality more effectively.

```c++
class Outer 
{
private:
    int outer_data;

    class Inner 
    {
        int inner_data;
    public:
        Inner(int val) : inner_data(val) {}
        void show() {
            // Can access the private members of the Outer class
            std::cout << "Inner Data: " << inner_data << std::endl;
        }
    };

public:
    Outer(int val) : outer_data(val) {}

    void displayInner() {
        Inner in(10);
        in.show();
    }
};
```

### Characteristics & Behavior:

- **Access Control**: By default, the access specifiers (`private`, `protected`, `public`) work similarly for nested classes as they do for class members. In the above example, `Inner` is private within `Outer` and cannot be accessed directly outside of `Outer`. However, if `Inner` were public, we could create an `Inner` object like this: `Outer::Inner obj;`.

- **Encapsulation**: The nested class can access the enclosing class's private and protected members. This is why in the example above, the `show()` function inside `Inner` can access `outer_data` of `Outer`.

- **Declaration and Definition**: The nested class can be declared inside the outer class and defined outside, but the definition needs to use the scope of the outer class.

```c++
class Outer {
public:
    class Inner;  // Forward declaration of nested class
};

// Definition outside of the Outer class
class Outer::Inner {
    // Implementation of the Inner class
};
```