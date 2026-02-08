import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

import 'annotation_reader.dart';
import 'field_context.dart';
import 'type_checkers.dart';

/// Collects constructor parameters and builds [FieldContext] for each.
///
/// Uses the constructor parameters as the source of truth, then looks up
/// matching class fields for annotation reading.
class FieldCollector {
  /// Collects all parameters from the given [constructor] and builds
  /// [FieldContext] objects for each, excluding @MockIgnore fields.
  static List<FieldContext> fromConstructor({
    required ClassElement classElement,
    required ConstructorElement constructor,
  }) {
    final results = <FieldContext>[];

    for (final param in constructor.parameters) {
      // Find matching field in class or superclasses for annotation reading
      final field = _findField(classElement, param.name);

      // Check @MockIgnore on the field
      if (field != null && AnnotationReader.hasIgnore(field)) {
        // Only skip if the parameter has a default or is optional
        if (param.hasDefaultValue || !param.isRequired) {
          continue;
        }
        // Required parameter with @MockIgnore - we still need to generate it
      }

      // Also check @MockIgnore on the parameter itself
      if (kMockIgnoreChecker.hasAnnotationOfExact(param)) {
        if (param.hasDefaultValue || !param.isRequired) {
          continue;
        }
      }

      // Read @MockProperty annotation
      final config = field != null
          ? AnnotationReader.readMockProperty(field)
          : AnnotationReader.readMockProperty(param);

      results.add(FieldContext(
        parameterName: param.name,
        dartType: param.type,
        isNullable:
            param.type.nullabilitySuffix == NullabilitySuffix.question,
        hasDefaultValue: param.hasDefaultValue,
        isNamed: param.isNamed,
        fieldElement: field,
        parameterElement: param,
        mockPropertyConfig: config,
      ));
    }

    return results;
  }

  /// Finds a field by name in the class hierarchy.
  static FieldElement? _findField(ClassElement classElement, String name) {
    // Check current class fields
    for (final field in classElement.fields) {
      if (field.name == name && !field.isStatic) {
        return field;
      }
    }

    // Check superclass fields
    final supertype = classElement.supertype;
    if (supertype != null) {
      final superElement = supertype.element;
      if (superElement is ClassElement &&
          superElement.name != 'Object') {
        final found = _findField(superElement, name);
        if (found != null) return found;
      }
    }

    // Check mixin fields
    for (final mixin in classElement.mixins) {
      final mixinElement = mixin.element;
      if (mixinElement is ClassElement) {
        for (final field in mixinElement.fields) {
          if (field.name == name && !field.isStatic) {
            return field;
          }
        }
      }
    }

    return null;
  }

  /// Resolves the constructor to use for generation.
  static ConstructorElement resolveConstructor(
    ClassElement classElement,
    String constructorName,
  ) {
    if (constructorName.isEmpty) {
      final ctor = classElement.unnamedConstructor;
      if (ctor == null) {
        throw Exception(
          '@Mockalization: Class "${classElement.name}" has no default constructor.',
        );
      }
      return ctor;
    }

    final ctor = classElement.getNamedConstructor(constructorName);
    if (ctor == null) {
      throw Exception(
        '@Mockalization: Class "${classElement.name}" has no constructor '
        'named "$constructorName".',
      );
    }
    return ctor;
  }
}
