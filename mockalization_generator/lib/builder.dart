import 'package:build/build.dart';
import 'package:mockalization_generator/src/faker_factory_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder fakeGenerator(BuilderOptions options) =>
    SharedPartBuilder([FakerFactoryGenerator()], 'fake_generator');
