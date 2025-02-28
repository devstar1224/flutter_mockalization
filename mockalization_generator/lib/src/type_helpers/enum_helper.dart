import 'package:analyzer/dart/element/element.dart';
import 'package:mockalization_generator/src/fake_helper.dart';

class EnumHelper extends FakeHelper {
  EnumHelper({required FieldElement fieldElement})
      : super(fieldElement: fieldElement);

  @override
  String toFake() {
    return "faker.randomGenerator.element(${(fieldElement.type.element as EnumElement).name}.values)";
  }
}
