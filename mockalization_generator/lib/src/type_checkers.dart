import 'package:mockalization_factory/mockalization_factory.dart';
import 'package:source_gen/source_gen.dart';

const kMockalizationChecker = TypeChecker.fromRuntime(Mockalization);
const kMockPropertyChecker = TypeChecker.fromRuntime(MockProperty);
const kMockIgnoreChecker = TypeChecker.fromRuntime(MockIgnore);
const kMockFormatChecker = TypeChecker.fromRuntime(MockFormat);

const kDateTimeChecker = TypeChecker.fromRuntime(DateTime);
const kBigIntChecker = TypeChecker.fromRuntime(BigInt);
const kDurationChecker = TypeChecker.fromRuntime(Duration);
const kUriChecker = TypeChecker.fromRuntime(Uri);

const kListChecker = TypeChecker.fromUrl('dart:core#List');
const kSetChecker = TypeChecker.fromUrl('dart:core#Set');
const kMapChecker = TypeChecker.fromUrl('dart:core#Map');
const kIterableChecker = TypeChecker.fromUrl('dart:core#Iterable');
