import 'package:mockalization_factory/mockalization_factory.dart';

import 'enums/product_status.dart';
import 'product_option_entity.dart';

part 'product_entity.g.dart';

@Mockalization()
class ProductEntity {
  final int productId;

  @MockProperty(format: MockFormat.word)
  final String productName;

  final String? description;

  final ProductOptionEntity productOption;

  @MockProperty(length: 3)
  final List<ProductOptionEntity> options;

  final ProductStatus status;

  final DateTime createdAt;

  ProductEntity({
    required this.productId,
    required this.productName,
    this.description,
    required this.productOption,
    required this.options,
    required this.status,
    required this.createdAt,
  });
}
