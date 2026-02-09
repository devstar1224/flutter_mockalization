import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mockalization_factory/mockalization_factory.dart';
import 'package:source_gen/source_gen.dart';

import 'code_builder.dart';
import 'fake_expression_factory.dart';
import 'field_collector.dart';

/// Main code generator for @Mockalization annotation.
///
/// Generates an extension on the annotated class with static
/// `fake()` and `fakeList()` methods.
class MockalizationGenerator extends GeneratorForAnnotation<Mockalization> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@Mockalization can only be applied to classes.',
        element: element,
      );
    }

    final classElement = element;
    final constructorName =
        annotation.peek('constructor')?.stringValue ?? '';

    // 1. Resolve constructor
    final constructor = FieldCollector.resolveConstructor(
      classElement,
      constructorName,
    );

    // 2. Collect constructor parameters
    final fieldContexts = FieldCollector.fromConstructor(
      classElement: classElement,
      constructor: constructor,
    );

    // 3. Generate fake expressions for each field
    final fieldExpressions = <String, String>{};
    var needsUuidImport = false;
    var needsTypedDataImport = false;

    for (final ctx in fieldContexts) {
      final expr = FakeExpressionFactory.create(ctx);
      fieldExpressions[ctx.parameterName] = expr;

      // Check if generated code uses Uuid or Uint8List
      if (expr.contains('Uuid()')) needsUuidImport = true;
      if (expr.contains('Uint8List')) needsTypedDataImport = true;
    }

    // 4. Build the extension code
    return CodeBuilder.buildExtension(
      className: classElement.name!,
      constructorName: constructorName,
      fieldExpressions: fieldExpressions,
      needsUuidImport: needsUuidImport,
      needsTypedDataImport: needsTypedDataImport,
    );
  }
}
