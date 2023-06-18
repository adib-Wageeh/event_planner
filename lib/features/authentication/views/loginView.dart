import 'package:event_planner/features/authentication/views/widgets/StreamOfAuthenticationWidget.dart';
import 'package:event_planner/features/authentication/views/widgets/errorMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewModel/checkAuth/check_auth_cubit.dart';
import '../viewModel/connectivity/connectivity_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: StreamBuilder<ConnectivityState>(
        stream: context.read<ConnectivityCubit>().stream,
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isConnected) {
              context.read<CheckAuthCubit>().checkAuth();
              return const StreamOfAuthenticationWidget();
          }else{
            Navigator.of(context).popUntil((route) => route.isFirst);
            return const ErrorMessageWidget();
          }
        }
        return const Center(child: CircularProgressIndicator());
      }
      ),

    );
  }
}