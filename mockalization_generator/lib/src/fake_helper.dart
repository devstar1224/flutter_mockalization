import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mockalization_generator/src/type_helpers/type_checker.dart';

abstract class FakeHelper {
  FakeHelper({required this.fieldElement}) {
    if (kMockPropertyChecker.hasAnnotationOfExact(fieldElement)) {
      mockPropertyAnnotationLength = kMockPropertyChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField("length")
          ?.toIntValue();
      mockPropertyAnnotationMax = kMockPropertyChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField("max")
          ?.toIntValue();
      mockPropertyAnnotationMin = kMockPropertyChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField("min")
          ?.toIntValue();
      mockPropertyAnnotationType = kMockPropertyChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField("formatType")
          ?.toTypeValue();
      mockPropertyAnnotationValue = kMockPropertyChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField("value");
    }
  }

  int? mockPropertyAnnotationLength;

  int? mockPropertyAnnotationMax;

  int? mockPropertyAnnotationMin;

  DartType? mockPropertyAnnotationType;

  DartObject? mockPropertyAnnotationValue;

  FieldElement fieldElement;

  String toFake();
}
