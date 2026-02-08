// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_product_entity.dart';

// **************************************************************************
// MockalizationGenerator
// **************************************************************************

extension SalesProductEntityMock on SalesProductEntity {
  static SalesProductEntity fake() {
    final faker = Faker();
    return SalesProductEntity(
      saleQuantity: faker.randomGenerator.integer(1000, min: 0),
      discountRate: mockChance(0.3) ? null : mockDouble(min: 0.0, max: 0.5),
      productId: faker.randomGenerator.integer(9999, min: 0),
      productName: faker.lorem.word(),
      description: mockChance(0.3) ? null : faker.randomGenerator.string(10),
      productOption: ProductOptionEntityMock.fake(),
      options: List.generate(3, (_) => ProductOptionEntityMock.fake()),
      status: faker.randomGenerator.element(ProductStatus.values),
      createdAt: faker.date.dateTime(),
    );
  }

  static List<SalesProductEntity> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
