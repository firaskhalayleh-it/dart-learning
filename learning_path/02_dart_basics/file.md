

```dart
//strings 
String name = 'firas';
String title = 'khalayleh';
String fullName = 'hello $name $title';
print(fullName);
```

```dart
//numbers
int age = 14;
double weight = 80.234;
num height = 12;

```

```dart
//booleans
bool isTrue = true;
bool isFalse = false;
print(isTrue && isFalse);
```

```dart
//lists
List<String> names = ['firas', 'khalayleh'];
// example of list with different types
List<dynamic> names = ['firas', 10, true];
// example of list with different types
List<dynamic> names = [10, 'firas', true];
// example of iterable with different types
Iterable<dynamic> names1 = ['firas', 10, true];
// example of queue with different types
Queue<dynamic> names2 = ['firas', 10, true];
// example of stack with different types
Stack<dynamic> names3 = ['firas', 10, true];

print(names);
```

```dart
//maps
Map<String, int> scores = {'firas': [12,12,32], 'khalayleh': 20};
// more complex map
Map<String, dynamic> scores = {'firas': [12,12,32], 'khalayleh': 20};
// api response like map
Map<String, dynamic> scores = 
{
  'success': true,
  'data': {
    'id': 1,
    'name': 'firas',
    'age': 20,
    'skills': ['Dart', 'Flutter']
  }
}
print(scores);
```

```dart
//sets
Set<String> names = {'firas', 'khalayleh'};// the data is unique
// example of set with different types
Set<dynamic> names = {'firas', 10, true};
print(names);
```

```dart
//tuples
var tuple = (name:'firas',balance: 10);// tuple with named fields and immutable
tuple.name = 'ahmad';// error because it's immutable

print(tuple);
```

```dart
//enums
enum Priority { high, medium, low }
// example of enum with different types
enum Priority { high, medium, low, high2 }
// more complex enum
enum Priority { high, medium, low, high2 = 10 }
// enum with functions
enum Priority { high, medium, low, high2 = 10 

  String toString() {
    switch (this) {
      case high:
        return 'High';
      case medium:
        return 'Medium';
      case low:
        return 'Low';
      case high2:
        return 'High2';
    }
  }

  int getValue() {
    switch (this) {
      case high:
        return 1;
      case medium:
        return 2;
      case low:
        return 3;
      case high2:
        return 4;
    }
  }



}
print(Priority.high);
```

```dart
//classes
class Person {
  String name;
  int age;
  Person(this.name, this.age);
}
var person = Person('firas', 10);
print(person);
```

```dart
//functions
void printName(String name) {
  print(name);
}

printName('firas');

