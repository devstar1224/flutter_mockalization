// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// MockalizationGenerator
// **************************************************************************

extension ProductEntityMock on ProductEntity {
  static ProductEntity fake() {
    final faker = Faker();
    return ProductEntity(
      productId: faker.randomGenerator.integer(9999, min: 0),
      productName: faker.lorem.word(),
      description: mockChance(0.3) ? null : faker.randomGenerator.string(10),
      productOption: ProductOptionEntityMock.fake(),
      options: List.generate(3, (_) => ProductOptionEntityMock.fake()),
      status: faker.randomGenerator.element(ProductStatus.values),
      createdAt: faker.date.dateTime(),
    );
  }

  static List<ProductEntity> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
