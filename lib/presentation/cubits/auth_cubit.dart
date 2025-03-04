import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../presentation/pages/vendor_services_page.dart';
import '../../presentation/pages/login_page.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  // ✅ Fix: Check if user is already logged in
  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VendorServicesPage()),
      );
    }
  }

  // ✅ Fix: Register User
  Future<void> register(String name, String email, String password, BuildContext context) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(name, email, password);
      emit(AuthSuccess(user));

      // ✅ Navigate to Login Page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      emit(AuthFailure("Registration failed. Try again later."));
    }
  }

  // ✅ Fix: Login User
  Future<void> login(String email, String password, BuildContext context) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(email, password);

      // ✅ Save login state
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      emit(AuthSuccess(user));

      // ✅ Navigate to Vendor Services Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VendorServicesPage()),
      );
    } catch (e) {
      emit(AuthFailure("Invalid email or password. Please try again."));
    }
  }

  // ✅ Fix: Logout User
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    emit(AuthInitial());

    // ✅ Navigate back to Login Page after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // ✅ Clears navigation stack
    );
  }
}
