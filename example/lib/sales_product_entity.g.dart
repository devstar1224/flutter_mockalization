// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_product_entity.dart';

// **************************************************************************
// FakerFactoryGenerator
// **************************************************************************

class SalesProductEntityMockFactory with MockFactory<SalesProductEntity> {
  @override
  SalesProductEntity generateFake() {
    return SalesProductEntity(
      saleQuantity: faker.randomGenerator.integer(9999),
      productId: faker.randomGenerator.integer(20),
      productName: faker.randomGenerator.string(10),
      productOption: ProductOptionEntityMockFactory().generateFake(),
      createdAt: faker.date.dateTime(),
    );
  }
}
