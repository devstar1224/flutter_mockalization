/// Marks a field to be excluded from mock data generation.
///
/// The corresponding constructor parameter must either have a default value
/// or be optional. Otherwise, the generated code will fail to compile.
///
/// ```dart
/// @Mockalization()
/// class Product {
///   final String name;
///   @MockIgnore()
///   final String? internalId;
///   Product({required this.name, this.internalId});
/// }
/// ```
class MockIgnore {
  const MockIgnore();
}
