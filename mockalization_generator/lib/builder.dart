import 'package:build/build.dart';
import 'package:mockalization_generator/src/mockalization_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder mocalizationGenerator(BuilderOptions options) =>
    SharedPartBuilder([MockalizationGenerator()], 'mockalization');
