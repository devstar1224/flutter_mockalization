import 'package:analyzer/dart/element/element.dart';
import 'package:mockalization_generator/src/fake_helper.dart';

class ClassElementHelper extends FakeHelper {
  ClassElementHelper({required FieldElement fieldElement})
      : super(fieldElement: fieldElement);

  @override
  String toFake() {
    return "${fieldElement.type.getDisplayString(withNullability: false)}MockFactory().generateFake()";
  }
}
