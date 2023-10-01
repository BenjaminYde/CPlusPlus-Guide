The `friend` keyword in C++ is used to grant non-member functions or other classes access to private (and protected) members of a class. It's a powerful feature, but with power comes responsibility; it can break encapsulation if misused.
# Friend Function

A `friend` function is not a member of the class, but it can access the private and protected members of the class.

```c++
class Box 
{
private:
    int length;

public:
    Box(int l): length(l) {}
    friend int getLength(const Box& b);
};

int getLength(const Box& b) {
    return b.length;  // Can access private member of Box
}
```
### Characteristics:

- A friend function is not a member of the class, so it cannot be called using the object of the class.

- It's defined outside the class's scope but needs to be declared inside the class with the `friend` keyword.

- It cannot access the class's private members directly. Instead, they should be passed as arguments.
# Friend Class

When one class is declared as a friend of another class, the friend class can access the private and protected members of the other class.

```c++
class Box 
{
private:
    int length;

public:
    Box(int l): length(l) {}
    friend class BoxInspector;  // Declaring BoxInspector as a friend class
};

class BoxInspector 
{
public:
    int inspectLength(const Box& b) {
        return b.length;  // Can access private member of Box
    }
};
```
### Characteristics:

- Just because `BoxInspector` is a friend of `Box` doesn't mean `Box` has access to private members of `BoxInspector`. The `friend` relationship isn't mutual unless explicitly defined as such.

- Being a friend class doesn't grant any special relationship in terms of inheritance. It's strictly about access.
# Friend Member Function

A class can make certain member functions of another class its friend, rather than the whole class.

```c++
class Box 
{
private:
    int length;

public:
    Box(int l): length(l) {}
    
    // Only the inspectLength function of BoxInspector is a friend
    friend int BoxInspector::inspectLength(const Box& b);
};

class BoxInspector 
{
public:
    int inspectLength(const Box& b) {
        return b.length;  // Can access private member of Box
    }
};
```
### Characteristics:

- It provides a fine-grained control by allowing only specific member functions from another class to have access.