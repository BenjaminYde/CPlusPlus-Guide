# Dependency Management

## The Necessity of Dependency Management

Modern C++ development rarely happens in isolation. Projects often rely on external libraries for functionality like networking, databases, GUI, logging, testing, and more. The process of identifying, acquiring, integrating, updating, and managing external libraries (dependencies) in a software project is called dependency management.

Managing these dependencies efficiently is crucial for:

- **Maintainability**: Organized, modular code is easier to understand and modify, especially as they grow.
- **Reusability**: Allows leveraging existing code instead of reinventing the wheel.
- **Reproducibility**: Ensures that builds are consistent and predictable, regardless of the developer's machine or build server.
- **Security**: Helps to manage and audit the security of external dependencies.

## Dependency Management in Other Languages

While C++ has its unique challenges, other popular programming languages have generally enjoyed a more streamlined dependency management experience. This is largely due to factors like standardized package managers, virtual environments, and stable ABIs. 

I find it important that you know how other languages handle package manages and with what tools. Here's a quick look:

### C# (NuGet)

- **Package Manager**: NuGet is the standard package manager for .NET. It's tightly integrated with Visual Studio and the .NET ecosystem.
- **Central Repository**: NuGet Gallery (nuget.org) serves as the central repository for .NET packages.
- **Features**:
  - Handles dependency resolution, versioning, and installation.
  - Supports project-specific dependencies (via `packages.config` or `PackageReference`).
  - Integrates with MSBuild for building projects.
- **Advantages**:
  - **Standard and Well-Integrated**: NuGet is the official, widely adopted solution.
  - **Strong Tooling**: Visual Studio provides excellent support for NuGet.
  - **Stable ABI**: .NET's Common Language Runtime (CLR) provides a stable ABI, making binary compatibility much less of an issue.

### Python (pip, PyPI)

- **Package Manager**: pip is the standard package installer for Python.
- **Central Repository**: Python Package Index (PyPI) is the central repository for Python packages.
- **Virtual Environments**: Tools like venv and virtualenv allow creating isolated environments for projects, preventing dependency conflicts.
- **Features**:
  - **pip** installs packages from **PyPI** (or other sources).
  - `requirements.txt` files specify project dependencies.
  - **Wheels (`.whl`)** are a binary distribution format that speeds up installation.
- **Advantages**:
  - **Simple and Widely Used**: **pip** is easy to learn and use.
  - **Large and Active Community**: **PyPI** hosts a vast collection of packages.
  - **Effective Isolation**: Virtual environments prevent dependency clashes between projects.

### JavaScript (npm, Yarn)

- **Package Managers**: npm (Node Package Manager) is the default package manager for Node.js. Yarn is a popular alternative that offers improved performance and security features.
- **Central Repository**: The npm registry is the primary repository for JavaScript packages.
- **Features**:
  - `package.json` file defines project metadata and dependencies.
  - `package-lock.json` (or `yarn.lock`) creates a lockfile for deterministic builds.
  - `node_modules` directory stores project dependencies.
- **Advantages**:
  - **Massive Ecosystem**: The npm registry has the largest number of packages of any language.
  - **Fast and Efficient**: npm and Yarn are optimized for performance.
  - **Strong Community Support**: Large and active community, extensive tooling.

### Why Dependency Management is Generally Easier in These Languages

