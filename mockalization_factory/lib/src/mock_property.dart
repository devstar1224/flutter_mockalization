class MockProperty {
  /// 최대 길이
  /// String, List 에서만 지원
  final int? length;

  /// 최대값
  /// int 에서만 지원
  final int? max;

  /// 최소값
  /// int 에서만 지원
  final int? min;

  /// 커스텀 fixed 값 [String, int, bool] 지원 및 나열한 타입의 List Generic 을 가진 타입만 허용
  final Object? value;

  /// String 타입 선언의 DateTime 포멧만 지원중
  final Type? formatType;

  const MockProperty({
    this.length,
    this.value,
    this.max,
    this.min,
    this.formatType,
  });
}
