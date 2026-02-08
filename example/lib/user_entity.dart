import 'package:mockalization_factory/mockalization_factory.dart';

part 'user_entity.g.dart';

@Mockalization()
class UserEntity {
  final int id;

  @MockProperty(format: MockFormat.fullName)
  final String name;

  @MockProperty(format: MockFormat.email)
  final String email;

  @MockProperty(format: MockFormat.phoneNumber)
  final String? phoneNumber;

  @MockProperty(format: MockFormat.url)
  final String? website;

  final bool isActive;

  final double? rating;

  @MockProperty(format: MockFormat.streetAddress)
  final String address;

  final DateTime createdAt;

  final Duration? sessionDuration;

  final Uri? profileUrl;

  @MockProperty(length: 3)
  final Set<String> tags;

  @MockProperty(length: 3)
  final List<String> roles;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.website,
    required this.isActive,
    this.rating,
    required this.address,
    required this.createdAt,
    this.sessionDuration,
    this.profileUrl,
    required this.tags,
    required this.roles,
  });
}
