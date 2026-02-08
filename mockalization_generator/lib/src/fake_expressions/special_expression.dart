import '../field_context.dart';

/// Generates faker expressions for special Dart types.
class SpecialExpression {
  static String bigInt(FieldContext ctx) {
    return 'BigInt.from(faker.randomGenerator.integer(999999))';
  }

  static String duration(FieldContext ctx) {
    return 'Duration(seconds: faker.randomGenerator.integer(86400))';
  }

  static String uri(FieldContext ctx) {
    return "Uri.parse('https://\${faker.internet.domainName()}/\${faker.lorem.word()}')";
  }

  static String uint8List(FieldContext ctx) {
    final length = ctx.mockPropertyConfig?.length ?? 16;
    return 'Uint8List.fromList(List.generate($length, (_) => faker.randomGenerator.integer(255)))';
  }

  static String dynamic_(FieldContext ctx) {
    return 'faker.lorem.word()';
  }
}
