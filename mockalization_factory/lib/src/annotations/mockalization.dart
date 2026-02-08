/// Marks a class for mock data generation.
///
/// When applied to a class, the code generator will create an extension
/// with static `fake()` and `fakeList()` methods.
///
/// ```dart
/// @Mockalization()
/// class User {
///   final String name;
///   final String email;
///   User({required this.name, required this.email});
/// }
///
/// // Generated: UserMock.fake(), UserMock.fakeList(5)
/// ```
class Mockalization {
  /// Specify a named constructor to use for mock data generation.
  /// If null, the unnamed (default) constructor is used.
  final String? constructor;

  const Mockalization({this.constructor});
}
