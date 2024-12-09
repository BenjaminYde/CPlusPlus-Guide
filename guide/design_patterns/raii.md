# RAII (Resource Acquisition Is Initialization)

RAII (Resource Acquisition Is Initialization) is a programming idiom in C++ that ties the lifecycle of resources (e.g., memory, file handles, sockets, mutexes) to the lifetime of objects. It's a powerful and elegant way to manage resources, ensuring that they are properly acquired and released without the need for explicit cleanup code scattered throughout your application.

RAII guarantees that the resource is available to any function that may access the object.

Classes with open()/close(), lock()/unlock(), or init()/copyFrom()/destroy() member functions are typical examples of non-RAII classes:

```c++
std::mutex m;
 
void bad() 
{
    m.lock();             // acquire the mutex
    f();                  // if f() throws an exception, the mutex is never released
    if (!everything_ok())
        return;           // early return, the mutex is never released
    m.unlock();           // if bad() reaches this statement, the mutex is released
}
 
void good()
{
    std::lock_guard<std::mutex> lk(m); // RAII class: mutex acquisition is initialization
    f();                               // if f() throws an exception, the mutex is released
    if (!everything_ok())
        return;                        // early return, the mutex is released
}  
```

## Key Concepts of RAII

1. **Resource Acquisition During Initialization**:
   - A resource is acquired when an object is created (usually in its constructor).
   - This ensures the resource is valid as soon as the object is fully constructed.
2. **Resource Release During Destruction**:
   - The resource is released when the object goes out of scope (its destructor is called).
   - This ensures that the resource is automatically cleaned up, even if exceptions occur.
3. **Encapsulation**:
   - The resource management logic is encapsulated within a class, providing a clear and maintainable way to manage resources.

## Benefits of RAII

1. **Exception Safety**:
   - RAII objects clean up resources even when exceptions are thrown, avoiding resource leaks.
2. **Automatic Cleanup**:
   - No need to manually free resources (e.g., delete, close, unlock), reducing the risk of forgetting cleanup.
3. **Simpler Code**:
   - Resource management is centralized within the RAII class, making the code cleaner and easier to maintain.
4. **Deterministic Resource Management**:
   - The exact point at which the resource is released is determined by the object's scope.

## Examples

### `std::unique_ptr / std::shared_ptr`

These classes manage dynamic memory. The memory is automatically released when the smart pointer is destroyed.

```c++
std::unique_ptr<int> ptr(new int(42));
// No need to delete ptr; it will be cleaned up when it goes out of scope.
```

### `std::lock_guard / std::unique_lock:`

These classes manage locks. The lock is automatically released when the lock object goes out of scope.

```c++
std::mutex mtx;
{
    std::lock_guard<std::mutex> lock(mtx); // Lock is acquired.
    // Critical section
} // Lock is released here.
```

### File Management

Custom RAII class to manage file handles.

```c++
class File {
public:
    File(const std::string& filename) : file_(fopen(filename.c_str(), "r")) {
        if (!file_) {
            throw std::runtime_error("Failed to open file");
        }
    }
    ~File() {
        if (file_) {
            fclose(file_);
        }
    }
private:
    FILE* file_;
};
```