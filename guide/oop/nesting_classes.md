# Nested Classes

Nesting a class defines one class within the scope of another. This is a powerful feature for encapsulation and logical grouping, primarily used to either hide implementation details or to create helper classes that are tightly coupled to the outer class.

```c++
class Outer {
public:
    // A public nested class
    class PublicInner {
        // ...
    };

private:
    // A private nested class
    class PrivateInner {
        // ...
    };
};

// Public nested classes can be used with the outer class's scope qualifier
Outer::PublicInner my_inner_object;

// Private nested classes are an implementation detail and cannot be accessed from outside
// Outer::PrivateInner another_object; // COMPILE ERROR!
```

## Rules of Access

A common misconception is that a nested class can directly access the instance members of its enclosing class. **This is false**.

A nested class has no special access to the `this` pointer of its enclosing class. An instance of `Outer::Inner` is an independent object and is not tied to any specific instance of `Outer`.

```c++
#include <iostream>

class Outer {
private:
    int m_outer_instance_data = 42;
    static int s_outer_static_data;

public:
    class Inner {
    public:
        void show() {
            // ERROR: Cannot access non-static member of Outer directly.
            // It has no 'this' pointer to an Outer object.
            // std::cout << m_outer_instance_data << std::endl; 

            // OK: Can access static members of Outer directly.
            std::cout << "Outer's static data: " << s_outer_static_data << std::endl;
        }

        // To access instance data, you must be given a specific instance.
        void show_instance_data(const Outer& outer_instance) {
            // OK: Now we can access the private members of the given instance.
            std::cout << "Outer's instance data: " << outer_instance.m_outer_instance_data << std::endl;
        }
    };
};

// Static members still need to be defined
int Outer::s_outer_static_data = 100;

int main() {
    Outer outer_obj;
    Outer::Inner inner_obj;

    inner_obj.show();
    inner_obj.show_instance_data(outer_obj);
}
```

**Encapsulation**: The nested class can access the enclosing class's private and protected members. This is why in the example above, the `show_instance_data()` function inside `Inner` can access `m_outer_instance_data` of `Outer`.

## Real-World Examples

### Hiding Implementation Details (PIMPL Idiom)

The "Pointer to Implementation" (PIMPL) idiom hides a class's private members behind a pointer, which can reduce compilation times and create stable binary interfaces. A private nested class is a clean way to define this implementation.

widget.h:

```c++
#include <memory>

class Widget {
public:
    Widget();
    ~Widget(); // Destructor must be defined in the .cpp file

    void do_something();

private:
    // Forward-declare the private implementation details.
    class Impl; 
    // The only data member is a pointer to the hidden implementation.
    std::unique_ptr<Impl> m_pimpl; 
};
```

widget.cpp:

```c++
#include "Widget.h"
#include <vector>
#include <string>

// Now define the implementation class inside the .cpp file.
// It's completely hidden from users of Widget.h.
class Widget::Impl {
public:
    // All private data and helper functions go here.
    std::string m_name;
    std::vector<double> m_data;

    void secret_helper_function() { /* ... */ }
};

// Widget's constructor can now allocate and use the Impl
Widget::Widget() : m_pimpl(std::make_unique<Impl>()) {}
Widget::~Widget() = default;

void Widget::do_something() {
    // Forward calls to the implementation
    m_pimpl->secret_helper_function();
}
```

### Iterators

The following example shows how the `iterator` class, despite being its own separate class, works as an integral part of the `LinkedList`. It can access the internal `Node` structure to do its job, but remains neatly organized and namespaced within the `LinkedList` class itself.

```c++
#include <iostream>
#include <stdexcept>

class LinkedList {
private:
    // The Node is a private implementation detail of the list.
    // We can make its members public here because only LinkedList and its
    // nested iterator class can see the Node struct anyway.
    struct Node {
        int data;
        Node* next;
    };

    Node* m_head = nullptr;

public:
    // Destructor to clean up all nodes
    ~LinkedList() {
        while (m_head != nullptr) {
            Node* temp = m_head;
            m_head = m_head->next;
            delete temp;
        }
    }

    // A method to add elements to the list
    void push_front(int value) {
        Node* newNode = new Node{value, m_head};
        m_head = newNode;
    }

    //=========================================================
    // The public nested iterator class
    //=========================================================
    class iterator {
    private:
        Node* m_current_node;

    public:
        // The constructor is public so begin() and end() can create it.
        explicit iterator(Node* node) : m_current_node(node) {}

        // 1. Overload operator* (dereference) to get the data
        int& operator*() const {
            return m_current_node->data;
        }

        // 2. Overload operator++ (prefix increment) to move to the next node
        iterator& operator++() {
            if (m_current_node) {
                m_current_node = m_current_node->next; // Accessing Node's `next` pointer!
            }
            return *this;
        }

        // 3. Overload operator!= to check if two iterators are different
        bool operator!=(const iterator& other) const {
            return m_current_node != other.m_current_node;
        }
    };

    // The container's methods that return iterators
    iterator begin() {
        return iterator(m_head);
    }

    iterator end() {
        return iterator(nullptr);
    }
};
```

main.cpp:

```c++
int main() {
    LinkedList list;
    list.push_front(30);
    list.push_front(20);
    list.push_front(10);

    std::cout << "Iterating through the list:\n";
    
    // The `for` loop uses the public nested class `LinkedList::iterator`
    // and the begin()/end() methods.
    for (LinkedList::iterator it = list.begin(); it != list.end(); ++it) {
        std::cout << *it << std::endl; // Uses our overloaded operator*
    }

    // Because we defined begin() and end(), we can also use a modern
    // range-based for loop, which is even cleaner!
    std::cout << "\nUsing a range-based for loop:\n";
    for (int value : list) {
        std::cout << value << std::endl;
    }
}
```

Output:

```
Iterating through the list:
10
20
30

Using a range-based for loop:
10
20
30
```