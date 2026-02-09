## 2.0.0

- **BREAKING**: Complete rewrite of code generation engine
- **BREAKING**: Generated code now uses extension pattern instead of mixin class
- Added support for `double`, `num`, `Duration`, `Uri`, `BigInt`, `Uint8List`, `dynamic`
- Added support for `Set<T>` and `Map<K,V>` collections
- Added support for nested generic types (e.g., `Map<String, List<int>>`)
- Added nullable type handling with randomized null generation
- Added `MockFormat` enum-based format resolution (33 formats)
- Added `MockProperty.values` support for random value selection
- Modularized architecture with separated expression generators
- Constructor parameter-based field collection (replaces field-based approach)
- Removed Flutter SDK dependency
- Removed json_serializable related code

## 1.0.0

- Initial release
- `FakerFactoryGenerator` with `GeneratorForAnnotation<Mockalization>`
- Support for `String`, `int`, `bool`, `DateTime`, `List<int>`, `Enum`, custom classes
- Inheritance support via `createSortedFieldSet()`
