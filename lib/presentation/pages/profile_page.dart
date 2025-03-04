import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().logout(context);
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
