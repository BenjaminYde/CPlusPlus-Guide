## std::find

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
## std::find_if

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
## std::count

`std::count` counts occurrences of a specific value in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 10, 20, 10, 20};
int count = std::count(numbers.begin(), numbers.end(), 10);
std::cout << "Count: " << count; // Output: Count: 3
```
## std::count_if

`std::count_if` counts elements that satisfy a given predicate.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
int count = std::count_if(numbers.begin(), numbers.end(), [](int n) { return n > 30; });

std::cout << "Count: " << count; // Output: Count: 2
```
## std::sort
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
## std::for_each

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
## std::reverse

Reverses the elements in a range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
std::reverse(numbers.begin(), numbers.end()); // numbers: {50, 40, 30, 20, 10}
```
## std::copy

Copies elements from one range to another.

```c++
#include <algorithm>
#include <vector>

std::vector<int> source = {10, 20, 30, 40, 50};
std::vector<int> destination(5);
std::copy(source.begin(), source.end(), destination.begin()); // destination: {10, 20, 30, 40, 50}
```
## std::transform

Applies a given function to a range and stores the result in another range.

```c++
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 30, 40, 50};
std::transform(numbers.begin(), numbers.end(), numbers.begin(), [](int n) { return n * 2; });
// numbers: {20, 40, 60, 80, 100}
```
## std::replace

Replaces all occurrences of a specific value in a range.

```
#include <algorithm>
#include <vector>

std::vector<int> numbers = {10, 20, 10, 40, 10};
std::replace(numbers.begin(), numbers.end(), 10, 99); // numbers: {99, 20, 99, 40, 99}
```

