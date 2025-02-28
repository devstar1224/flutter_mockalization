import 'package:analyzer/dart/element/element.dart';
import 'package:mockalization_generator/src/fake_helper.dart';
import 'package:mockalization_generator/src/type_helpers/type_checker.dart';
import 'package:source_helper/source_helper.dart';

class DartHelper extends FakeHelper {
  DartHelper({required FieldElement fieldElement})
      : super(fieldElement: fieldElement);

  @override
  String toFake() {
    if (fieldElement.type.isDartCoreString) {
      if (mockPropertyAnnotationValue != null &&
          mockPropertyAnnotationValue?.toStringValue() != null) {
        return "\"${mockPropertyAnnotationValue!.toStringValue()!}\"";
      } else if (mockPropertyAnnotationType != null &&
          kDateTimeChecker.isExactlyType(mockPropertyAnnotationType!)) {
        return "faker.date.dateTime().toString()";
      } else {
        return "faker.randomGenerator.string(${mockPropertyAnnotationLength ?? 10})";
      }
    } else if (fieldElement.type.isDartCoreInt) {
      return "faker.randomGenerator.integer(${mockPropertyAnnotationMax ?? 9999}, min: ${mockPropertyAnnotationMin ?? 0})";
    } else if (fieldElement.type.isDartCoreBool) {
      return "faker.randomGenerator.boolean()";
    } else if (fieldElement.type.isDartCoreList) {
      if (fieldElement.type
          .typeArgumentsOf(kCoreListChecker)!
          .single
          .isDartCoreInt) {
        return "faker.randomGenerator.numbers(${mockPropertyAnnotationMax ?? 9999}, ${mockPropertyAnnotationLength ?? 9999})";
      } else {
        return "${fieldElement.type.typeArgumentsOf(kCoreListChecker)!.single}MockFactory().generateFakeList(length: ${mockPropertyAnnotationLength ?? 30})";
      }
    }
    throw UnimplementedError();
  }
}
