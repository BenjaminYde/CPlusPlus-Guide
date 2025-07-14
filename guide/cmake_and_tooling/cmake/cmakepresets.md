# CMake Presets

## What are they?

Think of them as recipes for your build configurations. Instead of manually typing a long list of CMake commands and options every time you want to configure or build your project, you define them once in a JSON file. This makes your build process more reliable, shareable, and much easier to manage, especially as your project grows in complexity.

## The Basics: `CMakePresets.json` and `CMakeUserPresets.json`

At its core, the preset system uses two main files:

- `CMakePresets.json`: This is where you define the common build configurations for your project. You'll check this file into your version control system (like Git) so that everyone on your team has access to the same set of presets.

- `CMakeUserPresets.json`: This file is for your personal, local configurations. You might use it for your specific machine setup or for debugging purposes. This file should not be checked into version control. CMake will automatically look for and use this file if it exists.

Both files have the exact same format and live in the root directory of your project.

> [!TIP]
> Make sure to checkout the official docs: https://cmake.org/cmake/help/v3.31/manual/cmake-presets.7.html

## A Minimal Example

```json
{
  "version": 10,
  "cmakeMinimumRequired": {
    "major": 3,
    "minor": 31,
    "patch": 5
  },
  "configurePresets": [
    {
      "name": "debug",
      "displayName": "Debug",
      "generator": "Ninja",
      "binaryDir": "${sourceDir}/build/debug",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Debug"
      }
    },
  ]
}
```

In this example, we've defined a single "configure preset" named `debug`. When you use this preset, CMake will:

- Use the **Ninja** generator.
- Create the build directory at `${sourceDir}/build/debug`. The `${sourceDir}` is a macro that points to your project's root directory.
- Set the `CMAKE_BUILD_TYPE` cache variable to `Debug`.

You can use the following cmake preset commands in project's root directory:
```sh
# list all presets:
cmake --list-presets

# configure:
cmake --preset debug

# build:
cmake --build --preset debug
```

Without presets, you would have to type something like this every time:

```sh
cmake -S . -B build/default -G Ninja -D CMAKE_BUILD_TYPE=Debug
cmake --build build/default
```

## Pros and Cons

- **Reproducibility**: Ensures that everyone on the team, as well as your CI/CD pipelines, are using the exact same build configurations.

- **Simplicity**: Reduces long and error-prone command-line instructions to simple preset names.

- **Combinatorial Explosion**: If you have many compilers, build types, and options, you can end up with a very large number of presets. Inheritance can help manage this, but it can still become complex.

## Extended Example: Clang, debug & release on x64 architecture using CMake inherit

```json
{
  "version": 10,
  "cmakeMinimumRequired": {
    "major": 3,
    "minor": 31,
    "patch": 5
  },
  "configurePresets": [
    {
      "name": "clang-base",
      "hidden": true,
      "generator": "Ninja",
      "description": "Clang 19.1.2 (x86_64)",
      "binaryDir": "${sourceDir}/build/${presetName}",
      "architecture": {
        "value": "x64",
      },
      "cacheVariables": {
        "CMAKE_C_COMPILER": "clang",
        "CMAKE_CXX_COMPILER": "clang++",
        "CMAKE_CXX_COMPILER_VERSION": "19.1.2",
        "CMAKE_INSTALL_PREFIX": "${sourceDir}/install/${presetName}",
      }
    },
    {
      "name": "linux-clang-debug",
      "inherits": "clang-base",
      "displayName": "clang-debug-x64",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Debug",
      }
    },
    {
      "name": "linux-clang-release",
      "inherits": "clang-base",
      "displayName": "clang-release-x64",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Release",
      }
    },
  ]
}
```

### What happens here?

- The `inherits` key allows one preset to build upon another. This is the cornerstone of keeping your presets DRY (Don't Repeat Yourself). You can even inherit from multiple presets.
- We have a hidden `clang-base` preset that defines the common settings: using the Ninja generator and setting the C/C++ compilers to Clang (specific version).
- The `clang-debug` and `clang-release` presets inherit from `clang-base`.
- They each set the appropriate `CMAKE_BUILD_TYPE`.

## Conditional Configuration

Sometimes, a preset should only be available on a specific platform. This is where conditions are invaluable. They prevent you from seeing or using a Linux-specific preset on your Windows machine, for example.

```json
{
  "name": "linux-gcc",
  "inherits": "base",
  "displayName": "GCC for Linux",
  "condition": {
    "type": "equals",
    "lhs": "${hostSystemName}",
    "rhs": "Linux"
  },
  "cacheVariables": {
    "CMAKE_C_COMPILER": "gcc",
    "CMAKE_CXX_COMPILER": "g++"
  }
}
```

The `condition` object here checks if CMake's `${hostSystemName}` variable is "Linux". If it is, the `linux-gcc` preset will be available. If not, it's ignored. You can also check for environment variables, making it very flexible. `lhs` stands for Left-Hand Side, `rhs` stands for Right-Hand Side which is for the condition statement. Basically it says `if (lhs == rhs)`.

## The Build Preset: Executing the Compilation

While the `configurePreset` is the architect that lays out the blueprint for your project, the `buildPreset` is the construction crew that actually builds it. Its job is to take a prepared configuration and execute the compilation step, turning your source code into executables and libraries.

In short:

- `configurePreset` = `cmake .` (The recipe)
- `buildPreset` = `cmake --build build` (The cooking)

### Building Specific `targets`

This is the most common and powerful feature. Instead of building your entire project, you can compile just the specific parts you need.

Imagine your project has a main application, a test suite, and a documentation generator:

```json
"buildPresets": [
  {
    "name": "build-all",
    "displayName": "Build Everything",
    "configurePreset": "dev-config"
  },
  {
    "name": "build-app",
    "displayName": "Build App Only",
    "configurePreset": "dev-config",
    "targets": [ "MyAwesomeApp" ]
  },
  {
    "name": "build-tests",
    "displayName": "Build Unit Tests",
    "configurePreset": "dev-config",
    "targets": [ "unit_tests" ]
  }
]
```

### Controlling Parallelism with `jobs`

You can fine-tune the build performance by specifying the number of parallel jobs, which corresponds to the` -j` flag in `ninja`.

```json
"buildPresets": [
  {
    "name": "build-fast",
    "displayName": "Build (Max Parallelism)",
    "configurePreset": "dev-config",
    "jobs": 16
  },
  {
    "name": "build-single-threaded",
    "displayName": "Build (Single-Threaded for Debugging)",
    "configurePreset": "dev-config",
    "jobs": 1
  }
]
```

### Forcing a Clean Slate with `cleanFirst`

For Continuous Integration (CI) or when you suspect stale build artifacts are causing issues, you can force a clean build.

```json
"buildPresets": [
  {
    "name": "ci-build",
    "displayName": "CI Nightly Build",
    "configurePreset": "ci-config",
    "cleanFirst": true
  }
]
```

## Managing Complexity with `include`

As your project grows, your `CMakePresets.json` can become long and difficult to manage. To keep things organized, you can split your presets into multiple files and bring them together with the `include` key.

This is a best practice for larger projects, as it allows you to separate presets by function (e.g., CI vs. developer, platform-specific).

Example in the root `CMakePresets.json` file:

```json
{
  "version": 10,
  "include": [
    "cmake/developer-presets.json",
    "cmake/ci-presets.json"
  ]
}
```

In this example, CMake will load the root file and then pull in all the presets defined in the two included files, making them all available as if they were defined in a single location.