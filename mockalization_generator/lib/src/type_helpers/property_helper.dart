import 'package:analyzer/dart/constant/value.dart';
import 'package:mockalization_generator/src/fake_helper.dart';

class PropertyHelper extends FakeHelper {
  PropertyHelper({required FieldElement fieldElement})
      : super(fieldElement: fieldElement);

  @override
  String toFake() {
    if (mockPropertyAnnotationValue?.toStringValue() != null) {
      return "\"${mockPropertyAnnotationValue!.toStringValue()!}\"";
    } else if (mockPropertyAnnotationValue!.toListValue() != null) {
      List<String?> valueList = [];
      for (DartObject value in mockPropertyAnnotationValue!.toListValue()!) {
        if (value.toStringValue() != null) {
          valueList.add("\"${value.toStringValue()}\"");
        } else if (value.toIntValue() != null) {
          valueList.add("${value.toIntValue()}");
        } else if (value.toBoolValue() != null) {
          valueList.add("${value.toBoolValue()}");
        }
      }
      return "faker.randomGenerator.element(${valueList.toString()})";
    }

    throw UnimplementedError();
  }
}
