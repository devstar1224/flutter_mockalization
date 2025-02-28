import 'package:analyzer/dart/element/element.dart';
import 'package:mockalization_generator/src/fake_helper.dart';

class DateTimeHelper extends FakeHelper {
  DateTimeHelper({required FieldElement fieldElement})
      : super(fieldElement: fieldElement);

  @override
  String toFake() {
    return "faker.date.dateTime()";
  }
}
