# Friend

The `friend` keyword in C++ declares that a non-member function or another class is granted special access to the `private` and `protected` members of the class making the declaration.

This feature does not break encapsulation. Rather, it extends the encapsulation boundary of a class to include its trusted friends. It's a mechanism to signal a tight coupling and a special relationship between two entities that are conceptually part of the same interface, even if they are not part of the same class definition. Misuse can lead to poor design, but when used correctly, `friend` is an elegant and powerful tool.

## Friend Function

A `friend` function is not a member of the class, but it can access the private and protected members of the class.

- It is declared inside the class with the `friend` keyword but is defined outside the class scope.
- As a non-member, it does not have a `this` pointer and is not called with the dot (`.`) or arrow (`->`) operators.
- It must be passed an object instance as an argument to be able to access that object's members.

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

## Friend Class

A class can declare another class as its friend. This gives all member functions of the friend class access to the private and protected members of the declaring class.

- Friendship is a one-way street. If `A` declares `B` as a friend, `B `can access `A`'s private members, but A cannot access `B`'s.
- Friendship is not transitive. `A` friend of a friend is not a friend.
- Friendship is not inherited.

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

## Friend Member Function

For even more fine-grained control, you can declare a specific member function from another class as a friend, rather than the entire class.

- This grants access only to the specified function, following the principle of least privilege.
- This requires careful ordering of declarations and definitions, often involving forward declarations.

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