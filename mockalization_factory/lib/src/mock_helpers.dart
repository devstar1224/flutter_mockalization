import 'dart:math';

final _random = Random();

/// Returns true with the given [probability] (0.0 to 1.0).
/// Used by generated code to decide whether to produce null for nullable fields.
bool mockChance(double probability) => _random.nextDouble() < probability;

/// Returns a random double between [min] and [max].
/// Used by generated code for double/num field generation.
double mockDouble({double min = 0.0, double max = 9999.0}) =>
    min + _random.nextDouble() * (max - min);
