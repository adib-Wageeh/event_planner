import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewModel/connectivity/connectivity_cubit.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No internet connection.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<ConnectivityCubit>(context)
                  .initConnectivity();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}