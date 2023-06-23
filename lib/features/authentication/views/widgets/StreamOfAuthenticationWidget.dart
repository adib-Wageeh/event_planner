import 'package:event_planner/features/adminHome/viewModel/getEvents/get_events_cubit.dart';
import 'package:event_planner/features/authentication/viewModel/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../adminHome/views/admin_home_view.dart';
import '../../../userHome/views/user_home_view.dart';
import '../../viewModel/checkAuth/check_auth_cubit.dart';
import '../../viewModel/current_user/current_user_cubit.dart';
import 'BlockedMessageWidget.dart';
import 'PermissionRejectedWidget.dart';
import 'RegisterWidget.dart';

class StreamOfAuthenticationWidget extends StatelessWidget {
  const StreamOfAuthenticationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CheckAuthState>(
      stream: context.watch<CheckAuthCubit>().stream,
      builder: (context,snapshot){
        if(snapshot.hasData){
          if(snapshot.data is CheckAuthLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.data is CheckAuthAuthenticated){
            context.read<UserCubit>().setUser((snapshot.data as CheckAuthAuthenticated).userModel);
            context.read<RegisterCubit>().closeCubit();
            context.read<GetEventsCubit>().getEvents(context.read<UserCubit>().state!.codeModel.id);
            if(context.read<UserCubit>().state!.isAdmin){
              return const AdminHomeView();
            }else{
              return const UserHomeView();
            }
          }else if(snapshot.data is CheckAuthBlocked){
            return const BlockedCodeWidget();
          }else if(snapshot.data is CheckAuthPermissionRejected){
            return PermissionRejectedWidget(permission: (snapshot.data as CheckAuthPermissionRejected).permission,);
          }else{
            return const RegisterWidget();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
