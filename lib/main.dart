import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_event_planner/data/datasources/user_remote_datasource.dart';
import 'package:wedding_event_planner/data/datasources/vendor_remote_datasource.dart';
import 'package:wedding_event_planner/data/datasources/booking_remote_datasource.dart';
import 'package:wedding_event_planner/domain/repositories/auth_repository_impl.dart';
import 'package:wedding_event_planner/domain/repositories/vendor_repository_impl.dart';
import 'package:wedding_event_planner/domain/repositories/booking_repository_impl.dart';
import 'package:wedding_event_planner/domain/repositories/auth_repository.dart';
import 'package:wedding_event_planner/domain/repositories/vendor_repository.dart';
import 'package:wedding_event_planner/domain/repositories/booking_repository.dart';
import 'package:wedding_event_planner/presentation/cubits/auth_cubit.dart';
import 'package:wedding_event_planner/presentation/cubits/vendor_cubit.dart';
import 'package:wedding_event_planner/presentation/cubits/booking_cubit.dart';
import 'package:wedding_event_planner/presentation/pages/login_page.dart';

void main() {
  final String baseUrl = 'http://192.168.2.118:5000/api';  // Ensure this is your correct API URL

  // **Create Data Sources**
  final userRemoteDataSource = UserRemoteDataSource(baseUrl: baseUrl);
  final vendorRemoteDataSource = VendorRemoteDataSource(baseUrl: baseUrl);
  final bookingRemoteDataSource = BookingRemoteDataSource(baseUrl: baseUrl);

  // **Create Repositories**
  final AuthRepository authRepository = AuthRepositoryImpl(userRemoteDataSource: userRemoteDataSource);
  final VendorRepository vendorRepository = VendorRepositoryImpl(vendorRemoteDataSource: vendorRemoteDataSource);
  final BookingRepository bookingRepository = BookingRepositoryImpl(bookingRemoteDataSource: bookingRemoteDataSource);

  runApp(MyApp(
    authRepository: authRepository,
    vendorRepository: vendorRepository,
    bookingRepository: bookingRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final VendorRepository vendorRepository;
  final BookingRepository bookingRepository;

  const MyApp({
    Key? key,
    required this.authRepository,
    required this.vendorRepository,
    required this.bookingRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(authRepository: authRepository)),
        BlocProvider(create: (_) => VendorCubit(vendorRepository: vendorRepository)),
        BlocProvider(create: (_) => BookingCubit(bookingRepository: bookingRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),  // ✅ Start from LoginPage
      ),
    );
  }
}
