import 'package:mockalization_example/product_option_entity.dart';
import 'package:mockalization_factory/mockalization_factory.dart';

part 'product_entity.g.dart';

@Mockalization()
class ProductEntity {
  @MockProperty(length: 20)
  final int productId;

  final String productName;

  final ProductOptionEntity productOption;

  final DateTime createdAt;

  ProductEntity({
    required this.productId,
    required this.productName,
    required this.productOption,
    required this.createdAt,
  });
}
