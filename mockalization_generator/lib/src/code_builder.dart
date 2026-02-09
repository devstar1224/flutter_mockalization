/// Assembles the final generated extension code string.
class CodeBuilder {
  /// Builds the complete extension with fake() and fakeList() methods.
  static String buildExtension({
    required String className,
    required String constructorName,
    required Map<String, String> fieldExpressions,
    required bool needsUuidImport,
    required bool needsTypedDataImport,
  }) {
    final buffer = StringBuffer();

    // Extension declaration
    buffer.writeln('extension ${className}Mock on $className {');

    // Static fake() method
    buffer.writeln('  static $className fake() {');
    buffer.writeln('    final faker = Faker();');

    // Constructor call
    final ctorCall =
        constructorName.isEmpty ? className : '$className.$constructorName';

    buffer.writeln('    return $ctorCall(');

    for (final entry in fieldExpressions.entries) {
      buffer.writeln('      ${entry.key}: ${entry.value},');
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();

    // Static fakeList() method
    buffer.writeln('  static List<$className> fakeList(int length) {');
    buffer.writeln('    return List.generate(length, (_) => fake());');
    buffer.writeln('  }');

    buffer.writeln('}');

    return buffer.toString();
  }
}
