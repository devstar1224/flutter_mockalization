# mockalization_factory

Annotations and runtime utilities for the [Mockalization](https://github.com/devstar1224/flutter_mockalization) mock data generator.

Add `@Mockalization()` to any Dart class and auto-generate realistic fake data with `build_runner`.

## Installation

```yaml
dependencies:
  mockalization_factory: ^2.0.0

dev_dependencies:
  build_runner: ^2.4.11
  mockalization_generator: ^2.0.0
```

## Quick Start

```dart
import 'package:mockalization_factory/mockalization_factory.dart';

part 'user.g.dart';

@Mockalization()
class User {
  @MockProperty(format: MockFormat.fullName)
  final String name;

  @MockProperty(format: MockFormat.email)
  final String email;

  final int age;
  final String? bio;

  User({required this.name, required this.email, required this.age, this.bio});
}
```

Run code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Use the generated mock factory:

```dart
final user = UserMock.fake();
final users = UserMock.fakeList(10);
```

## Annotations

### `@Mockalization()`

Marks a class for mock data generation.

### `@MockProperty()`

Configures field generation:

| Option | Type | Description |
|---|---|---|
| `format` | `MockFormat?` | Realistic data format (email, fullName, url, etc.) |
| `value` | `Object?` | Fixed value |
| `values` | `List<Object>?` | Random pick from list |
| `min` / `max` | `num?` | Numeric range |
| `length` | `int?` | String/collection length |
| `nullProbability` | `double?` | Null chance for nullable fields (0.0-1.0, default 0.3) |

### `@MockIgnore()`

Excludes a field from generation.

## MockFormat

33 formats available: `firstName`, `lastName`, `fullName`, `email`, `url`, `phoneNumber`, `streetAddress`, `city`, `country`, `companyName`, `word`, `sentence`, `uuid`, `hexColor`, and more.

## Supported Types

`String`, `int`, `double`, `bool`, `num`, `DateTime`, `List<T>`, `Set<T>`, `Map<K,V>`, `Enum`, `Duration`, `Uri`, `BigInt`, `Uint8List`, `dynamic` — all with nullable support.

## Documentation

See the full documentation at the [GitHub repository](https://github.com/devstar1224/flutter_mockalization).
