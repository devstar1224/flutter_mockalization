import 'package:mockalization_factory/mockalization_factory.dart';

part 'product_option_entity.g.dart';

@Mockalization()
class ProductOptionEntity {
  final int optionId;
  final String optionName;
  final DateTime createdAt;

  @MockIgnore()
  final int price;

  ProductOptionEntity({
    required this.optionId,
    required this.optionName,
    required this.createdAt,
    this.price = 0,
  });
}
