import 'package:wedding_event_planner/data/datasources/user_remote_datasource.dart';
import 'package:wedding_event_planner/domain/entities/user.dart';
import 'package:wedding_event_planner/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource userRemoteDataSource;

  AuthRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final response = await userRemoteDataSource.login(email, password);
    return User.fromJson(response);
  }

  @override
  Future<User> register(String name, String email, String password) async {
    final response = await userRemoteDataSource.register(name, email, password);
    return User.fromJson(response);
  }

  @override
  Future<User> getProfile(String token) async {
    final response = await userRemoteDataSource.getProfile(token);
    return User.fromJson(response);
  }
}
