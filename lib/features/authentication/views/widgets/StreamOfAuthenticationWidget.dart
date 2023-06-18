import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return Center(child: Text(context.read<UserCubit>().state!.isAdmin.toString()),);
          }else if(snapshot.data is CheckAuthBlocked){
            return const BlockedCodeWidget();
          }else if(snapshot.data is CheckAuthPermissionRejected){
            return const PermissionRejectedWidget();
          } else if(snapshot.data is CheckAuthPermissionRejectedPermanently){
            return const PermissionRejectedPermanentlyWidget();
          }else{
            return const RegisterWidget();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PermissionRejectedPermanentlyWidget extends StatelessWidget {
  const PermissionRejectedPermanentlyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
            color: Colors.black54
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  const [
            Text(textAlign: TextAlign.center,"You can not use the app without accepting phone permission"),
            SizedBox(height: 8,),
            Text(textAlign: TextAlign.center,"Please enable phone permission from app settings"),
          ],
        ),
      ),
    );
  }
}
