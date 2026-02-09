import 'product_entity.dart';
import 'user_entity.dart';

void main() {
  // Single fake instance
  final product = ProductEntityMock.fake();
  print('Product: ${product.productName} (${product.status})');
  print('  Options: ${product.options.length}');
  print('  Description: ${product.description}');
  print('');

  // Fake list
  final products = ProductEntityMock.fakeList(3);
  print('Generated ${products.length} products:');
  for (final p in products) {
    print('  - ${p.productName}: ${p.productOption.optionName}');
  }
  print('');

  // User with various types
  final user = UserEntityMock.fake();
  print('User: ${user.name}');
  print('  Email: ${user.email}');
  print('  Phone: ${user.phoneNumber}');
  print('  Website: ${user.website}');
  print('  Active: ${user.isActive}');
  print('  Rating: ${user.rating}');
  print('  Address: ${user.address}');
  print('  Tags: ${user.tags}');
  print('  Roles: ${user.roles}');
  print('  Session: ${user.sessionDuration}');
  print('  Profile URL: ${user.profileUrl}');
  print('');

  // User list
  final users = UserEntityMock.fakeList(3);
  print('Generated ${users.length} users:');
  for (final u in users) {
    print('  - ${u.name} <${u.email}>');
  }
}
