import 'package:mockalization_generator/src/fake_helper.dart';
import 'package:mockalization_generator/src/type_helpers/type_checker.dart';
import 'package:source_helper/source_helper.dart';

class DartHelper extends FakeHelper {
  DartHelper({required super.fieldElement});

  @override
  String toFake() {
    if (fieldElement.type.isDartCoreString) {
      if (mockPropertyAnnotationValue != null &&
          mockPropertyAnnotationValue?.toStringValue() != null) {
        return "\"${mockPropertyAnnotationValue!.toStringValue()!}\"";
      } else if (mockPropertyAnnotationType?.variable != null &&
          kMockFormatTypeChecker
              .isExactlyType(mockPropertyAnnotationType!.type!)) {
        switch (mockPropertyAnnotationType!.variable!.name) {
          case "date":
            return "faker.date.dateTime().toString()";
          case "address":
            return "faker.address.streetAddress()";
          case "streetName":
            return "faker.address.streetName()";
          case "companyName":
            return "faker.company.name()";
          case "personName":
            return "faker.person.name()";
          case "vehicleModel":
            return "faker.vehicle.model()";
          case "barcode":
            return "\"\${faker.randomGenerator.fromCharSet(\"ABCDEFGHIJKLNMOPQRSTUVWXYZ\", 1)}\${faker.randomGenerator.integer(min: 10000000, 99999999)}\"";
          case "slipNumber":
            return "faker.randomGenerator.fromCharSet(\"ABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890\", 8)";
          case "color":
            return "faker.color.color()";

          default:
            throw UnimplementedError("Unknown format type");
        }
      } else {
        return "faker.randomGenerator.string(${mockPropertyAnnotationLength ?? 10})";
      }
    } else if (fieldElement.type.isDartCoreInt) {
      return "faker.randomGenerator.integer(${mockPropertyAnnotationMax ?? 9999}, min: ${mockPropertyAnnotationMin ?? 0})";
    } else if (fieldElement.type.isDartCoreBool) {
      return "faker.randomGenerator.boolean()";
    } else if (fieldElement.type.isDartCoreList) {
      if (fieldElement.type
          .typeArgumentsOf(kCoreListChecker)!
          .single
          .isDartCoreInt) {
        return "faker.randomGenerator.numbers(${mockPropertyAnnotationMax ?? 9999}, ${mockPropertyAnnotationLength ?? 9999})";
      } else {
        return "${fieldElement.type.typeArgumentsOf(kCoreListChecker)!.single}MockFactory().generateFakeList(length: ${mockPropertyAnnotationLength ?? 30})";
      }
    }
    throw UnimplementedError();
  }
}
