import '../mock_format.dart';

/// Configures mock data generation for a specific field.
///
/// ```dart
/// @Mockalization()
/// class User {
///   @MockProperty(format: MockFormat.email)
///   final String email;
///
///   @MockProperty(min: 18, max: 65)
///   final int age;
///
///   @MockProperty(length: 5)
///   final List<String> tags;
///
///   @MockProperty(value: 'admin')
///   final String role;
///
///   @MockProperty(values: ['active', 'inactive', 'pending'])
///   final String status;
/// }
/// ```
class MockProperty {
  /// Fixed value to always use for this field.
  /// Must match the field's type.
  final Object? value;

  /// List of values to randomly pick from.
  /// Each element must match the field's type.
  final List<Object>? values;

  /// Format to use for generating realistic fake data.
  /// Primarily for String fields (e.g., MockFormat.email).
  final MockFormat? format;

  /// Minimum value for numeric types (int, double, num).
  final num? min;

  /// Maximum value for numeric types (int, double, num).
  final num? max;

  /// Exact length for String (character count) or collection (element count).
  /// If set, overrides minLength and maxLength.
  final int? length;

  /// Minimum length for collections or strings.
  final int? minLength;

  /// Maximum length for collections or strings.
  final int? maxLength;

  /// Probability of generating null for nullable fields (0.0 to 1.0).
  /// Defaults to 0.3 (30% chance of null) if not specified.
  final double? nullProbability;

  const MockProperty({
    this.value,
    this.values,
    this.format,
    this.min,
    this.max,
    this.length,
    this.minLength,
    this.maxLength,
    this.nullProbability,
  });
}
