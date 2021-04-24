class HTTPException implements Exception {
  final String errorMsg;

  HTTPException(this.errorMsg);

  @override
  String toString() {
    return errorMsg;
  }
}
