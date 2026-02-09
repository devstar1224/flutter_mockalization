import 'package:build/build.dart';
import 'package:mockalization_generator/src/mockalization_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Creates a [Builder] that generates mock data factories for classes
/// annotated with `@Mockalization`.
///
/// This builder uses [SharedPartBuilder] to produce `.g.dart` part files
/// containing extension methods (`fake()` and `fakeList()`) for each
/// annotated class.
///
/// Usage with `build_runner`:
///
/// ```bash
/// dart run build_runner build --delete-conflicting-outputs
/// ```
///
/// See also:
/// - [MockalizationGenerator], the underlying generator implementation.
Builder mocalizationGenerator(BuilderOptions options) =>
    SharedPartBuilder([MockalizationGenerator()], 'mockalization');
