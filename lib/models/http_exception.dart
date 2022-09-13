class HttpException implements Exception {
  final String? message;
  HttpException(String s, {
    this.message,
  });

  @override
  String toString() {
    return message!;
    //return super.toString();
  }
}
