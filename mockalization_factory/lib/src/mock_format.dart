/// Defines the format for generating fake data values.
///
/// Used with `@MockProperty(format: MockFormat.email)` to specify
/// what kind of realistic fake data should be generated for a field.
enum MockFormat {
  // -- Person --
  firstName,
  lastName,
  fullName,

  // -- Internet --
  email,
  url,
  ipv4,
  ipv6,
  userName,
  password,
  userAgent,
  domainName,

  // -- Address --
  streetAddress,
  city,
  country,
  zipCode,
  latitude,
  longitude,

  // -- Phone --
  phoneNumber,

  // -- Company --
  companyName,
  companySuffix,

  // -- Lorem --
  word,
  sentence,
  paragraph,

  // -- Date (String representations) --
  dateTime,
  past,
  future,

  // -- Color --
  hexColor,
  colorName,

  // -- Finance --
  creditCard,
  currencyCode,
  currencyName,

  // -- Misc --
  uuid,
  barcode,
}
