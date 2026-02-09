import '../field_context.dart';

/// Generates faker expressions for DateTime types.
class DateTimeExpression {
  static String create(FieldContext ctx) {
    return 'faker.date.dateTime()';
  }
}
