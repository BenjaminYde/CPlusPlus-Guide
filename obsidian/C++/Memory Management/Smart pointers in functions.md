## Passing By Value (lend the ownership)

Pass smart pointers _by value_ to lend their ownership to the function, that is when the function wants its own copy of the smart pointer in order to operate on it. Different smart pointers require different strategies:

### unique_ptr

A `std::unique_ptr` can't be passed by value because it can't be copied, so it is usually _moved_ around with the special function `std::move` from the Standard Library. This is move semantics in action:

```c++
void takeOwnership(std::unique_ptr<MyClass> ptr) {
    // ptr now owns the MyClass object.
    // Do something with ptr...
}

void main() {
    std::unique_ptr<MyClass> myPtr = std::make_unique<MyClass>();

	// This will throw a compile error
	takeOwnership(myPtr);

	// This will succeed
    // Pass ownership of the MyClass object to the takeOwnership function.
    // myPtr no longer owns the object after this line.
    takeOwnership(std::move(myPtr));
}
```

### shared_ptr

There's no need to move anything with `std::shared_ptr`: it can be passed by value (i.e. can be copied). `std::shared_ptr` is designed for shared ownership, which means multiple `std::shared_ptr` instances can own the same object. When a `std::shared_ptr` is copied, the reference count for the managed object increases.

**Example 1:**

```c++
void shareOwnership(std::shared_ptr<MyClass> ptr) {
    // ptr shares ownership of the MyClass object.
    std::cout << "Ref count inside function: " << ptr.use_count() << '\n';
    // Do something with ptr...
}

void main() {
    std::shared_ptr<MyClass> myPtr = std::make_shared<MyClass>();
    std::cout << "Ref count before function call: " << myPtr.use_count() << '\n';

    // Pass ownership of the MyClass object to the shareOwnership function.
    // myPtr still owns the object after this line.
    shareOwnership(myPtr);
    std::cout << "Ref count after function call: " << myPtr.use_count() << '\n';
}
```

```c++
Ref count before function call: 1
Ref count inside function: 2
Ref count after function call: 1
```

In this example, the `shareOwnership` function receives a `std::shared_ptr` by value. Because `std::shared_ptr` can be copied, we just pass `myPtr` directly to the function. This increases the reference count of the managed object.

After the function call, `myPtr` is still valid and it still owns the object. The reference count decreases when the function parameter `ptr` is destroyed at the end of `shareOwnership`, but because `myPtr` also owns the object, the object is not deleted. The reference count after the function call should be 1, demonstrating that `myPtr` is again the sole owner of the object.

**Example 2:**

This example shows that when a `std::shared_ptr` is passed by value to a function, the function gets a copy of the `std::shared_ptr`, and modifications to the copy do not affect the original `std::shared_ptr` that was passed in.

```c++
void Change(std::shared_ptr<MyClass> ptr) {
    // ptr here is a copy of the shared_ptr passed in. 
    // This creates a new Widget and makes ptr point to it.
    ptr = std::make_shared<MyClass>();
    // Now ptr points to a new MyClass object, but this does not affect 
    // the shared_ptr that was passed to Change.
}

int main() {
    // Create a new MyClass object and a shared_ptr that points to it.
    std::shared_ptr<MyClass> ptr = std::make_shared<MyClass>();

    // Pass a copy of ptr to Change.
    Change(ptr);

    // After Change returns, ptr still points to the original object.
    // It is unaffected by the assignment inside Change.
    // ...
}

```

## Passing By Reference (manipulate the ownership)

Passing a smart pointer by reference allows the function to manipulate the smart pointer itself, not just the object it points to. This means that the function can change where the smart pointer points to, or even make the smart pointer point to `nullptr`. This is different from passing by value, where the function operates on a copy of the smart pointer and cannot affect the original smart pointer in the calling scope.

### unique_ptr (non-const)

```c++
void resetPtr(std::unique_ptr<MyClass>& ptr) {
    // Reset the unique_ptr, causing it to give up ownership of its current object (if any)
    ptr.reset();
}

int main() {
    std::unique_ptr<MyClass> ptr = std::make_unique<MyClass>();
    resetPtr(ptr);
    // Now ptr is nullptr, because resetPtr has reset it.
    if (!ptr) {
        std::cout << "ptr has been reset\n";
    }
    return 0;
}
```

### unique_ptr (const)

This is considered bad practice because it's less clear about its ownership semantics. Taking a `unique_ptr` by `const` reference doesn't allow the function to take ownership of the resource, which is usually the purpose of using `unique_ptr`.

```c++
class MyClass {
public:
    void nonConstMethod() {
        // modify the object...
    }

    void constMethod() const {
        // observe the object...
    }
};

void test(const std::unique_ptr<MyClass>& ptr) {
    // ptr is a constant reference to a unique_ptr,
    // which is a mutable pointer to a constant MyClass object.
    // This means that you can't use ptr to modify the MyClass object,
    // or to make the unique_ptr point to another object or to nullptr.

    // ptr->nonConstMethod(); // This line would not compile, because the MyClass object is const.

    // But you can call const methods on the MyClass object.
    ptr->constMethod(); // This is OK.
}

void main() {
    std::unique_ptr<const MyClass> ptr = std::make_unique<MyClass>();
    test(ptr);
}

```


### shared_ptr (non-const)

**Take a `shared_ptr<widget>&` parameter to express that a function might reseat the shared pointer**

Take a `shared_ptr<widget>&` parameter to express that a function might reseat the shared pointer. Reseat” means making a reference or a smart pointer refer to a different object. The reference count of the `shared_ptr` will be 1 after the reseating operation within the `ChangeWidget` function.

