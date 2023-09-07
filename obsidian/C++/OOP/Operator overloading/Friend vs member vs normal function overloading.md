## Friend function overloading

The `friend` keyword in C++ allows a function or a class to access private and protected members of another class. When overloading operators, `friend` functions often come in handy because they allow for non-member functions to work with the private data of your classes.

```c++
class Cents 
{
private:
    int m_cents;
    
public:
    Cents(int cents) : m_cents(cents) {}

    friend Cents operator+(const Cents& a, const Cents& b);

    int getCents() const { return m_cents; }
};

Cents operator+(const Cents& a, const Cents& b) {
    return Cents(a.m_cents + b.m_cents);
}
```

Usage: 

```c++
Cents c1(5), c2(7);
Cents sum = c1 + c2;
```

## Member function overloading

```c++
class Cents 
{
private:
    int m_cents;
public:
    Cents(int cents) : m_cents(cents) {}

    Cents operator+(const Cents& other) const {
        return Cents(m_cents + other.m_cents);
    }

    int getCents() const { return m_cents; }
};
```

Usage: 

```c++
Cents c1(5), c2(7);
Cents sum = c1 + c2;
```

## Adding `Cents` and `int`

Using the member function method:

```c++
// This will not work with a member function because 
// the left operand must always be of type Cents.
Cents sum = 5 + c1;
```

Using the friend function method:

```c++
friend Cents operator+(const Cents& a, int value);
friend Cents operator+(int value, const Cents& a);
```

```c++
Cents operator+(const Cents& a, int value) {
    return Cents(a.m_cents + value);
}

Cents operator+(int value, const Cents& a) {
    return Cents(a.m_cents + value);
}
```

Usage:

```c++
Cents sum1 = 5 + c1; // now works!
Cents sum2 = c1 + 5; // also works!
```

## Normal function overloading

Using a friend function to overload an operator is convenient because it gives you direct access to the internal members of the classes you’re operating on. In the initial Cents example above, our friend function version of operator+ accessed member variable m_cents directly.

However, if you don’t need that access, you can write your overloaded operators as normal functions. Note that the Cents class above contains an access function (getCents()) that allows us to get at m_cents without having to have direct access to private members. Because of this, we can write our overloaded operator+ as a non-friend:

```c++
#include <iostream>

class Cents
{
private:
  int m_cents{};

public:
  Cents(int cents)
    : m_cents{ cents }
  {}

  int getCents() const { return m_cents; }
};

// note: this function is not a member function nor a friend function!
Cents operator+(const Cents& c1, const Cents& c2)
{
  // use the Cents constructor and operator+(int, int)
  // we don't need direct access to private members here
  return Cents{ c1.getCents() + c2.getCents() };
}
```

Usage: 

```c++
Cents c1(5), c2(7);
Cents sum = c1 + c2;
```

Because the normal and friend functions work almost identically (they just have different levels of access to private members), we generally won’t differentiate them. The one difference is that the friend function declaration inside the class serves as a prototype as well. With the normal function version, you’ll have to provide your own function prototype.

In general, a normal function should be preferred over a friend function if it’s possible to do so with the existing member functions available (the less functions touching your classes’s internals, the better). However, don’t add additional access functions just to overload an operator as a normal function instead of a friend function!