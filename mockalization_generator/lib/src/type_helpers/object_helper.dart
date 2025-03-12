import 'package:mockalization_generator/src/fake_helper.dart';

class ObjectHelper extends FakeHelper {
  ObjectHelper({required super.fieldElement});

  @override
  String toFake() {
    return "${fieldElement.type.getDisplayString(withNullability: false)}MockFactory().generateFake()";
  }
}
