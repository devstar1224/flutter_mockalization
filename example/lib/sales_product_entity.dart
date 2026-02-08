import 'package:mockalization_factory/mockalization_factory.dart';

import 'enums/product_status.dart';
import 'product_entity.dart';
import 'product_option_entity.dart';

part 'sales_product_entity.g.dart';

@Mockalization()
class SalesProductEntity extends ProductEntity {
  @MockProperty(min: 0, max: 1000)
  final int saleQuantity;

  @MockProperty(min: 0.0, max: 0.5)
  final double? discountRate;

  SalesProductEntity({
    required this.saleQuantity,
    this.discountRate,
    required super.productId,
    required super.productName,
    super.description,
    required super.productOption,
    required super.options,
    required super.status,
    required super.createdAt,
  });
}
