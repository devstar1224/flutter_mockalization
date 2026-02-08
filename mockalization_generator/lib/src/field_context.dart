import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'annotation_reader.dart';

/// Holds all information needed to generate a fake value for one constructor parameter.
class FieldContext {
  /// The name used in the constructor parameter.
  final String parameterName;

  /// The Dart type of the parameter.
  final DartType dartType;

  /// Whether the type is nullable (e.g., String?).
  final bool isNullable;

  /// Whether the constructor parameter is optional (has default value or is not required).
  final bool hasDefaultValue;

  /// Whether the parameter is a named parameter.
  final bool isNamed;

  /// The FieldElement for reading annotations (may be null for computed params).
  final FieldElement? fieldElement;

  /// The ParameterElement from the constructor.
  final ParameterElement parameterElement;

  /// Parsed MockProperty annotation config, if present.
  final MockPropertyConfig? mockPropertyConfig;

  const FieldContext({
    required this.parameterName,
    required this.dartType,
    required this.isNullable,
    required this.hasDefaultValue,
    required this.isNamed,
    required this.fieldElement,
    required this.parameterElement,
    required this.mockPropertyConfig,
  });
}
