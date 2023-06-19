import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication/viewModel/current_user/current_user_cubit.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.read<UserCubit>().state!.codeModel.company)),
    );
  }
}
