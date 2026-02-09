## 2.0.2

- Lowered `analyzer` constraint from `^10.0.0` to `>=8.1.1 <11.0.0` for wider compatibility
- Lowered SDK constraint from `^3.9.0` to `^3.7.0`

## 2.0.1

- Upgraded dependencies to latest stable versions: `analyzer: >=8.1.1 <11.0.0`, `build: ^4.0.0`, `source_gen: ^4.0.0`
- Migrated from `TypeChecker.fromRuntime` to `TypeChecker.fromUrl` (source_gen 4.x breaking change)
- Migrated from `ParameterElement` to `FormalParameterElement` (analyzer 8.x+ breaking change)
- Added dartdoc comments to public API (`builder.dart`)
- Added example file for pub.dev documentation score

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
