import 'package:mockalization_factory/mockalization_factory.dart';

part 'product_option_entity.g.dart';

@Mockalization()
class ProductOptionEntity {
  final int optionId;

  @MockProperty(format: MockFormat.word)
  final String optionName;

  final DateTime createdAt;

  @MockProperty(min: 100, max: 50000)
  final double price;

  ProductOptionEntity({
    required this.optionId,
    required this.optionName,
    required this.createdAt,
    required this.price,
  });
}
