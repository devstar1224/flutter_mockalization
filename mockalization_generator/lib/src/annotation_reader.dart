import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

import 'type_checkers.dart';

/// Parsed representation of a @MockProperty annotation.
class MockPropertyConfig {
  final DartObject? fixedValue;
  final List<DartObject>? valueChoices;
  final String? formatName;
  final num? min;
  final num? max;
  final int? length;
  final int? minLength;
  final int? maxLength;
  final double? nullProbability;

  const MockPropertyConfig({
    this.fixedValue,
    this.valueChoices,
    this.formatName,
    this.min,
    this.max,
    this.length,
    this.minLength,
    this.maxLength,
    this.nullProbability,
  });
}

/// Reads @MockProperty and @MockIgnore annotations from field/parameter elements.
class AnnotationReader {
  /// Returns true if the element has @MockIgnore annotation.
  static bool hasIgnore(Element element) {
    if (kMockIgnoreChecker.hasAnnotationOfExact(element)) return true;
    if (element is FieldElement && element.getter != null) {
      return kMockIgnoreChecker.hasAnnotationOfExact(element.getter!);
    }
    return false;
  }

  /// Reads and parses @MockProperty annotation from the element.
  /// Returns null if no annotation is present.
  static MockPropertyConfig? readMockProperty(Element element) {
    final annotation = kMockPropertyChecker.firstAnnotationOfExact(element) ??
        (element is FieldElement && element.getter != null
            ? kMockPropertyChecker.firstAnnotationOfExact(element.getter!)
            : null);

    if (annotation == null) return null;

    final valueField = annotation.getField('value');
    final valuesField = annotation.getField('values');
    final formatField = annotation.getField('format');
    final minField = annotation.getField('min');
    final maxField = annotation.getField('max');
    final lengthField = annotation.getField('length');
    final minLengthField = annotation.getField('minLength');
    final maxLengthField = annotation.getField('maxLength');
    final nullProbabilityField = annotation.getField('nullProbability');

    // Parse format enum value name
    String? formatName;
    if (formatField != null && !formatField.isNull) {
      final index = formatField.getField('index')?.toIntValue();
      if (index != null) {
        formatName = _mockFormatValues[index];
      }
    }

    // Parse values list
    List<DartObject>? valueChoices;
    if (valuesField != null && !valuesField.isNull) {
      valueChoices = valuesField.toListValue();
    }

    // Parse fixed value
    DartObject? fixedValue;
    if (valueField != null && !valueField.isNull) {
      fixedValue = valueField;
    }

    return MockPropertyConfig(
      fixedValue: fixedValue,
      valueChoices: valueChoices,
      formatName: formatName,
      min: minField?.toIntValue()?.toDouble() ?? minField?.toDoubleValue(),
      max: maxField?.toIntValue()?.toDouble() ?? maxField?.toDoubleValue(),
      length: lengthField?.toIntValue(),
      minLength: minLengthField?.toIntValue(),
      maxLength: maxLengthField?.toIntValue(),
      nullProbability: nullProbabilityField?.toDoubleValue(),
    );
  }
}

/// MockFormat enum values in order, matching the Dart enum definition.
const _mockFormatValues = [
  'firstName',
  'lastName',
  'fullName',
  'email',
  'url',
  'ipv4',
  'ipv6',
  'userName',
  'password',
  'userAgent',
  'domainName',
  'streetAddress',
  'city',
  'country',
  'zipCode',
  'latitude',
  'longitude',
  'phoneNumber',
  'companyName',
  'companySuffix',
  'word',
  'sentence',
  'paragraph',
  'dateTime',
  'past',
  'future',
  'hexColor',
  'colorName',
  'creditCard',
  'currencyCode',
  'currencyName',
  'uuid',
  'barcode',
];
