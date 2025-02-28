import 'package:analyzer/dart/element/element.dart';
import 'package:mockalization_generator/src/fake_helper.dart';
import 'package:mockalization_generator/src/type_helpers/class_element_helper.dart';
import 'package:mockalization_generator/src/type_helpers/property_helper.dart';
import 'package:mockalization_generator/src/type_helpers/type_checker.dart';

import 'dart_helper.dart';
import 'date_time_helper.dart';
import 'enum_helper.dart';

FakeHelper typeFactory(FieldElement element) {
  // todo: 타입 분리 및 정제 필요
  if (kMockPropertyChecker.firstAnnotationOfExact(element)?.getField("value") !=
              null &&
          (kMockPropertyChecker
                  .firstAnnotationOfExact(element)
                  ?.getField("value")
                  ?.toStringValue() !=
              null) ||
      kMockPropertyChecker
              .firstAnnotationOfExact(element)
              ?.getField("value")
              ?.toListValue() !=
          null) {
    return PropertyHelper(fieldElement: element);
  }

  if (element.type.isDartCoreString ||
      element.type.isDartCoreInt ||
      element.type.isDartCoreBool ||
      element.type.isDartCoreList) {
    return DartHelper(fieldElement: element);
  }

  if (kDateTimeChecker.isExactlyType(element.type)) {
    return DateTimeHelper(fieldElement: element);
  }

  if (element.type.element is EnumElement) {
    return EnumHelper(fieldElement: element);
  }

  if (element.type.element is ClassElement) {
    return ClassElementHelper(fieldElement: element);
  }

  throw UnimplementedError();
}
