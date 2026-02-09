// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// MockalizationGenerator
// **************************************************************************

extension UserEntityMock on UserEntity {
  static UserEntity fake() {
    final faker = Faker();
    return UserEntity(
      id: faker.randomGenerator.integer(9999, min: 0),
      name: faker.person.name(),
      email: faker.internet.email(),
      phoneNumber: mockChance(0.3) ? null : faker.phoneNumber.us(),
      website: mockChance(0.3) ? null : faker.internet.httpsUrl(),
      isActive: faker.randomGenerator.boolean(),
      rating: mockChance(0.3) ? null : mockDouble(min: 0.0, max: 9999.0),
      address: faker.address.streetAddress(),
      createdAt: faker.date.dateTime(),
      sessionDuration: mockChance(0.3)
          ? null
          : Duration(seconds: faker.randomGenerator.integer(86400)),
      profileUrl: mockChance(0.3)
          ? null
          : Uri.parse(
              'https://${faker.internet.domainName()}/${faker.lorem.word()}'),
      tags: List.generate(3, (_) => faker.lorem.word()).toSet(),
      roles: List.generate(3, (_) => faker.lorem.word()),
    );
  }

  static List<UserEntity> fakeList(int length) {
    return List.generate(length, (_) => fake());
  }
}
