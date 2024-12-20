// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_entity.dart';

// **************************************************************************
// FakerFactoryGenerator
// **************************************************************************

class ProductOptionEntityMockFactory with MockFactory<ProductOptionEntity> {
  @override
  ProductOptionEntity generateFake() {
    return ProductOptionEntity(
      optionId: faker.randomGenerator.integer(9999),
      optionName: faker.randomGenerator.string(10),
      createdAt: faker.date.dateTime(),
    );
  }
}
