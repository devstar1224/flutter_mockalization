class MockProperty {
  /// String, int 에서만 지원
  final int? length;

  /// String 타입 선언의 DateTime 포멧만 지원중
  final Type? formatType;

  const MockProperty({
    this.length,
    this.formatType,
  });
}
