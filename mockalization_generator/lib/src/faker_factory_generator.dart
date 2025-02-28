import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:mockalization_factory/mockalization_factory.dart';
import 'package:mockalization_generator/src/type_helpers/field_helpers.dart';
import 'package:mockalization_generator/src/type_helpers/type_factory.dart';
import 'package:source_gen/source_gen.dart';

class FakerFactoryGenerator extends GeneratorForAnnotation<Mockalization> {
  final _mockPropertyChecker = const TypeChecker.fromRuntime(MockProperty);
  final _mockIgnoreChecker = const TypeChecker.fromRuntime(MockIgnore);
  final _dateTimeChecker = const TypeChecker.fromRuntime(DateTime);
  final _coreListChecker = const TypeChecker.fromUrl('dart:core#List');

  @override
  generateForAnnotatedElement(
      Element element, annotation, BuildStep buildStep) {
    return _generateMockFactory(element as ClassElement, annotation);
  }

  _generateMockFactory(ClassElement element, ConstantReader annotation) {
    final content = StringBuffer();

    Map<String, String> fields = {};
    for (FieldElement field in createSortedFieldSet(element)) {
      if (_mockIgnoreChecker.hasAnnotationOfExact(field) ||
          (field.getter != null &&
              _mockIgnoreChecker.hasAnnotationOfExact(field.getter!))) {
        continue;
      }

      fields[field.name] = typeFactory(field).toFake();
    }

    String field = "";

    fields.forEach((k, v) {
      field += "$k: $v,";
    });

    content.writeln('''
    class ${element.name}MockFactory with MockFactory<${element.name}> { 
      @override
      ${element.name} generateFake() {
        return ${element.name}(
          $field
        );
      }
    }
    ''');

    return content.toString();
  }
}

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, dynamic> fields = {};
  List<FieldElement> fieldElements = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    final String returnType = element.returnType.toString();
    className = returnType.replaceAll("*", ""); // ClassName* -> ClassName
  }

  @override
  void visitFieldElement(FieldElement element) {
    String elementType = element.type.toString().replaceAll("*", "");
    fieldElements.add(element);
    fields[element.name] = elementType;
  }
}
