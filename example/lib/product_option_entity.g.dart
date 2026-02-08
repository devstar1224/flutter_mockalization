// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_entity.dart';

// **************************************************************************
// MockalizationGenerator
// **************************************************************************

extension ProductOptionEntityMock on ProductOptionEntity {
  static ProductOptionEntity fake() {
    final faker = Faker();
    return ProductOptionEntity(
      optionId: faker.randomGenerator.integer(9999, min: 0),
      optionName: faker.lorem.word(),
      createdAt: faker.date.dateTime(),
      price: mockDouble(min: 100.0, max: 50000.0),
    );
  }

  static List<ProductOptionEntity> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
