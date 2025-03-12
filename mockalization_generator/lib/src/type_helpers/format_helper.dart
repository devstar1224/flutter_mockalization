import 'package:mockalization_generator/src/fake_helper.dart';

class DateTimeHelper extends FakeHelper {
  DateTimeHelper({required super.fieldElement});

  @override
  String toFake() {
    return "faker.date.dateTime()";
  }
}
