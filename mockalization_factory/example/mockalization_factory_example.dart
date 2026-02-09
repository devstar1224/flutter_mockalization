import 'package:mockalization_factory/mockalization_factory.dart';

part 'mockalization_factory_example.g.dart';

/// A simple user class annotated with @Mockalization.
///
/// Run `dart run build_runner build` to generate the mock factory extension.
@Mockalization()
class User {
  /// Full name generated via MockFormat.
  @MockProperty(format: MockFormat.fullName)
  final String name;

  /// Email generated via MockFormat.
  @MockProperty(format: MockFormat.email)
  final String email;

  /// Age with a constrained range.
  @MockProperty(min: 18, max: 65)
  final int age;

  /// Active status.
  final bool isActive;

  /// Nullable field - generates null 30% of the time by default.
  final String? bio;

  /// List with a specified length.
  @MockProperty(length: 3)
  final List<String> roles;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.isActive,
    this.bio,
    required this.roles,
  });
}

void main() {
  // After running build_runner, use the generated extension:
  //
  // final user = UserMock.fake();
  // final users = UserMock.fakeList(10);
  //
  // print(user.name);   // e.g. "Dr. John Smith"
  // print(user.email);  // e.g. "john.smith@example.com"
  // print(user.age);    // e.g. 34
  // print(user.roles);  // e.g. ["lorem", "ipsum", "dolor"]
}
