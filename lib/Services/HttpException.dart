// this cluss is to catch errors and name them as desired

class httpException implements Exception {
  String message;

  httpException(this.message);

  @override
  String toString() {
    return message;
  }
}
