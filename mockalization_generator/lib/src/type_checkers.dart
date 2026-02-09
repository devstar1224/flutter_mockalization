import 'package:source_gen/source_gen.dart';

/// Type checkers for mockalization annotations.
const kMockalizationChecker = TypeChecker.fromUrl(
  'package:mockalization_factory/src/annotations/mockalization.dart#Mockalization',
);
const kMockPropertyChecker = TypeChecker.fromUrl(
  'package:mockalization_factory/src/annotations/mock_property.dart#MockProperty',
);
const kMockIgnoreChecker = TypeChecker.fromUrl(
  'package:mockalization_factory/src/annotations/mock_ignore.dart#MockIgnore',
);
const kMockFormatChecker = TypeChecker.fromUrl(
  'package:mockalization_factory/src/mock_format.dart#MockFormat',
);

/// Type checkers for dart:core and dart:typed_data types.
const kDateTimeChecker = TypeChecker.fromUrl('dart:core#DateTime');
const kBigIntChecker = TypeChecker.fromUrl('dart:core#BigInt');
const kDurationChecker = TypeChecker.fromUrl('dart:core#Duration');
const kUriChecker = TypeChecker.fromUrl('dart:core#Uri');

const kListChecker = TypeChecker.fromUrl('dart:core#List');
const kSetChecker = TypeChecker.fromUrl('dart:core#Set');
const kMapChecker = TypeChecker.fromUrl('dart:core#Map');
const kIterableChecker = TypeChecker.fromUrl('dart:core#Iterable');
