## `std::find`

`std::find` is used to find the first occurrence of a value in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
auto it = std::find(numbers.begin(), numbers.end(), 30);

if (it != numbers.end()) {
    std::cout << "Found: " << *it; // Output: Found: 30
}
```
## `std::find_if`

`std::find_if` finds the first element that satisfies a given predicate.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
auto it = std::find_if(numbers.begin(), numbers.end(), [](int n) { return n > 30; });

if (it != numbers.end()) {
    std::cout << "Found: " << *it; // Output: Found: 40
}
```
## `std::count`

`std::count` counts occurrences of a specific value in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 10, 20, 10, 20};
int count = std::count(numbers.begin(), numbers.end(), 10);
std::cout << "Count: " << count; // Output: Count: 3
```
## `std::count_if`

`std::count_if` counts elements that satisfy a given predicate.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
int count = std::count_if(numbers.begin(), numbers.end(), [](int n) { return n > 30; });

std::cout << "Count: " << count; // Output: Count: 2
```
## `std::sort`
### sorting in ascending order

`std::sort` sorts the elements in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {50, 30, 10, 40, 20};
std::sort(numbers.begin(), numbers.end()); 
// numbers: {10, 20, 30, 40, 50}
```
### sorting in descending order

You can sort in descending order by providing a comparison function.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {50, 30, 10, 40, 20};
std::sort(numbers.begin(), numbers.end(), std::greater<int>()); 
// numbers: {50, 40, 30, 20, 10}
```
### sorting with custom comparator

You can provide a custom comparator to define your own sorting logic.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {50, 30, 10, 40, 20};
std::sort(numbers.begin(), numbers.end(), [](int a, int b) { return a > b; });
// numbers: {50, 40, 30, 20, 10}
```
### sorting in range

You can sort a specific range within a container.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {50, 30, 10, 40, 20};
std::sort(numbers.begin() + 1, numbers.begin() + 4); 
// numbers: {50, 10, 20, 30, 40}
```
### sorting a struct

You can sort a container of structs based on a specific attribute.

```c++
#include <algorithm>
#include <vector>

struct Person {
    std::string name;
    int age;
};

std::vector<Person> people = {{"Alice", 30}, {"Bob", 20}, {"Charlie", 40}};

std::sort(
	people.begin(), 
	people.end(),
	[](const Person &a, const Person &b) { return a.age < b.age; });
// people sorted by age: {{"Bob", 20}, {"Alice", 30}, {"Charlie", 40}}
```
## `std::for_each`

`std::for_each` applies a function to each element in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
std::for_each(numbers.begin(), numbers.end(), [](int &n) { n += 5; });

for (int n : numbers) {
    std::cout << n << " "; // Output: 15 25 35 45 55
}
```
## `std::reverse`

Reverses the elements in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
std::reverse(numbers.begin(), numbers.end()); // numbers: {50, 40, 30, 20, 10}
```
## `std::copy`

Copies elements from one range to another.

```c++
#include <algorithm>
#include <vector>

std::vector<int> source = {10, 20, 30, 40, 50};
std::vector<int> destination(5);
std::copy(source.begin(), source.end(), destination.begin()); // destination: {10, 20, 30, 40, 50}
```
## `std::transform`

Applies a given function to a range and stores the result in another range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
std::transform(numbers.begin(), numbers.end(), numbers.begin(), [](int n) { return n * 2; });
// numbers: {20, 40, 60, 80, 100}
```
## `std::replace`

Replaces all occurrences of a specific value in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 10, 40, 10};
std::replace(numbers.begin(), numbers.end(), 10, 99); // numbers: {99, 20, 99, 40, 99}
```

## `std::ranges`

Introduced in C++20, extends STL algorithms to work seamlessly with range-based syntax, improving readability and reducing boilerplate code.

### Example: `std::ranges::find`

Find the first occurrence of a value in a container.

```c++
#include <ranges>
#include <vector>
#include <iostream>

std::vector<int> numbers = {10, 20, 30, 40, 50};
auto it = std::ranges::find(numbers, 30);

if (it != numbers.end()) {
    std::cout << "Found: " << *it; // Output: Found: 30
}
```

### Example: `std::ranges::sort`

```c++
#include <ranges>
#include <vector>
#include <iostream>

std::vector<int> numbers = {50, 30, 10, 40, 20};
std::ranges::sort(numbers);
// numbers: {10, 20, 30, 40, 50}
```

### Example: Chaining Views

```c++
#include <ranges>
#include <vector>
#include <iostream>

std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

// Filter even numbers and double them
auto result = numbers | std::ranges::views::filter([](int n) { return n % 2 == 0; })
                      | std::ranges::views::transform([](int n) { return n * 2; });

for (int n : result) {
    std::cout << n << " "; // Output: 4 8 12 16 20
}
```

### Example: `std::ranges::copy`

Copy elements into another container.

```c++
#include <ranges>
#include <vector>
#include <iostream>

std::vector<int> source = {10, 20, 30, 40, 50};
std::vector<int> destination;

std::ranges::copy(source, std::back_inserter(destination));

for (int n : destination) {
    std::cout << n << " "; // Output: 10 20 30 40 50
}
```

## `std::partition`

Rearranges elements so that elements satisfying a given predicate appear before others.

```c++
#include <algorithm>
#include <vector>
#include <iostream>

std::vector<int> numbers = {1, 2, 3, 4, 5, 6};
auto it = std::partition(numbers.begin(), numbers.end(), [](int n) { return n % 2 == 0; });

// numbers: {2, 4, 6, 1, 3, 5} (even numbers first)
for (int n : numbers) {
    std::cout << n << " ";
}
```

## `std::unique`

Removes consecutive duplicate elements in a range.

```c++
#include <algorithm>
#include <vector>
#include <iostream>

std::vector<int> numbers = {1, 1, 2, 2, 3, 4, 4};
auto it = std::unique(numbers.begin(), numbers.end());
// numbers: {1, 2, 3, 4, ...}

numbers.erase(it, numbers.end()); // Remove undefined elements
for (int n : numbers) {
    std::cout << n << " "; // Output: 1 2 3 4
}
```

## `std::includes`

Checks if a sorted range contains all elements of another sorted range.

```c++
#include <algorithm>
#include <vector>
#include <iostream>

std::vector<int> v1 = {1, 2, 3, 4, 5};
std::vector<int> v2 = {3, 4};

bool isSubset = std::includes(v1.begin(), v1.end(), v2.begin(), v2.end());
std::cout << "v2 is a subset of v1: " << (isSubset ? "Yes" : "No"); // Output: Yes
```

## `std::any_of` / `std::all_of` / `std::none_of`

Checks if any, all, or none of the elements in a range satisfy a predicate.

```c++
#include <algorithm>
#include <vector>
#include <iostream>

std::vector<int> numbers = {1, 2, 3, 4, 5};

bool hasEven = std::any_of(numbers.begin(), numbers.end(), [](int n) { return n % 2 == 0; });
bool allPositive = std::all_of(numbers.begin(), numbers.end(), [](int n) { return n > 0; });
bool noneNegative = std::none_of(numbers.begin(), numbers.end(), [](int n) { return n < 0; });

std::cout << "Has even: " << hasEven << ", All positive: " << allPositive 
          << ", None negative: " << noneNegative;
```