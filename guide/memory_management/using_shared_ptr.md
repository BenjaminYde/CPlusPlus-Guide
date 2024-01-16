## Creating a shared_ptr

The `shared_ptr` type is a smart pointer in the C++ standard library that is designed for scenarios in which more than one owner might have to manage the lifetime of the object in memory. After you initialize a `shared_ptr` you can copy it, pass it by value in function arguments, and assign it to other `shared_ptr` instances. All the instances point to the same object, and share access to one "control block" that increments and decrements the reference count whenever a new `shared_ptr` is added, goes out of scope, or is reset. When the reference count reaches zero, the control block deletes the memory resource and itself.

```c++
shared_ptr<int> ptr1 = make_shared<int>(5);
```

## Sharing a shared_ptr

```c++
// print the ptr count
cout << "ptr1 count = " << ptr1.use_count() << endl;

// create a new ptr from already existing one using constructor
shared_ptr<string> ptr2(ptr1);

// Shows the count after two pointer points to the same object.
cout << "ptr2 is pointing to the same object as ptr1" << endl;
cout << "ptr2 count = " << ptr2.use_count() << endl;
cout << "ptr1 count = " << ptr1.use_count() << endl;
```

## Using shared_ptr with functions

```c++
void use_shared_ptr_by_value(shared_ptr<int> sp);
void use_shared_ptr_by_reference(shared_ptr<int>& sp);
void use_shared_ptr_by_const_reference(const shared_ptr<int>& sp);

void use_raw_pointer(int* p);
void use_reference(int& r);

void test() {
    auto sp = make_shared<int>(5);

    // Pass the shared_ptr by value.
    // This invokes the copy constructor, increments the reference count
    use_shared_ptr_by_value(sp);

    // Pass the shared_ptr by reference or const reference.
    // In this case, the reference count isn't incremented.
    use_shared_ptr_by_reference(sp);
    use_shared_ptr_by_const_reference(sp);

    // Pass the underlying pointer or a reference to the underlying object.
    use_raw_pointer(sp.get());
    use_reference(*sp);

    // Pass the shared_ptr by value.
    // This invokes the move constructor, which doesn't increment the reference count
    // but in fact transfers ownership to the callee.
    use_shared_ptr_by_value(move(sp));
}
```

1. When a `shared_ptr` is passed by value, as in `use_shared_ptr_by_value(shared_ptr<int> sp)`, a copy of the `shared_ptr` is created. The copy and the original `shared_ptr` will both point to the same memory resource. This increases the reference count by one, as there are now two `shared_ptr` objects (the original and the copy) referring to the same memory resource.

2. When a `shared_ptr` is passed by reference, as in `use_shared_ptr_by_reference(shared_ptr<int>& sp)`, no new `shared_ptr` is created. Instead, the function operates on the original `shared_ptr` directly. As such, the reference count is not increased, because no new `shared_ptr` is created.

Passing a `shared_ptr` by reference can be useful when you want a function to modify the original `shared_ptr` or when you want to avoid the overhead of increasing and decreasing the reference count, which can be a relatively expensive operation.

Remember that although passing a `shared_ptr` by reference does not increase the reference count, the reference count can still be increased inside the function if a new `shared_ptr` is created and assigned to the same memory resource.