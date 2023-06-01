class ErrorDataException implements Exception {
  final String? message;

  ErrorDataException(this.message);

  @override
  String toString() => 'Error: $message';
}
