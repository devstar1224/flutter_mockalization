# Mockalization

Dart 클래스에 어노테이션을 붙이면 자동으로 목(mock) 데이터 팩토리를 생성해주는 코드 제너레이터입니다.

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

// 사용
final user = UserMock.fake();
final users = UserMock.fakeList(10);
```

---

## 설치

`pubspec.yaml`에 다음을 추가합니다:

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

## 사용법

### 1. 클래스에 어노테이션 추가

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

### 2. 코드 생성 실행

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. 생성된 코드 사용

```dart
final user = UserMock.fake();           // 단건 생성
final users = UserMock.fakeList(10);    // 리스트 생성
```

생성된 코드 예시:

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

## 지원 타입

| 분류 | 타입 |
|---|---|
| Primitive | `String`, `int`, `double`, `bool`, `num` |
| Date | `DateTime` |
| Collections | `List<T>`, `Set<T>`, `Map<K,V>` (중첩 지원) |
| Enum | 모든 enum 타입 |
| Class | `@Mockalization` 어노테이션이 붙은 클래스 |
| Special | `BigInt`, `Duration`, `Uri`, `Uint8List`, `dynamic` |
| Nullable | 위 모든 타입의 nullable 버전 (`String?`, `int?` 등) |

---

## 어노테이션

### `@Mockalization()`

클래스에 붙이면 목 데이터 생성 extension이 만들어집니다.

```dart
@Mockalization()
class Product { ... }

// named constructor 지정 가능
@Mockalization(constructor: 'fromJson')
class Product { ... }
```

### `@MockProperty()`

필드별로 생성 규칙을 지정합니다.

```dart
@Mockalization()
class Product {
  // 숫자 범위 지정
  @MockProperty(min: 1000, max: 50000)
  final int price;

  // 문자열/컬렉션 길이 지정
  @MockProperty(length: 5)
  final List<String> tags;

  // MockFormat으로 현실적 데이터 생성
  @MockProperty(format: MockFormat.email)
  final String email;

  // 고정 값
  @MockProperty(value: 'admin')
  final String role;

  // 선택 목록에서 랜덤
  @MockProperty(values: ['active', 'inactive', 'pending'])
  final String status;

  // nullable 필드의 null 생성 확률 (기본 0.3 = 30%)
  @MockProperty(nullProbability: 0.5)
  final String? nickname;
}
```

**모든 옵션:**

| 옵션 | 타입 | 설명 |
|---|---|---|
| `value` | `Object?` | 항상 이 값을 사용 |
| `values` | `List<Object>?` | 목록에서 랜덤 선택 |
| `format` | `MockFormat?` | 현실적 데이터 포맷 |
| `min` | `num?` | 숫자 최솟값 |
| `max` | `num?` | 숫자 최댓값 |
| `length` | `int?` | 문자열/컬렉션 길이 |
| `minLength` | `int?` | 최소 길이 |
| `maxLength` | `int?` | 최대 길이 |
| `nullProbability` | `double?` | null 생성 확률 (0.0~1.0, 기본 0.3) |

### `@MockIgnore()`

필드를 목 데이터 생성에서 제외합니다. 해당 생성자 파라미터에 기본값이 있거나 optional이어야 합니다.

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

`@MockProperty(format: ...)` 에 사용 가능한 포맷 목록입니다.

| 분류 | 포맷 | 예시 출력 |
|---|---|---|
| **Person** | `firstName`, `lastName`, `fullName` | `John`, `Doe`, `John Doe` |
| **Internet** | `email`, `url`, `ipv4`, `ipv6`, `userName`, `password`, `userAgent`, `domainName` | `john@example.com`, `https://example.com` |
| **Address** | `streetAddress`, `city`, `country`, `zipCode`, `latitude`, `longitude` | `123 Main St`, `Seoul` |
| **Phone** | `phoneNumber` | `+1-555-123-4567` |
| **Company** | `companyName`, `companySuffix` | `Acme Corp`, `LLC` |
| **Lorem** | `word`, `sentence`, `paragraph` | `lorem`, `Lorem ipsum dolor sit.` |
| **Date** | `dateTime`, `past`, `future` | ISO 8601 문자열 |
| **Color** | `hexColor`, `colorName` | `#FF5733`, `blue` |
| **Finance** | `creditCard`, `currencyCode`, `currencyName` | `4111111111111111`, `KRW` |
| **Misc** | `uuid`, `barcode` | `550e8400-e29b-...`, `1234567890123` |

---

## 고급 사용법

### 상속 지원

부모 클래스의 필드도 자동으로 포함됩니다.

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

// 부모 필드 포함하여 생성
final sale = SalesProductEntityMock.fake();
```

### 중첩 클래스

`@Mockalization`이 붙은 다른 클래스를 필드로 사용하면 자동으로 재귀 생성됩니다.

```dart
@Mockalization()
class Order {
  final UserEntity user;
  final List<ProductEntity> products;
  Order({required this.user, required this.products});
}

// user와 products 모두 자동 생성
final order = OrderMock.fake();
```

### 중첩 컬렉션

`Map<String, List<int>>`, `List<Set<String>>` 같은 중첩 제네릭도 지원합니다.

```dart
@Mockalization()
class Dashboard {
  final Map<String, List<int>> metrics;
  final Set<String> categories;
  Dashboard({required this.metrics, required this.categories});
}
```

### Nullable 필드

nullable 필드는 기본적으로 30% 확률로 null이 생성됩니다.
`nullProbability`로 확률을 조절할 수 있습니다.

```dart
@Mockalization()
class Profile {
  final String name;

  // 50% 확률로 null
  @MockProperty(nullProbability: 0.5)
  final String? bio;

  // 10% 확률로 null (거의 항상 값 생성)
  @MockProperty(nullProbability: 0.1)
  final String? avatar;

  Profile({required this.name, this.bio, this.avatar});
}
```

---

## 프로젝트 구조

```
flutter_mockalization/
├── mockalization_factory/       # 어노테이션 및 런타임 유틸리티
│   └── lib/
│       ├── mockalization_factory.dart    # 배럴 파일
│       └── src/
│           ├── annotations/             # @Mockalization, @MockProperty, @MockIgnore
│           ├── mock_format.dart          # MockFormat enum
│           └── mock_helpers.dart         # 런타임 헬퍼 함수
├── mockalization_generator/     # 코드 생성기 (dev dependency)
│   └── lib/
│       ├── builder.dart                 # build_runner 진입점
│       └── src/
│           ├── mockalization_generator.dart  # 메인 제너레이터
│           ├── field_collector.dart          # 생성자 파라미터 수집
│           ├── annotation_reader.dart       # 어노테이션 파싱
│           ├── fake_expression_factory.dart  # 타입별 분배기
│           ├── code_builder.dart            # extension 코드 조립
│           └── fake_expressions/            # 타입별 표현식 생성기
└── example/                     # 사용 예제
```
