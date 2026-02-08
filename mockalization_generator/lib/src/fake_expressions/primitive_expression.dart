import '../field_context.dart';

/// Generates faker expressions for primitive Dart types.
class PrimitiveExpression {
  static String string(FieldContext ctx) {
    final config = ctx.mockPropertyConfig;
    final length = config?.length ?? 10;
    return 'faker.randomGenerator.string($length)';
  }

  static String integer(FieldContext ctx) {
    final config = ctx.mockPropertyConfig;
    final max = config?.max?.toInt() ?? 9999;
    final min = config?.min?.toInt() ?? 0;
    return 'faker.randomGenerator.integer($max, min: $min)';
  }

  static String double_(FieldContext ctx) {
    final config = ctx.mockPropertyConfig;
    final min = config?.min?.toDouble() ?? 0.0;
    final max = config?.max?.toDouble() ?? 9999.0;
    return 'mockDouble(min: $min, max: $max)';
  }

  static String boolean_(FieldContext ctx) {
    return 'faker.randomGenerator.boolean()';
  }

  static String num_(FieldContext ctx) {
    final config = ctx.mockPropertyConfig;
    final max = config?.max?.toInt() ?? 9999;
    final min = config?.min?.toInt() ?? 0;
    // Generate an int for simplicity (num is a supertype of int)
    return 'faker.randomGenerator.integer($max, min: $min)';
  }
}
