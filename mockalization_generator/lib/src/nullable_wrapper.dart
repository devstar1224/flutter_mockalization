/// Utility for wrapping expressions with nullable randomization.
class NullableWrapper {
  /// Wraps [expression] so that it randomly returns null
  /// with the given [nullProbability] (default 0.3 = 30% chance of null).
  static String wrap(String expression, double? nullProbability) {
    final prob = nullProbability ?? 0.3;
    return 'mockChance($prob) ? null : $expression';
  }
}
