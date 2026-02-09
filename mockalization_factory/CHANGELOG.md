## 2.0.0

- **BREAKING**: Replaced `MockFactory` mixin with extension-based API (`UserMock.fake()`, `UserMock.fakeList()`)
- **BREAKING**: Replaced `MockFormatType` with `MockFormat` enum (33 formats)
- **BREAKING**: Replaced `MockProperty.formatType` with `MockProperty.format`
- Added nullable type support with configurable `nullProbability`
- Added `MockProperty.values` for random selection from a list
- Added `MockProperty.minLength` and `MockProperty.maxLength`
- Added `MockFormat` enum with 33 formats: email, fullName, phoneNumber, url, uuid, and more
- Added `mockChance()` and `mockDouble()` runtime helpers
- Re-exported `Faker` class for convenience
- Removed Flutter SDK dependency (now a pure Dart package)

## 1.0.0

- Initial release
- `@Mockalization()` class annotation
- `@MockProperty()` field annotation with `length`, `max`, `min`, `value`, `formatType`
- `@MockIgnore()` field annotation
- `MockFactory<T>` mixin with `generateFake()` and `generateFakeList()`
