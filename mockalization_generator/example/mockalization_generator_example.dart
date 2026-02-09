/// The mockalization_generator package is a build_runner code generator.
///
/// It should be added as a `dev_dependency` alongside `build_runner`:
///
/// ```yaml
/// dependencies:
///   mockalization_factory: ^2.0.0
///
/// dev_dependencies:
///   build_runner: ^2.4.11
///   mockalization_generator: ^2.0.0
/// ```
///
/// ## Usage
///
/// 1. Annotate your class with `@Mockalization()`:
///
/// ```dart
/// import 'package:mockalization_factory/mockalization_factory.dart';
///
/// part 'user.g.dart';
///
/// @Mockalization()
/// class User {
///   @MockProperty(format: MockFormat.email)
///   final String email;
///   final int age;
///   User({required this.email, required this.age});
/// }
/// ```
///
/// 2. Run code generation:
///
/// ```bash
/// dart run build_runner build --delete-conflicting-outputs
/// ```
///
/// 3. Use the generated extension:
///
/// ```dart
/// final user = UserMock.fake();
/// final users = UserMock.fakeList(10);
/// ```
library;
