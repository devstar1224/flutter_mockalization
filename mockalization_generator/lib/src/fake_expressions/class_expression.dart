import 'package:analyzer/dart/element/type.dart';

import '../field_context.dart';

/// Generates faker expressions for custom @Mockalization-annotated classes.
class ClassExpression {
  static String create(DartType type, FieldContext ctx) {
    final className = type.element!.name!;
    return '${className}Mock.fake()';
  }
}
