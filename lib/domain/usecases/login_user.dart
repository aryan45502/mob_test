import '../repositories/user_repository.dart';
import '../entities/user.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User> execute(String email, String password) {
    return repository.login(email, password);
  }
}