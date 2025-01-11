# How To Use Smart Pointers With Functions

## Passing By Value: Ownership Transfer and Sharing

Passing smart pointers by value (by copy) is a way to express a function's intent to take or share ownership of the managed resource. The behavior differs significantly between `std::unique_ptr` and `std::shared_ptr`.

### `std::unique_ptr`: Transferring Ownership with `std::move`

A `std::unique_ptr` can't be passed by value because it can't be copied, so passing it by value requires transferring ownership using `std::move`.

```c++
void takeOwnership(std::unique_ptr<MyClass> ptr) {
     // 'ptr' now exclusively owns the MyClass object.
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

- After the move, the original `unique_ptr` (`myPtr` in this case) becomes a `nullptr`. Attempting to dereference it results in undefined behavior.

### `std::shared_ptr`: Shared Ownership and Reference Counting

There's no need to move anything with `std::shared_ptr`: it can be passed by value (i.e. can be copied). `std::shared_ptr` is designed for shared ownership, which means multiple `std::shared_ptr` instances can own the same object. When a `std::shared_ptr` is copied, the reference count for the managed object increases.

**Example 1:**

```c++
void shareOwnership(std::shared_ptr<MyClass> ptr) {
    // ptr shares ownership of the MyClass object.
    std::cout << "Ref count inside function: " << ptr.use_count() << '\n';
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
void modifySharedPtr(std::shared_ptr<MyClass> ptr) {
    ptr = std::make_shared<MyClass>(); // Modifies the local copy only
}

int main() {
    auto myPtr = std::make_shared<MyClass>();
    modifySharedPtr(myPtr); 
    // 'myPtr' is unchanged. It still manages the original object.
    assert(myPtr.use_count() == 1);
}
```

## Passing By Reference (manipulate the ownership)

Passing a smart pointer by reference allows the function to manipulate the smart pointer itself, not just the object it points to. This means that the function can change where the smart pointer points to, or even make the smart pointer point to `nullptr`. This is fundamentally different from passing by value, which operates on a copy.

### `std::unique_ptr` by Non-Const Reference: Reseating and Nullifying

```c++
void resetPtr(std::unique_ptr<MyClass>& ptr) {
    ptr.reset(); // Releases ownership, ptr becomes nullptr
}

void reassignPtr(std::unique_ptr<MyClass>& ptr) {
    ptr = std::make_unique<MyClass>(); // Takes ownership of a new object
}

int main() {
    auto ptr = std::make_unique<MyClass>();

    resetPtr(ptr);
    assert(ptr == nullptr); // ptr is now null

    reassignPtr(ptr);
    assert(ptr != nullptr); // ptr now manages a new object
}
```

### `std::unique_ptr` by Const Reference: Limited Utility

Passing a `std::unique_ptr` by const reference is generally discouraged. It prevents the function from modifying the `unique_ptr` itself (reseating or nullifying), defeating the purpose of using a `unique_ptr` for ownership management. Const references to unique pointers are not a good idea, because they are misleading to programmers, who see a `unique_ptr` and expect to be able to modify it. If a function shouldn't be able to modify a `unique_ptr` or the underlying resource it points to, passing the `unique_ptr` as a raw pointer to a const resource is preferred.

Example of passing a const `unique_ptr`:

```c++
void observeOnly(const std::unique_ptr<MyClass>& ptr) {
    // ptr->modify(); // Error: Cannot modify through a const reference
    ptr->constMethod(); // Okay, if constMethod is a const member function of MyClass
    // ptr.reset(); // Error: Cannot modify the pointer itself
}
```

Example of passing a const raw ptr from a `unique_ptr`:

```c++
void processData(const MyClass* obj) {
    std::cout << "Processing data: " << obj->getData() << std::endl;
    // obj->setData(10); // Error: Cannot modify a const object
}

void main() {
    std::unique_ptr<MyClass> myPtr = std::make_unique<MyClass>(5);

    // Pass a raw pointer to the const object to processData
    processData(myPtr.get());
}
```

### `std::shared_ptr` by Non-Const Reference: Reseating for Shared Ownership


Passing a `std::shared_ptr` by non-const reference allows a function to reseat the `shared_ptr`, making it point to a different object. The original object's reference count is decremented, and the new object's reference count is incremented.

```c++
void ChangeWidget(std::shared_ptr<Widget>& ptr) {
    ptr = std::make_shared<Widget>(); // Reseats 'ptr', ref counts adjusted
    // Ref count will be 1
    std::cout << "Inside ChangeWidget, ref count: " << ptr.use_count() << std::endl; 
}

void main() {
    auto myPtr = std::make_shared<Widget>();
    // Ref count is 1
    std::cout << "Before ChangeWidget, ref count: " << myPtr.use_count() << std::endl; 
    ChangeWidget(myPtr);
    // Ref count is 1, myPtr now points to a new Widget.
    std::cout << "After ChangeWidget, ref count: " << myPtr.use_count() << std::endl; 
}
```

### `std::shared_ptr` by Const Reference: Observing with Shared Ownership

Passing a `std::shared_ptr` by const reference allows a function to observe or use the managed object without being able to modify the `shared_ptr` itself. The function cannot reassign the `shared_ptr` or make it nullptr, but it can access the underlying object. The reference count is not modified.

```c++
void observeWidget(const std::shared_ptr<Widget>& ptr) {
    // ptr = std::make_shared<Widget>(); // Error: Cannot modify a const shared_ptr
    std::cout << "Inside observeWidget, ref count: " << ptr.use_count() << std::endl; 
    // ptr->doSomething(); // Okay, assuming doSomething() is a method of Widget
}

void main() {
    auto myPtr = std::make_shared<Widget>();
    // Ref count is 1
    std::cout << "Before observeWidget, ref count: " << myPtr.use_count() << std::endl;
    observeWidget(myPtr);
    // Ref count is 1
    std::cout << "After observeWidget, ref count: " << myPtr.use_count() << std::endl; 
}
```

## Returning Smart Pointers from Functions

- **Returning `std::unique_ptr`**: This is the standard way for a function to transfer ownership of a dynamically allocated object to the caller. The function typically creates the object and returns it wrapped in a unique_ptr.
- **Returning `std::shared_ptr`**: This indicates that the function is returning an object that will be shared. The caller will receive a shared_ptr and participate in shared ownership.

```c++
std::unique_ptr<MyClass> createMyClass() {
    return std::make_unique<MyClass>(); // Transfer ownership to caller
}

std::shared_ptr<MyClass> getSharedResource() {
    static std::shared_ptr<MyClass> resource = std::make_shared<MyClass>(); // Shared resource
    return resource;
}
```

## Avoid Dangling References: Don't Pass Aliased Smart Pointer's Underlying Objects Directly

**Example (bad code):**

The key issue here is that the `MyClass` reference passed to `passByRef` can become a dangling reference.

```c++
std::shared_ptr<MyClass> global_ptr = std::make_shared<MyClass>();

void potentiallyDangling(MyClass& ref) {
    assign(); // Might reassign global_ptr, invalidating ref
    ref.func(); // Undefined behavior: ref may be dangling
}

void assign() {
    global_ptr = std::make_shared<MyClass>(); // Resets global_ptr
}

void main() {
    potentiallyDangling(*global_ptr); // Passing a reference to the object managed by global_ptr
}
```

**Example (good code):**

```c++
std::shared_ptr<MyClass> global_ptr = std::make_shared<MyClass>();

void safeFunction(MyClass& ref) {
    assign();
    ref.func(); // Safe: ref is guaranteed to be valid
}

void assign() {
    global_ptr = std::make_shared<MyClass>(); // Resets global_ptr
}

void main() {
    std::shared_ptr<MyClass> local_ptr = global_ptr; // Create a local shared_ptr
    safeFunction(*local_ptr); // Pass a reference to the object managed by local_ptr
}
```

## Favor Raw Pointers (`T*`) or References (`T&`) over Smart Pointers for General Function Parameters

When designing functions, prefer taking raw pointers (`T*`) or references (`T&`) as arguments for objects unless the function specifically needs to participate in managing the object's lifetime (i.e., transferring or sharing ownership).

- **Clarity of Intent**: Passing raw pointers or references clearly signals that the function does not own or manage the object's lifetime. It's solely concerned with operating on the object itself.
- **Flexibility and Reusability**: Functions accepting raw pointers or references can work with objects regardless of how they are allocated (unique, shared, weak, static, stack-allocated objects, ...).
- **Simplicity**: Passing raw pointers or references is generally simpler and involves less overhead than passing smart pointers, especially when no ownership transfer is needed.

### Example (Problematic - Overly Restrictive)

```c++
void processDataBad(std::shared_ptr<MyClass> data) {
    // This function only needs to access data, not manage it.
    data->doSomething();
}

// Caller's code
auto myData = std::make_shared<MyClass>();
processDataBad(myData); // Works

MyClass stackData;
// processDataBad(stackData); // Error: Cannot convert MyClass to std::shared_ptr<MyClass>
```

`processDataBad` unnecessarily restricts itself to working only with `std::shared_ptr`. It cannot accept a MyClass object allocated on the stack or managed in any other way. This limits its reusability and introduces artificial constraints. The programmer is forced to use a shared_ptr even when it isn't required, increasing the complexity of the code.

### Example (Improved - General and Flexible)

```c++
void processDataGood(MyClass* data) {
    if (data) { // Handle potential null pointers
        data->doSomething();
    }
}

// Caller's code
auto myData = std::make_shared<MyClass>();
processDataGood(myData.get()); // Works, passing a raw pointer

MyClass stackData;
processDataGood(&stackData); // Also works!

std::unique_ptr<MyClass> uniqueData = std::make_unique<MyClass>();
processDataGood(uniqueData.get()); // This works as well

processDataGood(nullptr); // We can even pass nullptr if needed
```