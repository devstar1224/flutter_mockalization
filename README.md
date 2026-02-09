# Mockalization

A Dart code generator that automatically creates mock data factories from annotated classes. Just add `@Mockalization()` and get realistic fake data instantly.

```dart
@Mockalization()
class User {
  @MockProperty(format: MockFormat.fullName)
  final String name;

  @MockProperty(format: MockFormat.email)
  final String email;

  final int age;
  final bool isActive;
  final List<String> roles;
  final DateTime? lastLogin;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.isActive,
    required this.roles,
    this.lastLogin,
  });
}

// Usage
final user = UserMock.fake();
final users = UserMock.fakeList(10);
```

---

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  mockalization_factory:
    git:
      url: https://github.com/devstar1224/flutter_mockalization.git
      path: mockalization_factory

dev_dependencies:
  build_runner: ^2.4.11
  mockalization_generator:
    git:
      url: https://github.com/devstar1224/flutter_mockalization.git
      path: mockalization_generator
```

## Getting Started

### 1. Annotate your class

```dart
import 'package:mockalization_factory/mockalization_factory.dart';

part 'user.g.dart';

@Mockalization()
class User {
  final String name;
  final int age;
  User({required this.name, required this.age});
}
```

### 2. Run the code generator

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Use the generated mock factory

```dart
final user = UserMock.fake();           // Single instance
final users = UserMock.fakeList(10);    // List of instances
```

Generated code:

```dart
extension UserMock on User {
  static User fake() {
    final faker = Faker();
    return User(
      name: faker.randomGenerator.string(10),
      age: faker.randomGenerator.integer(9999, min: 0),
    );
  }

  static List<User> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
```

---

## Supported Types

| Category | Types |
|---|---|
| Primitive | `String`, `int`, `double`, `bool`, `num` |
| Date | `DateTime` |
| Collections | `List<T>`, `Set<T>`, `Map<K,V>` (nested generics supported) |
| Enum | Any enum type |
| Class | Classes annotated with `@Mockalization` |
| Special | `BigInt`, `Duration`, `Uri`, `Uint8List`, `dynamic` |
| Nullable | All of the above with `?` suffix (`String?`, `int?`, etc.) |

---

## Annotations

### `@Mockalization()`

Marks a class for mock data generation. An extension with static `fake()` and `fakeList()` methods will be generated.

```dart
@Mockalization()
class Product { ... }

// Use a named constructor
@Mockalization(constructor: 'fromJson')
class Product { ... }
```

### `@MockProperty()`

Configures how a specific field is generated.

```dart
@Mockalization()
class Product {
  // Numeric range
  @MockProperty(min: 1000, max: 50000)
  final int price;

  // String/collection length
  @MockProperty(length: 5)
  final List<String> tags;

  // Realistic data via MockFormat
  @MockProperty(format: MockFormat.email)
  final String email;

  // Fixed value
  @MockProperty(value: 'admin')
  final String role;

  // Random pick from list
  @MockProperty(values: ['active', 'inactive', 'pending'])
  final String status;

  // Control null probability for nullable fields (default: 0.3)
  @MockProperty(nullProbability: 0.5)
  final String? nickname;
}
```

**All options:**

| Option | Type | Description |
|---|---|---|
| `value` | `Object?` | Always use this fixed value |
| `values` | `List<Object>?` | Randomly pick from this list |
| `format` | `MockFormat?` | Realistic data format |
| `min` | `num?` | Minimum value for numeric types |
| `max` | `num?` | Maximum value for numeric types |
| `length` | `int?` | Length for strings or collections |
| `minLength` | `int?` | Minimum length |
| `maxLength` | `int?` | Maximum length |
| `nullProbability` | `double?` | Probability of generating null (0.0-1.0, default 0.3) |

### `@MockIgnore()`

Excludes a field from mock generation. The corresponding constructor parameter must have a default value or be optional.

```dart
@Mockalization()
class Product {
  final String name;

