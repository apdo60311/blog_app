class AuthServerException implements Exception {
  final String message;
  AuthServerException({required this.message});
}

class BlogServerException implements Exception {
  final String message;
  BlogServerException({required this.message});
}