- **Standard Package Managers**: Each language has a dominant, officially supported package manager that is widely adopted.
- **Centralized Repositories**: Well-established central repositories make it easy to find and discover libraries.
- **Stable ABIs (Mostly)**: Languages that run on virtual machines (like Java and C#) or are interpreted (like Python and JavaScript) avoid many of the ABI issues that plague C++.
- **Virtual Environments/Isolation**: Python and JavaScript have mechanisms to isolate project dependencies, preventing conflicts.
- **Strong Tooling and Ecosystem Support**: These languages have benefited from extensive tooling and strong community support around dependency management.

## Challenges of Dependency Management in C++

C++ has historically lacked a standardized package manager and build system, leading to several unique challenges:

- **The Legacy Landscape**:
  - **No Standard Package Manager (Historically)**: Unlike many modern languages, C++ lacked a unified way to manage dependencies.
  - **Build System Fragmentation**: Multiple build systems (CMake, Make, Meson, etc.) with varying approaches to dependency handling.
  - **No Central Repository**: Unlike languages like Python (PyPI) or JavaScript (npm), there's no single, dominant repository for C++ libraries. Libraries are scattered across various locations (GitHub, GitLab, etc.).
- **Technical Problems**:
  - **Binary Compatibility**: C++ libraries often need to be compiled with the same compiler and settings as the main project to ensure binary compatibility. This is a significant challenge that package managers must address.
    - **Unstable ABI**: C++'s Application Binary Interface is not standardized across compilers or even versions of the same compiler.
    - **Compiler Flags**: Seemingly minor build settings can break compatibility.
    - **Name Mangling**: Differences in how compilers encode type information into names.
  - **Linking Complexities**: Static vs. dynamic linking choices and managing symbol visibility add complexity.
- **General Dependency Problems**:
  - **Transitive Dependencies**: Dependencies can themselves have dependencies, creating a complex graph that needs to be resolved.
  - **Version Conflicts**: Different parts of a project might require different versions of the same library, leading to conflicts.
  - **Dependency Hell**: Trying to find a set of compatible versions for a large number of dependencies can be a very frustrating experience.
  - **Security Vulnerabilities**: Dependencies may contain vulnerabilities that need to be tracked and patched.
- **Overlooked Factors**:
  - **Building from Source**: Building many dependencies from source, especially large or complex ones, can significantly increase build times, slowing down development.
  - **Lack of Training**: Developers may not be adequately trained in dependency management best practices.

## Approaches to Dependency Management

Here are the common approaches, ranging from manual to fully automated:

### 1. Manual Management (Not Recommended for Large Projects)

- **Downloading and Copying**: Download source code or pre-built binaries and manually place them in your project or a designated location.
- **Managing Include Paths and Libraries**: Manually configure your build system to include the necessary header files and link against the required libraries.

#### Pros:

- **Complete Control**: Developers have absolute control over every aspect of the dependency, including the specific version, build configuration, and location.
- **No External Tools**: No need to learn or install any additional tools beyond the basic build system.

#### Cons:

- **Tedious and Error-Prone**: Manually managing include paths, library paths, and linking is highly susceptible to human error.
- **Difficult to Update**: Updating libraries is a manual, time-consuming process.
- **Version Management Nightmare**: Keeping track of versions and resolving conflicts is extremely difficult.
- **Not Scalable**: Completely unsuitable for projects with many dependencies.

### 2. Build System Integration (CMake's FetchContent, ExternalProject):

- **Integrating with Build Systems**:  Modern build systems like CMake provide built-in features to automate parts of the dependency management process. These features allow you to specify dependencies directly within your build scripts (e.g., CMakeLists.txt). The build system then takes care of downloading (or cloning from a repository), configuring, and building these dependencies as part of the main project's build.

  - `FetchContent` (CMake 3.11+): Downloads dependencies at configure time. It makes the dependencies immediately available to the rest of the CMake build. Good for smaller dependencies that don't need to be built separately.
  - `ExternalProject` (Older): Downloads and builds dependencies at build time. Useful for larger dependencies or those with complex build processes.

#### Example (**CMake** with `FetchContent`)::

```cmake
include(FetchContent)

FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG        v1.15.2
)

FetchContent_MakeAvailable(googletest)

# Now you can use googletest in your project:
add_executable(my_test test.cpp)
target_link_libraries(my_test gtest gtest_main)
```

#### Pros:

- **Automated Download and Build**: Simplifies the process of obtaining and building dependencies, reducing manual effort.
- **Integration with Build System**: Dependencies are managed within the project's build scripts, making the process more cohesive.
- **Easier Updates**: Updating dependencies can be as simple as changing the Git tag or URL in the build script.

#### Cons:
  
- **Increased Build Times**: Building dependencies from source, especially large ones, can significantly increase overall build times.
- **Potential for Build Conflicts**: Dependencies might have conflicting build requirements.
- **Still Manual Version Management**: While simpler than fully manual, you still need to manually specify and update dependency versions in your build scripts. It is easy to forget about updating the versions of the libraries.
- **Limited to no caching**: This can lead to very slow build times when building from a clean state.

### 3. Dedicated C++ Package Managers:

This is the most robust and recommended approach for managing dependencies in larger C++ projects. Here are the key benefits:

- **Automated Dependency Resolution**: Automatically download, build (if necessary), and link dependencies.
- **Version Management**: Handle different versions of libraries and resolve conflicts.
- **Centralized (or Custom) Repositories**: Provide a place to find and share C++ libraries.
- **Build System Integration**: Integrate seamlessly with popular build systems like CMake.
- **Binary Caching**: Can cache pre-built binaries to speed up subsequent builds.

## TODO

> [!CAUTION]
> TODO

- dependency management with cmake
- dependency management with vcpkg
- dependency management with conan
- dependency management with bazel

## Talks

### 2024 

- [CppCon: 10 Problems Large Companies Have Managing C++ Dependencies and How to Solve Them - Augustin Popa](https://www.youtube.com/watch?v=kOW74IUH7IA&t=1100s)

### 2021

- [CppCon: Lessons Learned from Packaging 10,000+ C++ Projects - Bret Brown & Daniel Ruoso](https://www.youtube.com/watch?v=R1E1tmeqxBY)