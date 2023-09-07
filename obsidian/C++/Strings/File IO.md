The C++17 standard introduced the `<filesystem>` library, which provides a robust way of handling file and directory operations. Note that `<filesystem>` is largely about manipulating file paths, directories, and file attributes, rather than reading or writing file content.
### Basic Types

- **Path**: Represents a file path, provided by `std::filesystem::path`.
- **Directory Entry**: An object of type `std::filesystem::directory_entry` represents an element in a directory and holds a `path` object.
- **Directory Iterator**: Type `std::filesystem::directory_iterator` is used to iterate over directories.
### File Operations

- **File Exists**: `exists()`
- **Create Directory**: `create_directory()`
- **Create Directories**: `create_directories()`
- **Remove**: `remove()`
 **Remove All**: `remove_all()` to remove directories and their contents.
- **Rename**: `rename()`
- **Copy**: `copy()` and `copy_file()`
- **Copy Options**: Flags like `copy_options::recursive`, `copy_options::overwrite_existing`, etc.
- **Resize File**: `resize_file()`
- **File Time**: Manipulate or access the last write time using `last_write_time()`
### File Attributes

-  **File Size**: `file_size()`
-  **File Type**: `is_regular_file()`, `is_directory()`, etc.
-  **Permissions**: `permissions()`, `perms`, `perm_options`
-  **File Status**: `status()`, `symlink_status()`
### Filesystem Queries

-  **Space Info**: `space()`
-  **Current Path**: `current_path()`
-  **Absolute Path**: `absolute()`
-  **Relative Path**: `relative()`
### Path Manipulations

-  **Concatenation**: Using `/` operator
-  **Decomposition**: `root_name()`, `root_directory()`, `root_path()`, `relative_path()`, `parent_path()`, `filename()`, `stem()`, `extension()`
### Iterating Directories

-  **Recursive Directory Iterator**: `std::filesystem::recursive_directory_iterator`
-  **Filtering Iterators**: Using `directory_options` to filter the iteration.

## Examples

**Checking if a File or Directory Exists**

```c++
#include <iostream>
#include <filesystem>

int main() {
    std::filesystem::path p("some_file.txt");
    if (std::filesystem::exists(p)) {
        std::cout << p << " exists.\n";
    } else {
        std::cout << p << " does not exist.\n";
    }
    return 0;
}
```

**Creating a Directory**

```c++
#include <iostream>
#include <filesystem>

int main() {
    std::filesystem::path dir("new_directory");
    if (std::filesystem::create_directory(dir)) {
        std::cout << "Directory created successfully.\n";
    } else {
        std::cout << "Failed to create directory.\n";
    }
    return 0;
}
```

**Listing All Files in a Directory**

```c++
#include <iostream>
#include <filesystem>

int main() {
    std::filesystem::path dir(".");
    for (const auto &entry : std::filesystem::directory_iterator(dir)) {
        std::cout << entry.path() << std::endl;
    }
    return 0;
}
```

**Deleting a File**

```c++
#include <iostream>
#include <filesystem>

int main() {
    std::filesystem::path file_to_remove("some_file.txt");
    if (std::filesystem::remove(file_to_remove)) {
        std::cout << "File removed successfully.\n";
    } else {
        std::cout << "Failed to remove file.\n";
    }
    return 0;
}
```

**File Size and File Type**

```c++
#include <iostream>
#include <filesystem>

int main() {
    std::filesystem::path p("some_file.txt");
    if (std::filesystem::exists(p)) {
        auto fsize = std::filesystem::file_size(p);
        std::cout << "File size: " << fsize << " bytes.\n";
        if (std::filesystem::is_regular_file(p)) {
            std::cout << p << " is a regular file.\n";
        }
    }
    return 0;
}
```
