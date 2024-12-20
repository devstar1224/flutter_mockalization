import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:mockalization_factory/mockalization_factory.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

class FakerFactoryGenerator extends GeneratorForAnnotation<Mockalization> {
  final _mockPropertyChecker = const TypeChecker.fromRuntime(MockProperty);
  final _mockIgnoreChecker = const TypeChecker.fromRuntime(MockIgnore);
  final _dateTimeChecker = const TypeChecker.fromRuntime(DateTime);
  final _coreListChecker = TypeChecker.fromUrl('dart:core#List');

  @override
  generateForAnnotatedElement(
      Element element, annotation, BuildStep buildStep) {
    return _generateMockFactory(element as ClassElement, annotation);
  }

  _generateMockFactory(ClassElement element, ConstantReader annotation) {
    final content = StringBuffer();

    Map<String, String> fields = {};

    List<FieldElement> allFieldElements = [];
    allFieldElements.addAll(element.fields);
    allFieldElements.addAll(_collectSuperElements(element));
    for (FieldElement field in allFieldElements) {
      int? mockPropertyAnnotationLength;
      DartType? mockPropertyAnnotationType;

      if (_mockIgnoreChecker.hasAnnotationOfExact(field)) {
        continue;
      }
      if (_mockPropertyChecker.hasAnnotationOfExact(field)) {
        mockPropertyAnnotationLength = _mockPropertyChecker
            .firstAnnotationOfExact(field)!
            .getField("length")
            ?.toIntValue();
        mockPropertyAnnotationType = _mockPropertyChecker
            .firstAnnotationOfExact(field)!
            .getField("formatType")
            ?.toTypeValue();
      }
      if (field.type.isDartCoreString) {
        if (mockPropertyAnnotationType != null &&
            _dateTimeChecker.isExactlyType(mockPropertyAnnotationType)) {
          fields[field.name] = "faker.date.dateTime().toString()";
        } else {
          fields[field.name] =
              "faker.randomGenerator.string(${mockPropertyAnnotationLength ?? 10})";
        }
      } else if (field.type.isDartCoreInt) {
        fields[field.name] =
            "faker.randomGenerator.integer(${mockPropertyAnnotationLength ?? 9999})";
      } else if (field.type.isDartCoreBool) {
        fields[field.name] = "faker.randomGenerator.boolean()";
      } else if (field.type.isDartCoreList) {
        fields[field.name] =
            "${field.type.typeArgumentsOf(_coreListChecker)!.single}MockFactory().generateFakeList(length: ${mockPropertyAnnotationLength ?? 30})";
      } else if (_dateTimeChecker.isExactlyType(field.type)) {
        fields[field.name] = "faker.date.dateTime()";
      } else if (field.type.element is EnumElement) {
        fields[field.name] =
            "faker.randomGenerator.element(${(field.type.element as EnumElement).name}.values)";
      } else {
        fields[field.name] =
            "${field.type.getDisplayString(withNullability: false)}MockFactory().generateFake()";
      }
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

  List<FieldElement> _collectSuperElements(ClassElement element) {
    if (element.supertype == null) {
      return [];
    }
    final ModelVisitor visitor = ModelVisitor();
    element.supertype!.element.visitChildren(visitor);
    if (visitor.fieldElements.length == 2) {
      return [];
    }

    List<FieldElement> fields = [];
    if (element.supertype!.element.supertype != null) {
      fields.addAll(
          _collectSuperElements(element.supertype!.element as ClassElement));
    }

    element.supertype!.element.visitChildren(visitor);
    fields.addAll(visitor.fieldElements);
    return fields;
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
