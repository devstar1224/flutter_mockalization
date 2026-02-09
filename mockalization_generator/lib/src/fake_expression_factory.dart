import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import 'fake_expressions/class_expression.dart';
import 'fake_expressions/collection_expression.dart';
import 'fake_expressions/datetime_expression.dart';
import 'fake_expressions/enum_expression.dart';
import 'fake_expressions/format_expression.dart';
import 'fake_expressions/primitive_expression.dart';
import 'fake_expressions/special_expression.dart';
import 'field_context.dart';
import 'nullable_wrapper.dart';
import 'type_checkers.dart';

/// Central dispatcher that creates faker expressions for each field type.
class FakeExpressionFactory {
  /// Creates a Dart expression string that generates a fake value for [ctx].
  static String create(FieldContext ctx) {
    // 1. If MockProperty has a fixed value, return it directly
    if (ctx.mockPropertyConfig?.fixedValue != null) {
      final expr = _fixedValueExpression(ctx.mockPropertyConfig!.fixedValue!);
      return _maybeWrapNullable(expr, ctx);
    }

    // 2. If MockProperty has value choices, return random pick
    if (ctx.mockPropertyConfig?.valueChoices != null) {
      final expr =
          _valueChoicesExpression(ctx.mockPropertyConfig!.valueChoices!);
      return _maybeWrapNullable(expr, ctx);
    }

    // 3. If MockProperty has a format, use format expression
    if (ctx.mockPropertyConfig?.formatName != null) {
      final expr = FormatExpression.create(ctx);
      return _maybeWrapNullable(expr, ctx);
    }

    // 4. Route by type
    final expr = _createForType(ctx.dartType, ctx);

    // 5. Wrap with nullable logic if needed
    return _maybeWrapNullable(expr, ctx);
  }

  static String _maybeWrapNullable(String expr, FieldContext ctx) {
    if (ctx.isNullable) {
      return NullableWrapper.wrap(expr, ctx.mockPropertyConfig?.nullProbability);
    }
    return expr;
  }

  static String _createForType(DartType type, FieldContext ctx) {
    // Unwrap nullable type for matching
    final nonNullType = type is InterfaceType ? type : type;

    // Primitives
    if (nonNullType.isDartCoreString) return PrimitiveExpression.string(ctx);
    if (nonNullType.isDartCoreInt) return PrimitiveExpression.integer(ctx);
    if (nonNullType.isDartCoreDouble) return PrimitiveExpression.double_(ctx);
    if (nonNullType.isDartCoreBool) return PrimitiveExpression.boolean_(ctx);
    if (nonNullType.isDartCoreNum) return PrimitiveExpression.num_(ctx);

    // DateTime
    if (kDateTimeChecker.isAssignableFromType(nonNullType)) {
      return DateTimeExpression.create(ctx);
    }

    // Collections
    if (nonNullType.isDartCoreList) {
      return CollectionExpression.list(nonNullType, ctx);
    }
    if (nonNullType.isDartCoreSet) {
      return CollectionExpression.set_(nonNullType, ctx);
    }
    if (nonNullType.isDartCoreMap) {
      return CollectionExpression.map(nonNullType, ctx);
    }
    if (nonNullType is InterfaceType &&
        kIterableChecker.isAssignableFromType(nonNullType) &&
        !nonNullType.isDartCoreList &&
        !nonNullType.isDartCoreSet) {
      return CollectionExpression.iterable(nonNullType, ctx);
    }

    // Enum
    if (nonNullType.element is EnumElement) {
      return EnumExpression.create(nonNullType, ctx);
    }

    // Special types
    if (kBigIntChecker.isAssignableFromType(nonNullType)) {
      return SpecialExpression.bigInt(ctx);
    }
    if (kDurationChecker.isAssignableFromType(nonNullType)) {
      return SpecialExpression.duration(ctx);
    }
    if (kUriChecker.isAssignableFromType(nonNullType)) {
      return SpecialExpression.uri(ctx);
    }
    // Uint8List check - it's a List<int> subtype from dart:typed_data
    if (nonNullType is InterfaceType &&
        nonNullType.element.name == 'Uint8List') {
      return SpecialExpression.uint8List(ctx);
    }

    // Custom @Mockalization class
    if (nonNullType.element is ClassElement) {
      return ClassExpression.create(nonNullType, ctx);
    }

    // Dynamic
    if (nonNullType is DynamicType) {
      return SpecialExpression.dynamic_(ctx);
    }

    throw InvalidGenerationSourceError(
      'Unsupported type: ${type.getDisplayString()} '
      'for field "${ctx.parameterName}".',
      element: ctx.parameterElement,
    );
  }

  /// Creates an expression for a fixed value from @MockProperty(value: ...).
  static String _fixedValueExpression(DartObject value) {
    if (value.toStringValue() != null) {
      return "'${value.toStringValue()}'";
    }
    if (value.toIntValue() != null) {
      return '${value.toIntValue()}';
    }
    if (value.toDoubleValue() != null) {
      return '${value.toDoubleValue()}';
    }
    if (value.toBoolValue() != null) {
      return '${value.toBoolValue()}';
    }
    if (value.toListValue() != null) {
      final items = value.toListValue()!.map(_fixedValueExpression).join(', ');
      return '[$items]';
    }
    throw UnsupportedError(
      'Unsupported fixed value type: ${value.type}',
    );
  }

  /// Creates an expression for random selection from @MockProperty(values: [...]).
  static String _valueChoicesExpression(List<DartObject> values) {
    final items = values.map(_fixedValueExpression).join(', ');
    return 'faker.randomGenerator.element([$items])';
  }
}
