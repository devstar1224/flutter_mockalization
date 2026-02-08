import '../field_context.dart';

/// Maps MockFormat enum values to faker API call expressions.
class FormatExpression {
  static String create(FieldContext ctx) {
    final formatName = ctx.mockPropertyConfig!.formatName!;

    return switch (formatName) {
      // Person
      'firstName' => 'faker.person.firstName()',
      'lastName' => 'faker.person.lastName()',
      'fullName' => 'faker.person.name()',

      // Internet
      'email' => 'faker.internet.email()',
      'url' => "faker.internet.httpsUrl()",
      'ipv4' => 'faker.internet.ipv4Address()',
      'ipv6' => 'faker.internet.ipv6Address()',
      'userName' => 'faker.internet.userName()',
      'password' => 'faker.internet.password()',
      'userAgent' => 'faker.internet.userAgent()',
      'domainName' => 'faker.internet.domainName()',

      // Address
      'streetAddress' => 'faker.address.streetAddress()',
      'city' => 'faker.address.city()',
      'country' => 'faker.address.country()',
      'zipCode' => 'faker.address.zipCode()',
      'latitude' => 'faker.address.latitude()',
      'longitude' => 'faker.address.longitude()',

      // Phone
      'phoneNumber' => 'faker.phoneNumber.us()',

      // Company
      'companyName' => 'faker.company.name()',
      'companySuffix' => 'faker.company.suffix()',

      // Lorem
      'word' => 'faker.lorem.word()',
      'sentence' => 'faker.lorem.sentence()',
      'paragraph' => 'faker.lorem.sentences(3).join(" ")',

      // Date (String representations)
      'dateTime' => 'faker.date.dateTime().toIso8601String()',
      'past' =>
        'faker.date.dateTimeBetween(DateTime(2000), DateTime.now()).toIso8601String()',
      'future' =>
        'faker.date.dateTimeBetween(DateTime.now(), DateTime(2030)).toIso8601String()',

      // Color
      'hexColor' => 'faker.color.rgbColor()',
      'colorName' => 'faker.color.color()',

      // Finance
      'creditCard' =>
        'faker.randomGenerator.fromCharSet("0123456789", 16)',
      'currencyCode' =>
        "faker.randomGenerator.element(['USD', 'EUR', 'GBP', 'JPY', 'KRW', 'CNY'])",
      'currencyName' =>
        "faker.randomGenerator.element(['Dollar', 'Euro', 'Pound', 'Yen', 'Won', 'Yuan'])",

      // Misc
      'uuid' => 'const Uuid().v4()',
      'barcode' =>
        'faker.randomGenerator.fromCharSet("0123456789", 13)',

      _ => throw UnsupportedError('Unknown MockFormat: $formatName'),
    };
  }
}
