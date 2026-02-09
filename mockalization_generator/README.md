# mockalization_generator

Code generator for [Mockalization](https://github.com/devstar1224/flutter_mockalization). This package processes `@Mockalization`-annotated classes and generates extension-based mock data factories.

**This package should be added as a `dev_dependency`.** It is only used during code generation and not at runtime.

## Installation

```yaml
dependencies:
  mockalization_factory: ^2.0.0

dev_dependencies:
  build_runner: ^2.4.11
  mockalization_generator: ^2.0.0
```

## Usage

1. Annotate your class with `@Mockalization()` (from `mockalization_factory`):

```dart
import 'package:mockalization_factory/mockalization_factory.dart';

part 'user.g.dart';

@Mockalization()
class User {
  @MockProperty(format: MockFormat.email)
  final String email;
  final int age;
  User({required this.email, required this.age});
}
```

2. Run the generator:

```bash
dart run build_runner build --delete-conflicting-outputs
```

3. Use the generated extension:

```dart
final user = UserMock.fake();
final users = UserMock.fakeList(10);
```

## What Gets Generated

For each `@Mockalization` class, an extension is generated:

```dart
extension UserMock on User {
  static User fake() {
    final faker = Faker();
    return User(
      email: faker.internet.email(),
      age: faker.randomGenerator.integer(9999, min: 0),
    );
  }

  static List<User> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
```

## Features

- Supports 20+ Dart types including primitives, collections, enums, and custom classes
- Nullable fields generate `null` or value randomly
- Nested generics (`Map<String, List<int>>`) fully supported
- Inheritance support (parent class fields included)
- 33 `MockFormat` options for realistic data

## Documentation

See the full documentation at the [GitHub repository](https://github.com/devstar1224/flutter_mockalization).
