import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../field_context.dart';
import '../type_checkers.dart';

/// Generates faker expressions for collection types (List, Set, Map).
/// Supports nested generic types via recursion.
class CollectionExpression {
  static String list(DartType type, FieldContext ctx) {
    final length = ctx.mockPropertyConfig?.length ?? 3;
    final typeArg = (type as InterfaceType).typeArguments.first;
    final innerExpr = innerExpression(typeArg);
    return 'List.generate($length, (_) => $innerExpr)';
  }

  static String set_(DartType type, FieldContext ctx) {
    final length = ctx.mockPropertyConfig?.length ?? 3;
    final typeArg = (type as InterfaceType).typeArguments.first;
    final innerExpr = innerExpression(typeArg);
    return 'List.generate($length, (_) => $innerExpr).toSet()';
  }

  static String map(DartType type, FieldContext ctx) {
    final length = ctx.mockPropertyConfig?.length ?? 3;
    final args = (type as InterfaceType).typeArguments;
    final keyExpr = innerExpression(args[0]);
    final valueExpr = innerExpression(args[1]);
    return 'Map.fromEntries(List.generate($length, (_) => MapEntry($keyExpr, $valueExpr)))';
  }

  static String iterable(DartType type, FieldContext ctx) {
    final length = ctx.mockPropertyConfig?.length ?? 3;
    final typeArg = (type as InterfaceType).typeArguments.first;
    final innerExpr = innerExpression(typeArg);
    return 'List.generate($length, (_) => $innerExpr)';
  }

  /// Recursively generates an expression for a type argument.
  /// Handles nested collections like `List<List<String>>` or `Map<String, List<int>>`.
  static String innerExpression(DartType type, {int depth = 0}) {
    // Prevent infinite recursion
    if (depth > 5) return 'null';

    // Primitives
    if (type.isDartCoreString) return 'faker.lorem.word()';
    if (type.isDartCoreInt) return 'faker.randomGenerator.integer(9999)';
    if (type.isDartCoreDouble) return 'mockDouble()';
    if (type.isDartCoreBool) return 'faker.randomGenerator.boolean()';
    if (type.isDartCoreNum) return 'faker.randomGenerator.integer(9999)';

    // DateTime
    if (kDateTimeChecker.isExactlyType(type)) return 'faker.date.dateTime()';

    // BigInt
    if (kBigIntChecker.isExactlyType(type)) {
      return 'BigInt.from(faker.randomGenerator.integer(999999))';
    }

    // Duration
    if (kDurationChecker.isExactlyType(type)) {
      return 'Duration(seconds: faker.randomGenerator.integer(86400))';
    }

    // Uri
    if (kUriChecker.isExactlyType(type)) {
      return "Uri.parse('https://\${faker.internet.domainName()}')";
    }

    // Nested List
    if (type.isDartCoreList && type is InterfaceType) {
      final inner = type.typeArguments.first;
      return 'List.generate(3, (_) => ${innerExpression(inner, depth: depth + 1)})';
    }

    // Nested Set
    if (type.isDartCoreSet && type is InterfaceType) {
      final inner = type.typeArguments.first;
      return 'List.generate(3, (_) => ${innerExpression(inner, depth: depth + 1)}).toSet()';
    }

    // Nested Map
    if (type.isDartCoreMap && type is InterfaceType) {
      final args = type.typeArguments;
      return 'Map.fromEntries(List.generate(3, (_) => MapEntry(${innerExpression(args[0], depth: depth + 1)}, ${innerExpression(args[1], depth: depth + 1)})))';
    }

    // Iterable
    if (type is InterfaceType && kIterableChecker.isAssignableFromType(type)) {
      if (type.typeArguments.isNotEmpty) {
        final inner = type.typeArguments.first;
        return 'List.generate(3, (_) => ${innerExpression(inner, depth: depth + 1)})';
      }
    }

    // Enum
    if (type.element is EnumElement) {
      final enumName = (type.element as EnumElement).name;
      return 'faker.randomGenerator.element($enumName.values)';
    }

    // Custom class with @Mockalization
    if (type.element is ClassElement) {
      return '${type.element!.name}Mock.fake()';
    }

    // Dynamic or Object
    if (type is DynamicType || type.isDartCoreObject) {
      return 'faker.lorem.word()';
    }

    return 'faker.lorem.word()';
  }
}