```c++
void ChangeWidget(std::shared_ptr<widget>& ptr)
{
    // This will change the callers widget
    ptr = std::make_shared<widget>();
}
```


### shared_ptr (const)

#todo


**By Value vs By Reference vs By Const Reference**

```c++
void share(shared_ptr<widget> ptr);
```

When a function takes a `std::shared_ptr` by value, it receives a copy of the `std::shared_ptr`. This increases the reference count of the object managed by the `std::shared_ptr` because there's a new `std::shared_ptr` pointing to it. This function "shares" the object: it has a `std::shared_ptr` that owns the object and it can use the object as long as it needs to. If the function saves its `std::shared_ptr` for later use (e.g., by storing it in a data member or a static variable), the object won't be destroyed until all `std::shared_ptr`s that own it are destroyed. Thus, the function will retain the reference count.

```c++
void share(shared_ptr<widget>& ptr);
```

When a function takes a `std::shared_ptr` by non-const reference, it can modify the `std::shared_ptr`. This includes changing what object the `std::shared_ptr` points to (i.e., "reseating" the `std::shared_ptr`). This function "might" reseat the `std::shared_ptr`, which would change the object that the caller's `std::shared_ptr` points to.

```c++
void share(const shared_ptr<widget>& ptr);
```

When a function takes a `std::shared_ptr` by const reference, it can't modify the `std::shared_ptr`, but it can make a copy of it. If the function makes a copy of the `std::shared_ptr`, this would increase the reference count of the object that the `std::shared_ptr` points to. If the function doesn't make a copy, it won't affect the reference count. So this function "might" retain the reference count, depending on whether it makes a copy of the `std::shared_ptr`.

```c++
void shareOwnership(std::shared_ptr<MyClass>& ptr) {
    // Create a new shared_ptr and assign it to ptr
    ptr = std::make_shared<MyClass>();
}

int main() {
    std::shared_ptr<MyClass> ptr;
    shareOwnership(ptr);
    // Now ptr owns a MyClass object, because shareOwnership has made it point to a new object.
    if (ptr) {
        std::cout << "ptr now owns a MyClass object\n";
    }
    return 0;
}
```


## Do not pass a pointer or reference obtained from an aliased smart pointer

**Example (bad code):**

The key issue here is that the `MyClass` reference passed to `passByRef` can become a dangling reference.

```c++
// A global smart pointer
std::shared_ptr<MyClass> global_ptr = std::make_shared<MyClass>();

void passByRef(MyClass& ref) {
    assign();
    // ... and then it tries to use the ref
    // But if global_ptr was the last shared_ptr to the original MyClass,
    // the reg might have been deleted in assign(), and ref becomes a dangling reference!
    ref.func(); 
}

void assign() {
    // If global_ptr was the last shared_ptr, this destroys the old MyClass
    global_ptr = std::make_shared<Widget>(); 
}


void main() {
    // We're passing a reference to the MyClass owned by global_ptr directly to passByRef,
    // without taking a local copy of global_ptr.
    // This is risky because passByRef will call assign, which could potentially delete the Widget!
    passByRef(*global_ptr);
}
```

**Example (good code):**

```c++
// A global smart pointer
std::shared_ptr<MyClass> global_ptr = std::make_shared<MyClass>();

void passByRef(MyClass& ref) {
    assign();
    // Now, even if assign() resets global_ptr, ref remains valid 
    // because we have a local copy of the smart pointer in the main function.
    ref.func(); 
}

void assign() {
    // If global_ptr was the last shared_ptr, this destroys the old MyClass
    // But, we are safe as the object will still be alive due to the local shared_ptr in main.
    global_ptr = std::make_shared<MyClass>(); 
}

void main() {
    // Taking a local copy of the global_ptr before passing the MyClass object to passByRef
    // This ensures that the MyClass object will remain alive throughout the duration of the function, 
    // even if assign() resets global_ptr.
    std::shared_ptr<MyClass> local_ptr = global_ptr;
    passByRef(*local_ptr);
}
```

## For general use, take `T*` or `T&` arguments rather than smart pointers

Passing a smart pointer transfers or shares ownership and should only be used when ownership semantics are intended. A function that does not manipulate lifetime should take raw pointers or references instead.

**Example (bad):**

```c++
void f_bad(std::shared_ptr<MyClass>& ptr)
{
    // Here, it only uses the object pointed by the shared_ptr, not the shared_ptr itself
    // The lifetime of the object is not managed or needed in this function.
    ptr->func();
};

std::shared_ptr<MyClass> ptr_MyClass = std::make_shared<MyClass>();
// It passes a shared_ptr to the callee
// Even though the callee does not need to manage the lifetime of the object
f_bad(ptr_MyClass);

MyClass myClass;
f_bad(myClass); // This will cause a compilation error
			    // It fails to pass a stack-allocated myClass to the callee
				// The callee expects a shared_ptr<MyClass>, not a MyClass
```

**Example (good):**

```c++
void f_good(MyClass& my_class)
{
    // It uses the MyClass directly, without needing to worry about its lifetime
    my_class.func();
};

std::shared_ptr<MyClass> ptr_MyClass_good = std::make_shared<MyClass>();
// It passes the object owned by the shared_ptr to the callee
// Dereferencing the shared_ptr gives us a MyClass, which is what the callee expects
f_good(*ptr_MyClass_good);

MyClass myClass_good;
f_good(myClass_good); // This is now OK
					  // Now it's able to pass a stack-allocated MyClass to the callee
					  // The callee works fine with any MyClass, regardless of how it's allocated
```