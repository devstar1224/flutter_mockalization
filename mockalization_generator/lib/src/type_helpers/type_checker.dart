import 'package:mockalization_factory/mockalization_factory.dart';
import 'package:source_gen/source_gen.dart';

const kMockPropertyChecker = TypeChecker.fromRuntime(MockProperty);
const kMockIgnoreChecker = TypeChecker.fromRuntime(MockIgnore);
const kDateTimeChecker = TypeChecker.fromRuntime(DateTime);
const kCoreListChecker = TypeChecker.fromUrl('dart:core#List');
