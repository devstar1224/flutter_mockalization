import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../field_context.dart';

/// Generates faker expressions for Enum types.
class EnumExpression {
  static String create(DartType type, FieldContext ctx) {
    final enumName = (type.element as EnumElement).name;
    return 'faker.randomGenerator.element($enumName.values)';
  }
}
