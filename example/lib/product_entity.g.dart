// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// FakerFactoryGenerator
// **************************************************************************

class ProductEntityMockFactory with MockFactory<ProductEntity> {
  @override
  ProductEntity generateFake() {
    return ProductEntity(
      productId: faker.randomGenerator.integer(20),
      productName: faker.randomGenerator.string(10),
      productOption: ProductOptionEntityMockFactory().generateFake(),
      createdAt: faker.date.dateTime(),
    );
  }
}