  @MockIgnore()
  final String? internalId;

  Product({required this.name, this.internalId});
}
```

---

## MockFormat

Available formats for `@MockProperty(format: ...)`:

| Category | Formats | Example Output |
|---|---|---|
| **Person** | `firstName`, `lastName`, `fullName` | `John`, `Doe`, `John Doe` |
| **Internet** | `email`, `url`, `ipv4`, `ipv6`, `userName`, `password`, `userAgent`, `domainName` | `john@example.com`, `https://example.com` |
| **Address** | `streetAddress`, `city`, `country`, `zipCode`, `latitude`, `longitude` | `123 Main St`, `Seoul` |
| **Phone** | `phoneNumber` | `+1-555-123-4567` |
| **Company** | `companyName`, `companySuffix` | `Acme Corp`, `LLC` |
| **Lorem** | `word`, `sentence`, `paragraph` | `lorem`, `Lorem ipsum dolor sit.` |
| **Date** | `dateTime`, `past`, `future` | ISO 8601 string |
| **Color** | `hexColor`, `colorName` | `#FF5733`, `blue` |
| **Finance** | `creditCard`, `currencyCode`, `currencyName` | `4111111111111111`, `KRW` |
| **Misc** | `uuid`, `barcode` | `550e8400-e29b-...`, `1234567890123` |

---

## Advanced Usage

### Inheritance

Parent class fields are automatically included.

```dart
@Mockalization()
class ProductEntity {
  final int id;
  final String name;
  ProductEntity({required this.id, required this.name});
}

@Mockalization()
class SalesProductEntity extends ProductEntity {
  final int saleQuantity;
  SalesProductEntity({
    required this.saleQuantity,
    required super.id,
    required super.name,
  });
}

// Generates all fields including parent's
final sale = SalesProductEntityMock.fake();
```

### Nested Classes

Fields referencing other `@Mockalization`-annotated classes are generated recursively.

```dart
@Mockalization()
class Order {
  final UserEntity user;
  final List<ProductEntity> products;
  Order({required this.user, required this.products});
}

// Both user and products are auto-generated
final order = OrderMock.fake();
```

### Nested Collections

Deeply nested generics like `Map<String, List<int>>` or `List<Set<String>>` are fully supported.

```dart
@Mockalization()
class Dashboard {
  final Map<String, List<int>> metrics;
  final Set<String> categories;
  Dashboard({required this.metrics, required this.categories});
}
```

### Nullable Fields

Nullable fields randomly generate `null` or a value. The default null probability is 30%. Use `nullProbability` to customize.

```dart
@Mockalization()
class Profile {
  final String name;

  // 50% chance of null
  @MockProperty(nullProbability: 0.5)
  final String? bio;

  // 10% chance of null (almost always has a value)
  @MockProperty(nullProbability: 0.1)
  final String? avatar;

  Profile({required this.name, this.bio, this.avatar});
}
```

---

## Project Structure

```
flutter_mockalization/
├── mockalization_factory/       # Annotations & runtime utilities
│   └── lib/
│       ├── mockalization_factory.dart    # Barrel file
│       └── src/
│           ├── annotations/             # @Mockalization, @MockProperty, @MockIgnore
│           ├── mock_format.dart          # MockFormat enum
│           └── mock_helpers.dart         # Runtime helper functions
├── mockalization_generator/     # Code generator (dev dependency)
│   └── lib/
│       ├── builder.dart                 # build_runner entry point
│       └── src/
│           ├── mockalization_generator.dart  # Main generator
│           ├── field_collector.dart          # Constructor parameter collection
│           ├── annotation_reader.dart       # Annotation parsing
│           ├── fake_expression_factory.dart  # Type dispatcher
│           ├── code_builder.dart            # Extension code assembly
│           └── fake_expressions/            # Per-type expression generators
└── example/                     # Usage examples
```
