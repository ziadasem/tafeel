class CustomError implements Exception {
  String cause;
  CustomError(this.cause);
}