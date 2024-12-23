To generate `g.dart` files using the generator in your library, you can follow these steps:

1. **Add Dependencies**:
   Ensure you have the necessary dependencies in your `pubspec.yaml` file:

   ```yaml
   dependencies:
     mockalization_factory:
   
   dev_dependencies:
     build_runner:
     mockalization_generator:
   ```

2. **Annotate Your Data Classes**:
   Use the annotations from `mockalization_factory` in your data classes.

   ```dart
   import 'package:mockalization_factory/mockalization_factory.dart';

   part 'my_class.g.dart';

   @Mockalization()
   class MyClass {
     final String name;
     final int age;

     MyClass({required this.name, required this.age});
   }
   ```

3. **Run the Generator**:
   Use the following command to generate the `g.dart` files:

   ```bash
   flutter pub run build_runner build
   ```

   Generated `g.dart` file

   ```dart
   part of 'my_class.dart';
   
   class MyClassMockFactory with MockFactory<MyClass> {
     @override
     MyClass generateFake() {
       return MyClass(
         name: faker.randomGenerator.string(10),
         age: faker.randomGenerator.integer(9999),
       );
     }
   }
   ```

   This will generate the necessary `g.dart` files for your annotated classes.
