import "package:faker/faker.dart";
import "package:uuid/uuid.dart";

mixin MockFactory<T> {
  Faker get faker => Faker(seed: DateTime.now().microsecondsSinceEpoch);

  /// Creates a fake uuid.
  String createFakeUuid() {
    return const Uuid().v4();
  }

  T generateFake();

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}
