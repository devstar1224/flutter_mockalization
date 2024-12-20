import 'package:mockalization_example/product_entity.dart';
import 'package:mockalization_example/product_option_entity.dart';
import 'package:mockalization_factory/mockalization_factory.dart';

part 'sales_product_entity.g.dart';

@Mockalization()
class SalesProductEntity extends ProductEntity {
  final int saleQuantity;

  SalesProductEntity({
    required this.saleQuantity,
    required super.productId,
    required super.productName,
    required super.productOption,
    required super.createdAt,
  });
}
